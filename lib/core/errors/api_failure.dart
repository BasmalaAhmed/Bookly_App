import 'package:bookly_app/core/errors/failures.dart';
import 'package:dio/dio.dart';

class ApiFailure extends Failure {
  ApiFailure(super.message);
  static const defaultMessage =
      'Oops, there was an error. Please try again later.';

  factory ApiFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiFailure('Connection timeout with server');
      case DioExceptionType.sendTimeout:
        return ApiFailure('Send timeout with server');
      case DioExceptionType.receiveTimeout:
        return ApiFailure('Receive timeout with server');
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode ?? 500;
        final response = dioException.response?.data ?? {};
        return ApiFailure.fromResponse(statusCode, response);
      case DioExceptionType.cancel:
        return ApiFailure('Request to server was cancelled');
      case DioExceptionType.connectionError:
        return ApiFailure('No internet connection');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        return ApiFailure(defaultMessage);
    }
  }

  factory ApiFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ApiFailure(
        response['error']?['message'] ?? response['message'] ?? defaultMessage,
      );
    } else if (statusCode == 404) {
      return ApiFailure('Your request is not found, please try again later.');
    } else if (statusCode == 503) {
      return ApiFailure(
        'The service is temporarily unavailable. Please try again in a moment.',
      );
    } else if (statusCode >= 500) {
      return ApiFailure('Internal server error, please try again later.');
    } else {
      return ApiFailure(defaultMessage);
    }
  }
}
