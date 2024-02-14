import 'dart:developer';
import 'package:assignment/services/api_interceptor.dart';
import 'package:dio/dio.dart';

enum RequestType { get, post, put, patch }

class ApiService {
  static Future<Map<String, dynamic>> makeRequest(
    String url,
    RequestType requestType,
    dynamic parameter,
    dynamic headers, {
    bool? showLoader,
  }) async {
    var dio = Dio(BaseOptions(
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));
    dio.interceptors
        .add(ApiInterceptor(showLoader: showLoader ?? true, dio: dio));

    switch (requestType) {
      case RequestType.get:
        try {
          final Response response = await dio.get(
            url,
            queryParameters: parameter,
            options: Options(headers: headers),
          );

          return response.data;
        } catch (e) {
          log("$url : $e");
          return getErrorJson(e);
        }

      case RequestType.post:
        try {
          final Response response = await dio.post(
            url,
            data: parameter,
            options: Options(headers: headers),
          );

          return response.data;
        } catch (e) {
          log("$url : $e");
          return getErrorJson(e);
        }

      case RequestType.put:
        try {
          final Response response = await dio.put(
            url,
            data: parameter,
            options: Options(headers: headers),
          );

          return response.data;
        } catch (e) {
          log("$url : $e");
          return getErrorJson(e);
        }
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }

  static getErrorJson(dynamic error) {
    return {
      'errorCode': -1,
      'errorMessage': error.toString(),
      'errorMsg': error.toString(),
    };
  }
}
