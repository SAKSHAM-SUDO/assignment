import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final bool showLoader;
  final Dio dio;
  ApiInterceptor({required this.showLoader, required this.dio});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "clientCode": "CAM"
    };

    options.headers.addAll(headers);

    var request = options.data;

    if (request.runtimeType == FormData) {
      request as FormData;
      for (var i in request.fields) {
        log("\x1B[36m${i.key}: ${i.value}\x1B[0m");
      }
    } else {
      if (options.method == "POST") {
        request = jsonEncode(options.data);
      } else {
        request = jsonEncode(options.queryParameters);
      }
      log("\x1B[35m[${options.method}] ${options.path}\x1B[0m \x1B[0m \x1B[36m\nRequest: ${request.toString()}");

      if (options.queryParameters.isNotEmpty) {
        log("\x1B[36m\nQuery Parameters: ${options.queryParameters.toString()}");
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Response: ${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log('\x1B[31mERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\x1B[0m');
    log(err.message);

    switch (err.type) {
      case DioErrorType.connectTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.sendTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw NotFoundException(err.requestOptions);

          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 413:
            throw UnauthorizedException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
          case 503:
            throw InternalServerErrorException(err.requestOptions);
          case 502:
            throw InternalServerErrorException(err.requestOptions);
          case 504:
            throw InternalServerErrorException(err.requestOptions);
          default:
            throw InternalServerErrorException(err.requestOptions);
        }
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw SomethingWentWrongException(err.requestOptions);
    }
    return super.onError(err, handler);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later. $message';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class SomethingWentWrongException extends DioError {
  SomethingWentWrongException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Something went wrong, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
