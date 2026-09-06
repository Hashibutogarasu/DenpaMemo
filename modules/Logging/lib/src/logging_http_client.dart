import 'package:cuid2/cuid2.dart';
import 'package:http/http.dart' as http;

import 'log_bus.dart';
import 'log_entry.dart';

/// Wraps [inner] so every request sent through it is recorded into
/// [LogBus] as a [LogEntry.network], then delegates to [inner] unchanged.
class LoggingHttpClient extends http.BaseClient {
  LoggingHttpClient({http.Client? inner}) : _inner = inner ?? http.Client();

  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final startedAt = DateTime.now();
    final stopwatch = Stopwatch()..start();
    try {
      final response = await _inner.send(request);
      final body = await http.Response.fromStream(response);
      final hasErrorStatus = body.statusCode >= 400;
      LogBus.instance.addNetwork(
        LogEntry.network(
          id: cuid(),
          timestamp: startedAt,
          level: hasErrorStatus ? LogLevel.error : LogLevel.info,
          protocol: NetworkProtocol.rest,
          operation: '${request.method} ${request.url.path}',
          requestBody: request is http.Request ? request.body : null,
          responseBody: body.body,
          statusCode: body.statusCode,
          duration: stopwatch.elapsed,
        ),
      );
      return http.StreamedResponse(
        Stream.value(body.bodyBytes),
        body.statusCode,
        contentLength: body.contentLength,
        request: body.request,
        headers: body.headers,
        isRedirect: body.isRedirect,
        persistentConnection: body.persistentConnection,
        reasonPhrase: body.reasonPhrase,
      );
    } catch (error) {
      LogBus.instance.addNetwork(
        LogEntry.network(
          id: cuid(),
          timestamp: startedAt,
          level: LogLevel.error,
          protocol: NetworkProtocol.rest,
          operation: '${request.method} ${request.url.path}',
          errorMessage: error.toString(),
          duration: stopwatch.elapsed,
        ),
      );
      rethrow;
    }
  }
}
