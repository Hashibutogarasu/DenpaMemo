import 'package:cuid2/cuid2.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'log_bus.dart';
import 'log_entry.dart';

/// Records every GraphQL operation passed through this [Link] into
/// [LogBus] as a [LogEntry.network], then forwards the request to the
/// next link unchanged.
class LoggingGraphQLLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final startedAt = DateTime.now();
    final stopwatch = Stopwatch()..start();
    try {
      await for (final response in forward!(request)) {
        final hasErrors = response.errors?.isNotEmpty ?? false;
        LogBus.instance.addNetwork(
          LogEntry.network(
            id: cuid(),
            timestamp: startedAt,
            level: hasErrors ? LogLevel.error : LogLevel.info,
            protocol: NetworkProtocol.graphql,
            operation: request.operation.operationName,
            requestBody: request.variables.isEmpty
                ? null
                : request.variables.toString(),
            responseBody: response.data?.toString(),
            errorMessage: hasErrors ? response.errors.toString() : null,
            duration: stopwatch.elapsed,
          ),
        );
        yield response;
      }
    } catch (error) {
      LogBus.instance.addNetwork(
        LogEntry.network(
          id: cuid(),
          timestamp: startedAt,
          level: LogLevel.error,
          protocol: NetworkProtocol.graphql,
          operation: request.operation.operationName,
          errorMessage: error.toString(),
          duration: stopwatch.elapsed,
        ),
      );
      rethrow;
    }
  }
}
