import 'package:dio/dio.dart';

/// Base API exception used across repositories
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Object? originalError;

  const ApiException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() => 'ApiException(statusCode: ' '$statusCode' ', message: ' '$message' ')';

  /// Map DioException to ApiException with readable messages
  static ApiException fromDio(Object error) {
    if (error is DioException) {
      final response = error.response;
      final code = response?.statusCode;
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiException(message: 'Network timeout. Please try again.', statusCode: code, originalError: error);
        case DioExceptionType.cancel:
          return ApiException(message: 'Request cancelled.', statusCode: code, originalError: error);
        case DioExceptionType.badCertificate:
          return ApiException(message: 'Bad certificate.', statusCode: code, originalError: error);
        case DioExceptionType.badResponse:
          return ApiException(message: _messageForStatus(code), statusCode: code, originalError: error);
        case DioExceptionType.connectionError:
          return ApiException(message: 'No internet connection.', statusCode: code, originalError: error);
        case DioExceptionType.unknown:
          return ApiException(message: 'Unexpected error occurred.', statusCode: code, originalError: error);
      }
    }
    return ApiException(message: 'Unexpected error occurred.', originalError: error);
  }

  static String _messageForStatus(int? status) {
    if (status == null) return 'Server error.';
    if (status >= 500) return 'Server error ($status). Please try again later.';
    if (status == 404) return 'Not found (404).';
    if (status == 401 || status == 403) return 'Unauthorized. Please login again.';
    return 'Request failed ($status).';
  }
}
