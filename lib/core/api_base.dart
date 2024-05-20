import 'package:dio/dio.dart';

class ApiBase {
  static final _dio = Dio();

  static Future<Response> getRequest(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get(path,
        queryParameters: queryParameters,
        options: Options(
            contentType: "application/json",
            responseType: ResponseType.plain,
            headers: {
              "Authorization":
                  "XlOiJ7627zyWgEFNlJICW08KgA2x7ipYN5TeFz13i4wXIm0fpZ2DraEx",
              "Content-Type": "application/json"
            }));

    return response;
  }
}
