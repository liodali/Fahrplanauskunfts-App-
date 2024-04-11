import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:search_repository/src/http_mixin.dart';
import 'package:search_repository/src/location.dart';
import 'package:search_repository/src/repository.dart';

void main() {
  test("parse location", () {
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
    expect(location.id, "de:09187:42000");
    expect(location.name, "Ziegelberg (Kr RO), Hamberger");
    expect(location.productClasses, [6]);
    expect(location.isBest, false);
  });
  test('test and mock search repo', () async {
    final searchRepo = SearchRepository();
    searchRepo.setServer("https://test.com/mvv");
    final dioAdapter = DioAdapter(dio: searchRepo.dio);

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
                  {
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
                  },
                ],
              },
              // Reply would wait for one-sec before returning data.
              delay: const Duration(seconds: 1),
            ),
        queryParameters: {
          "language": "de",
          "outputFormat": "RapidJSON",
          "coordOutputFormat": "WGS84[DD:ddddddd]",
          "type_sf": "any",
          "name_sf": "berliner",
        });

    final locations = await searchRepo.retrieveStartPoints("berliner");
    expect(locations.length, 1);
    expect(locations.first.id, "de:09187:42000");
    expect(locations.first.name, "Ziegelberg (Kr RO), Hamberger");
  });
}
