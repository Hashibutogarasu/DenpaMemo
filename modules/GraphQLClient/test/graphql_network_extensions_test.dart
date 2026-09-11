import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:graphql_client/src/graphql_network_extensions.dart';

void main() {
  test(
    'preserves an HTTP failure instead of converting it to a fallback error',
    () {
      final failure = OperationException(
        linkException: const ServerException(statusCode: 530),
      ).toNetworkFailure();

      expect(failure, isA<HttpNetworkException>());
      expect((failure as HttpNetworkException).statusCode, 530);
    },
  );

  test('converts transport timeouts into a typed timeout failure', () {
    final failure = OperationException(
      linkException: ServerException(
        originalException: DioException(
          requestOptions: RequestOptions(path: '/graphql'),
          type: DioExceptionType.receiveTimeout,
        ),
      ),
    ).toNetworkFailure();

    expect(failure, isA<NetworkTimeoutException>());
  });
}
