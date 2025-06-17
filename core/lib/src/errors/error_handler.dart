import '../../core.dart';
import 'app_exception.dart';

final class ErrorHandler {
  Never handleError(Object exception) {
    throw _parseError(exception);
  }

  AppException _parseError(Object exception) {
    final AppException appException;

    if (exception is AppException) {
      return exception;
    } else if (exception is DioException) {
      appException = _parseDioException(exception);
    } else {
      appException = AppException.unknown();
    }

    return appException;
  }

  AppException _parseDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout =>
        AppException(type: AppExceptionType.timeout),
      DioExceptionType.sendTimeout =>
        AppException(type: AppExceptionType.timeout),
      DioExceptionType.receiveTimeout =>
        AppException(type: AppExceptionType.timeout),
      DioExceptionType.badResponse => _mapStatusCodeToException(
          exception.response?.statusCode,
        ),
      DioExceptionType.connectionError =>
        AppException(type: AppExceptionType.networkError),
      _ => AppException(type: AppExceptionType.unknown),
    };
  }

  AppException _mapStatusCodeToException(int? statusCode) {
    return switch (statusCode) {
      400 => AppException(type: AppExceptionType.badRequest),
      404 => AppException(type: AppExceptionType.notFound),
      500 => AppException(type: AppExceptionType.internalServerError),
      _ => AppException.unknown(message: 'HTTP ${statusCode ?? 'unknown'}'),
    };
  }
}
