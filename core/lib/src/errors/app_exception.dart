import '../../core.dart';

final class AppException implements Exception {
  final AppExceptionType type;
  final String? _message;

  AppException({
    required this.type,
    String? message,
  }) : _message = message;

  const AppException.empty()
      : type = AppExceptionType.unknown,
        _message = '';

  factory AppException.unknown({
    String? message,
  }) {
    return AppException(
      type: AppExceptionType.unknown,
      message: message,
    );
  }

  String toLocalizedText() {
    return switch (type) {
      AppExceptionType.unknown => LocaleKeys.errors_unknown.tr(),
      AppExceptionType.networkError => LocaleKeys.errors_networkError.tr(),
      AppExceptionType.badRequest => LocaleKeys.errors_badRequest.tr(),
      AppExceptionType.notFound => LocaleKeys.errors_notFound.tr(),
      AppExceptionType.internalServerError =>
        LocaleKeys.errors_internalServerError.tr(),
      AppExceptionType.timeout => LocaleKeys.errors_timeout.tr(),
    };
  }

  @override
  String toString() => '${type.name} : ${_message ?? 'No additional data'}';
}

enum AppExceptionType {
  unknown,
  networkError,
  badRequest,
  notFound,
  internalServerError,
  timeout,
}
