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
  static const requestId = 'app_logging.id';
  static const skippedOffline = 'app_logging.skippedOffline';
}

/// Records every request sent through the [Dio] this is attached to into
/// [LogBus]: a [NetworkLogStatus.pending] entry as soon as it's sent, then
/// replaced (same id) by a success/error entry once it resolves — the
/// single capture point for both REST and GraphQL traffic on that [Dio].
class DioLoggingInterceptor extends Interceptor {
  DioLoggingInterceptor({bool Function()? isOffline}) : _isOffline = isOffline;

  static const _startedAtKey = 'app_logging.startedAt';
  static const _stopwatchKey = 'app_logging.stopwatch';

  final bool Function()? _isOffline;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[DioLoggingExtraKeys.requestId] = cuid();
    options.extra[_startedAtKey] = DateTime.now();
    options.extra[_stopwatchKey] = Stopwatch()..start();

    final isGraphQl = options.extra[DioLoggingExtraKeys.graphQl] == true;
    LogBus.instance.addNetwork(
      LogEntry.network(
        id: _id(options),
        timestamp: _startedAt(options),
        level: LogLevel.info,
        protocol: isGraphQl ? NetworkProtocol.graphql : NetworkProtocol.rest,
        status: NetworkLogStatus.pending,
        operation: _operation(options, isGraphQl),
        uri: options.uri.toString(),
        requestBody: _requestBody(options, isGraphQl),
        requestBytes: _byteLength(options.data),
      ),
    );
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
        id: _id(options),
        timestamp: _startedAt(options),
        level: hasErrors ? LogLevel.error : LogLevel.info,
        protocol: isGraphQl ? NetworkProtocol.graphql : NetworkProtocol.rest,
        status: hasErrors ? NetworkLogStatus.error : NetworkLogStatus.success,
        operation: _operation(options, isGraphQl),
        uri: options.uri.toString(),
        requestBody: _requestBody(options, isGraphQl),
        responseBody: _textBody(response.data),
        requestBytes: _byteLength(options.data),
        responseBytes: _byteLength(response.data),
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
    final isSkippedOffline =
        options.extra[DioLoggingExtraKeys.skippedOffline] == true ||
        (_isOffline?.call() ?? false);
    final isTimeout =
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout;
    LogBus.instance.addNetwork(
      LogEntry.network(
        id: _id(options),
        timestamp: _startedAt(options),
        level: isSkippedOffline
            ? LogLevel.warning
            : (isCancellation ? LogLevel.info : LogLevel.error),
        protocol: isGraphQl ? NetworkProtocol.graphql : NetworkProtocol.rest,
        status: isSkippedOffline
            ? NetworkLogStatus.skipped
            : NetworkLogStatus.error,
        operation: _operation(options, isGraphQl),
        uri: options.uri.toString(),
        requestBody: _requestBody(options, isGraphQl),
        responseBody: _textBody(err.response?.data),
        requestBytes: _byteLength(options.data),
        responseBytes: _byteLength(err.response?.data),
        statusCode: err.response?.statusCode,
        errorMessage: isSkippedOffline
            ? 'offline'
            : (isCancellation ? 'cancelled' : (err.message ?? err.toString())),
        duration: _elapsed(options),
        isTimeout: isTimeout,
      ),
    );
    handler.next(err);
  }

  String _id(RequestOptions options) =>
      options.extra[DioLoggingExtraKeys.requestId] as String;

  DateTime _startedAt(RequestOptions options) =>
      options.extra[_startedAtKey] as DateTime? ?? DateTime.now();

  Duration? _elapsed(RequestOptions options) =>
      (options.extra[_stopwatchKey] as Stopwatch?)?.elapsed;

  String _operation(RequestOptions options, bool isGraphQl) {
    final methodAndUri = '${options.method} ${options.uri}';
    if (!isGraphQl) return methodAndUri;
    final operationName = options.extra[DioLoggingExtraKeys.operationName];
    return operationName == null
        ? methodAndUri
        : '$methodAndUri · $operationName';
  }

  String? _requestBody(RequestOptions options, bool isGraphQl) => isGraphQl
      ? options.extra[DioLoggingExtraKeys.variables]?.toString()
      : _textBody(options.data);

  String? _textBody(dynamic data) =>
      data == null || data is List<int> ? null : data.toString();

  int? _byteLength(dynamic data) {
    if (data is String) return utf8.encode(data).length;
    if (data is List<int>) return data.length;
    return null;
  }

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
