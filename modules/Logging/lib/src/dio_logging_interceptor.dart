import 'dart:convert';

import 'package:cuid2/cuid2.dart';
import 'package:dio/dio.dart';

import 'log_bus.dart';
import 'log_entry.dart';

/// Keys a request handler (e.g. `graphql_client`'s `DioGraphQlLink`) sets
/// under [RequestOptions.extra] to pass GraphQL metadata through to
/// [DioLoggingInterceptor], which has no protocol awareness of its own.
abstract final class DioLoggingExtraKeys {
  static const graphQl = 'app_logging.graphql';
  static const operationName = 'app_logging.operationName';
  static const variables = 'app_logging.variables';
}

/// Records every request sent through the [Dio] this is attached to into
/// [LogBus] as a [LogEntry.network], then forwards it unchanged — the
/// single capture point for both REST and GraphQL traffic on that [Dio].
class DioLoggingInterceptor extends Interceptor {
  static const _startedAtKey = 'app_logging.startedAt';
  static const _stopwatchKey = 'app_logging.stopwatch';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtKey] = DateTime.now();
    options.extra[_stopwatchKey] = Stopwatch()..start();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;
    final isGraphQl = options.extra[DioLoggingExtraKeys.graphQl] == true;
    final hasErrors = isGraphQl
        ? _hasGraphQlErrors(response.data)
        : (response.statusCode ?? 0) >= 400;
    LogBus.instance.addNetwork(
      LogEntry.network(
        id: cuid(),
        timestamp: _startedAt(options),
        level: hasErrors ? LogLevel.error : LogLevel.info,
        protocol: isGraphQl ? NetworkProtocol.graphql : NetworkProtocol.rest,
        operation: isGraphQl
            ? options.extra[DioLoggingExtraKeys.operationName] as String?
            : '${options.method} ${options.uri.path}',
        requestBody: isGraphQl
            ? options.extra[DioLoggingExtraKeys.variables]?.toString()
            : (options.data is String ? options.data as String : null),
        responseBody: response.data?.toString(),
        statusCode: response.statusCode,
        duration: _elapsed(options),
      ),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final isGraphQl = options.extra[DioLoggingExtraKeys.graphQl] == true;
    final isCancellation = err.type == DioExceptionType.cancel;
    LogBus.instance.addNetwork(
      LogEntry.network(
        id: cuid(),
        timestamp: _startedAt(options),
        level: isCancellation ? LogLevel.info : LogLevel.error,
        protocol: isGraphQl ? NetworkProtocol.graphql : NetworkProtocol.rest,
        operation: isGraphQl
            ? options.extra[DioLoggingExtraKeys.operationName] as String?
            : '${options.method} ${options.uri.path}',
        requestBody: isGraphQl
            ? options.extra[DioLoggingExtraKeys.variables]?.toString()
            : (options.data is String ? options.data as String : null),
        responseBody: err.response?.data?.toString(),
        statusCode: err.response?.statusCode,
        errorMessage: isCancellation
            ? 'cancelled'
            : (err.message ?? err.toString()),
        duration: _elapsed(options),
      ),
    );
    handler.next(err);
  }

  DateTime _startedAt(RequestOptions options) =>
      options.extra[_startedAtKey] as DateTime? ?? DateTime.now();

  Duration? _elapsed(RequestOptions options) =>
      (options.extra[_stopwatchKey] as Stopwatch?)?.elapsed;

  /// GraphQL can respond with HTTP 200 while still carrying a non-empty
  /// top-level `errors` array, so success is only knowable by inspecting
  /// the decoded body rather than the status code.
  bool _hasGraphQlErrors(dynamic data) {
    try {
      final decoded = data is String ? jsonDecode(data) : data;
      if (decoded is Map<String, dynamic>) {
        final errors = decoded['errors'];
        return errors is List && errors.isNotEmpty;
      }
    } catch (_) {}
    return false;
  }
}
