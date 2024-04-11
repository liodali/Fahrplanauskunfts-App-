import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:search_repository/src/http_mixin.dart';
import 'package:search_repository/src/location.dart';

class SearchRepository with http {
  String _server;
  SearchRepository() : _server = "https://mvvvip1.defas-fgi.de/mvv";

  Future<List<Location>> retrieveStartPoints(String text,{CancelToken? cancelToken,}) async {
    return get<List<Location>>(
      "$_server/XML_STOPFINDER_REQUEST",
      query: {
        "language": "de",
        "outputFormat": "RapidJSON",
        "coordOutputFormat": "WGS84[DD:ddddddd]",
        "type_sf": "any",
        "name_sf": text,
      },
      parser: (dataJson) => compute(
          (dataJson) => List.castFrom(dataJson["locations"])
              .map(
                (dJson) => Location.fromJson(
                  Map.from(dJson),
                ),
              )
              .toList(),
          dataJson),
    );
  }
}

extension PrivateExt on SearchRepository {
  void setServer(String server) {
    _server = server;
  }
}
