abstract class Failure {
  const Failure();
}

abstract class BaseFailure extends Failure {
  const BaseFailure({
    required this.message,
    this.isRetryable = false,
    this.statusCode,
  });

  final String message;
  final bool isRetryable;
  final int? statusCode;
}

// Invalid credentials, email not confirmed, etc.
class AuthFailure extends BaseFailure {
  const AuthFailure({
    required super.message,
    super.statusCode,
    super.isRetryable,
  });
}

// Network failure, timeout, etc.
class NetworkFailure extends BaseFailure {
  const NetworkFailure({
    required super.message,
    super.statusCode,
    super.isRetryable,
  });
}

// 4xx or 5xx status code
class ServerFailure extends BaseFailure {
  const ServerFailure({
    required super.message,
    super.statusCode,
    super.isRetryable,
  });
}

// Input validation error
class ValidationFailure extends BaseFailure {
  const ValidationFailure({
    required super.message,
    super.statusCode,
    super.isRetryable,
  });
}

// Local storage failure, cache not found, etc.
class CacheFailure extends BaseFailure {
  const CacheFailure({
    required super.message,
    super.statusCode,
    super.isRetryable,
  });
}

// Unknown failure, unexpected error, etc.
class UnknownFailure extends BaseFailure {
  const UnknownFailure({
    required super.message,
    super.statusCode,
    super.isRetryable,
  });
}
