import 'package:dio/dio.dart';

typedef HttpParser<T> = T Function(Map);

mixin http {
  final _dio = Dio();
  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? query,
    HttpParser? parser,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      url,
      queryParameters: query,
      cancelToken: cancelToken,
    );
    return parser != null ? parser(response.data) : response.data;
  }
}

extension PrivateHttp on http {
  Dio get dio => _dio;
}
