import 'package:dio/dio.dart';

/// Base class for failures produced while performing network I/O.
sealed class NetworkFailure implements Exception {
  const NetworkFailure({this.cause, this.stackTrace});

  final Object? cause;
  final StackTrace? stackTrace;
}

/// Indicates that a request was rejected because the device is offline.
final class OfflineNetworkException extends NetworkFailure {
  const OfflineNetworkException({
    this.isTimeout = false,
    super.cause,
    super.stackTrace,
  });

  final bool isTimeout;
}

/// Indicates that a request exceeded a connection, send, or receive timeout.
final class NetworkTimeoutException extends NetworkFailure {
  const NetworkTimeoutException({
    required this.type,
    super.cause,
    super.stackTrace,
  });

  final DioExceptionType type;
}

/// Indicates that a request failed before receiving an HTTP response.
final class NetworkConnectionException extends NetworkFailure {
  const NetworkConnectionException({super.cause, super.stackTrace});
}

/// Indicates that a request was cancelled by its caller.
final class NetworkCancellationException extends NetworkFailure {
  const NetworkCancellationException({super.cause, super.stackTrace});
}

/// Indicates that a server returned an HTTP response with an error status.
final class HttpNetworkException extends NetworkFailure {
  const HttpNetworkException({
    required this.statusCode,
    super.cause,
    super.stackTrace,
  });

  final int statusCode;
}

/// Converts a Dio failure into a typed network failure.
NetworkFailure networkFailureFromDioException(
  DioException exception, {
  bool offline = false,
}) {
  if (offline || exception.error is OfflineNetworkException) {
    return OfflineNetworkException(
      isTimeout:
          exception.type == DioExceptionType.connectionTimeout ||
          exception.type == DioExceptionType.sendTimeout ||
          exception.type == DioExceptionType.receiveTimeout,
      cause: exception,
      stackTrace: exception.stackTrace,
    );
  }
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return NetworkTimeoutException(
        type: exception.type,
        cause: exception,
        stackTrace: exception.stackTrace,
      );
    case DioExceptionType.cancel:
      return NetworkCancellationException(
        cause: exception,
        stackTrace: exception.stackTrace,
      );
    default:
      return NetworkConnectionException(
        cause: exception,
        stackTrace: exception.stackTrace,
      );
  }
}
