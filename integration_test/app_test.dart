import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:search_repository/src/repository.dart';
import 'package:timetabl_app/main.dart';
import 'package:search_repository/src/http_mixin.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/location_item.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/no_location_avalaible.dart';
import 'package:timetabl_app/src/view/widgets/error_widget.dart';
import 'package:timetabl_app/src/viewmodel/commons.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late final SearchRepository searchRepo;

  late final DioAdapter dioAdapter;

  const path = 'https://test.com/mvv/XML_STOPFINDER_REQUEST';
  setUpAll(() {
    searchRepo = SearchRepository();
    searchRepo.setServer("https://test.com/mvv");
    dioAdapter = DioAdapter(dio: searchRepo.dio);
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
                  {
                    "id": "de:09187:42000",
                    "isGlobalId": true,
                    "name": "Leipzig (Kr RO), Berliner",
                    "disassembledName": "Berliner",
                    "coord": [47.84607, 12.15869],
                    "type": "stop",
                    "matchQuality": 195,
                    "isBest": true,
                    "productClasses": [6],
                    "parent": {
                      "id": "placeID:9187177:48",
                      "name": "Ziegelberg (Kr RO)",
                      "type": "locality"
                    },
                    "properties": {"stopId": "1012389"}
                  },
                  {
                    "id": "de:09187:43000",
                    "isGlobalId": true,
                    "name": "Ziegelberg (Kr RO), Berliner, Hausnr 400",
                    "disassembledName": "Berliner",
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
                  },
                ],
              },
              // Reply would wait for one-sec before returning data.
              delay: const Duration(seconds: 5),
            ),
        queryParameters: {
          "language": "de",
          "outputFormat": "RapidJSON",
          "coordOutputFormat": "WGS84[DD:ddddddd]",
          "type_sf": "any",
          "name_sf": "berliner",
        });
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
                "locations": [],
              },
              // Reply would wait for one-sec before returning data.
              delay: const Duration(seconds: 5),
            ),
        queryParameters: {
          "language": "de",
          "outputFormat": "RapidJSON",
          "coordOutputFormat": "WGS84[DD:ddddddd]",
          "type_sf": "any",
          "name_sf": "abc",
        });
    dioAdapter.onGet(
        path,
        (server) => server.reply(
              400,
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
                "locations": [],
              },
              // Reply would wait for one-sec before returning data.
              delay: const Duration(seconds: 3),
            ),
        queryParameters: {
          "language": "de",
          "outputFormat": "RapidJSON",
          "coordOutputFormat": "WGS84[DD:ddddddd]",
          "type_sf": "any",
          "name_sf": "abcd",
        });
  });
  testWidgets("test app with no action", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithValue(searchRepo),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
    expect(find.byType(TextFormField), findsOne);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
  testWidgets("test app with error text field", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithValue(searchRepo),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextFormField), "ab");
    await tester.pump();
    expect(find.text("minimum seach text accepted should have 3 characters"),
        findsOne);
    final searchBt =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    expect(searchBt.onPressed, null);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
  testWidgets("test app with no data", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithValue(searchRepo),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextFormField), "abc");
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text("minimum seach text accepted should have 3 characters"),
        findsNothing);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    //await tester.press(find.text("Search"));
    await tester.tap(find.text("Search"));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOne);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(EmptyLocation), findsOne);
    expect(find.byIcon(Icons.location_searching), findsOne);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  });
  testWidgets("test app with error data", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithValue(searchRepo),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextFormField), "abcd");
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text("Search"));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOne);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byType(ErrorLocationWidget), findsOne);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOne);
    expect(find.byType(SnackBar), findsOne);
  });
  testWidgets("test app with data", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithValue(searchRepo),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextFormField), "berliner");
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text("Search"));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOne);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byType(ListView), findsOne);
    expect(find.byType(ListLocationItemWidget), findsNWidgets(2));
    expect(find.text("Leipzig (Kr RO), Berliner"), findsOne);
    expect(find.byIcon(Icons.star), findsOne);
    expect(find.byIcon(Icons.star_border), findsOne);
  });
}
