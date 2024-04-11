import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:search_repository/search_repository.dart';
import 'package:search_repository/src/http_mixin.dart';
import 'package:search_repository/src/repository.dart';
import 'package:timetabl_app/src/model/search_state.dart';
import 'package:timetabl_app/src/viewmodel/commons.dart';
import 'package:timetabl_app/src/viewmodel/search_vm.dart';

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

void main() {
  test("test search VM", () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final listener = Listener<IState>();

    container.listen<IState>(
      searchProvider,
      listener.call,
      fireImmediately: true,
    );

    final cstate = container.read(searchProvider);
    expect(cstate, NoState());
  });
  test("searchVM success request test", () async {
    final container = ProviderContainer();
    final location = Location.fromJson({
      "id": "de:09187:42000",
      "isGlobalId": true,
      "name": "Ziegelberg (Kr RO), Hamberger",
      "disassembledName": "Hamberger",
      "coord": [47.84607, 12.15869],
      "type": "stop",
      "matchQuality": 195,
      "isBest": false,
      "productClasses": [6],
      "parent": {
        "id": "placeID:9187177:48",
        "name": "Ziegelberg (Kr RO)",
        "type": "locality"
      },
      "properties": {"stopId": "1012389"}
    });
    addTearDown(container.dispose);
    final listener = Listener<SearchRepository>();
    final listenerState = Listener<IState>();

    container.listen<SearchRepository>(
      repositoryProvider,
      listener.call,
      fireImmediately: true,
    );
    container.listen<IState>(
      searchProvider,
      listenerState.call,
      fireImmediately: true,
    );
    final dioAdapter = DioAdapter(
      dio: container.read(repositoryProvider).dio,
    );
    container.read(repositoryProvider).setServer("https://test.com/mvv");
    const path = 'https://test.com/mvv/XML_STOPFINDER_REQUEST';

    dioAdapter.onGet(
        path,
        (server) => server.reply(
              200,
              {
                "version": "10.6.14.22",
                "systemMessages": [
                  {
                    "type": "error",
                    "module": "BROKER",
                    "code": -8011,
                    "text": ""
                  }
                ],
                "locations": [
                  location,
                ],
              },
              // Reply would wait for one-sec before returning data.
              delay: const Duration(seconds: 1),
            ),
        queryParameters: {
          "coordOutputFormat": "WGS84[DD:ddddddd]",
          "language": "de",
          "name_sf": "berliner",
          "outputFormat": "RapidJSON",
          "type_sf": "any",
        },
        data: null,
        headers: {});
    await container.read(searchProvider.notifier).searchStartPoint("berliner");
    expect(
      container.read(searchProvider),
      SearchState(
        location: [location],
      ),
    );
  });
  test("searchVM fail request test", () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final listener = Listener<SearchRepository>();
    final listenerState = Listener<IState>();

    container.listen<SearchRepository>(
      repositoryProvider,
      listener.call,
      fireImmediately: true,
    );
    container.listen<IState>(
      searchProvider,
      listenerState.call,
      fireImmediately: true,
    );
    final dioAdapter = DioAdapter(
      dio: container.read(repositoryProvider).dio,
    );
    container.read(repositoryProvider).setServer("https://test.com/mvv");
    const path = 'https://test.com/mvv/XML_STOPFINDER_REQUEST';

    dioAdapter.onGet(
      path,
      (server) => server.reply(
        400,
        {
          "version": "10.6.14.22",
        },
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      queryParameters: {
        "coordOutputFormat": "WGS84[DD:ddddddd]",
        "language": "de",
        "name_sf": "berliner",
        "outputFormat": "RapidJSON",
        "type_sf": "any",
      },
      data: null,
      headers: {},
    );
    await container.read(searchProvider.notifier).searchStartPoint("berliner");
    expect(
      container.read(searchProvider),
      ErrorState(error: "Ops!we cannot retrieve the data!"),
    );
  });
}
