import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Performs a GraphQL request and converts link failures into typed network
/// exceptions for every repository that uses the shared client.
extension GraphQLClientNetworkExtension on GraphQLClient {
  Future<QueryResult<T>> networkQuery<T>(QueryOptions<T> options) async {
    final result = await query(options);
    if (result.hasException) {
      final exception = result.exception!;
      if (exception.linkException == null) {
        throw exception;
      }
      throw exception.toNetworkFailure();
    }
    return result;
  }
}

/// Converts a GraphQL operation's link failure into a typed network failure.
extension OperationExceptionNetworkExtension on OperationException {
  NetworkFailure toNetworkFailure() {
    final operationLinkException = linkException;
    if (operationLinkException is ServerException) {
      final statusCode = operationLinkException.statusCode;
      if (statusCode != null) {
        return HttpNetworkException(
          statusCode: statusCode,
          cause: operationLinkException,
          stackTrace: operationLinkException.originalStackTrace,
        );
      }
      final originalException = operationLinkException.originalException;
      if (originalException is DioException) {
        return networkFailureFromDioException(originalException);
      }
      if (originalException is NetworkFailure) {
        return originalException;
      }
    }
    return NetworkConnectionException(
      cause: operationLinkException ?? this,
      stackTrace: originalStackTrace,
    );
  }
}
