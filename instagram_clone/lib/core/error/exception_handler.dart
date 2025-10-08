import 'package:dio/dio.dart';
import 'package:instagram_clone/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExceptionHandler {
  static BaseFailure handleException(Exception e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          return handleBadResponse(e);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
          return NetworkFailure(
            message: e.message ?? 'Unknown error',
          );
        case DioExceptionType.cancel:
          return const UnknownFailure(
            message: 'Request Canceled',
          );
        case DioExceptionType.unknown:
          return const UnknownFailure(
            message: 'Unknown error',
          );
      }
    }

    if (e is AuthApiException) {
      return AuthFailure(
        message: e.message,
      );
    }

    return const UnknownFailure(
      message: 'Unknown error',
    );
  }

  static BaseFailure handleBadResponse(DioException e) {
    switch (e.response?.statusCode) {
      /// 400 - Bad request
      case 400:
        return ServerFailure(
          message: e.message ?? 'Bad request',
        );

      /// 401 - Invalid credentials / Expired token
      case 401:
        return ServerFailure(
          message: e.message ?? 'Invalid credentials / Expired token',
        );

      /// 403 - No permission
      case 403:
        return ServerFailure(
          message: e.message ?? 'No permission',
        );

      /// 404 - Resource not found
      case 404:
        return ServerFailure(
          message: e.message ?? 'Resource not found',
        );

      /// 409 - Conflict
      case 409:
        return ServerFailure(
          message: e.message ?? 'Conflict',
        );

      /// 422 - Validation errors
      case 422:
        return ServerFailure(
          message: e.message ?? 'Validation errors',
        );

      /// 429 - Rate limited
      case 429:
        return ServerFailure(
          message: e.message ?? 'Rate limited',
        );

      /// 5xx - Server error
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: e.message ?? 'Server error',
        );

      default:
        return ServerFailure(
          message: e.message ?? 'Unknown error',
        );
    }
  }
}
