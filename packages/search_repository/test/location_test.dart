import 'package:flutter_test/flutter_test.dart';
import 'package:search_repository/src/location.dart';

void main() {
  test('test retrieve ortsname', () {
    final location = Location.fromJson({
      "id": "de:09187:42000",
      "isGlobalId": true,
      "name": "Ziegelberg (Kr RO), Hamberger, hausnr. 54",
      "disassembledName": "Hamberger, hausnr. 54",
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
    final match = location.disassembledName?.split(",").length == 2
        ? location.disassembledName?.split(",").last.trimLeft()
        : "";
    expect(match, "hausnr. 54");
  });
  test("test buildContent Location", () {
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

    final content = location.buildContent();
    expect(content, ["type: stop", "Match Quality: 195", "classes: 6"]);
  });
  test("test buildContent 2 Location", () {
    final location = Location.fromJson({
      "id": "de:09187:42000",
      "isGlobalId": true,
      "name": "Ziegelberg (Kr RO), Hamberger",
      "disassembledName": "Hamberger",
      "coord": [47.84607, 12.15869],
      "type": "poi",
      "matchQuality": 195,
      "isBest": false,
      //"productClasses": [6],
      "parent": {
        "id": "placeID:9187177:48",
        "name": "Ziegelberg (Kr RO)",
        "type": "locality"
      },
      "properties": {"stopId": "1012389"}
    });

    final content = location.buildContent();
    expect(content, ["type: poi", "Match Quality: 195"]);
  });
}
