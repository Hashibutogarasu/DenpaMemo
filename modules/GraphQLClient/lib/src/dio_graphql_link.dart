import 'dart:convert';

import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart' as dio;
import 'package:graphql_flutter/graphql_flutter.dart';

/// A [Link] that performs its HTTP work through a shared [dio.Dio]
/// instance instead of `graphql_flutter`'s own `HttpLink`, so GraphQL
/// traffic is captured by the same debug-log interceptor as REST calls.
/// Reuses [RequestSerializer]/[ResponseParser] from `gql_link`.
class DioGraphQlLink extends Link {
  DioGraphQlLink(
    this._dio,
    this._uri, {
    this.serializer = const RequestSerializer(),
    this.parser = const ResponseParser(),
  });

  final dio.Dio _dio;
  final Uri _uri;
  final RequestSerializer serializer;
  final ResponseParser parser;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final body = serializer.serializeRequest(request);

    final Response parsed;
    final int statusCode;
    try {
      final dioResponse = await _dio.postUri<String>(
        _uri,
        data: json.encode(body),
        options: dio.Options(
          contentType: dio.Headers.jsonContentType,
          headers: const {'Accept': '*/*'},
          responseType: dio.ResponseType.plain,
          validateStatus: (_) => true,
          extra: {
            DioLoggingExtraKeys.graphQl: true,
            DioLoggingExtraKeys.operationName: request.operation.operationName,
            DioLoggingExtraKeys.variables: request.variables,
          },
        ),
      );
      statusCode = dioResponse.statusCode ?? 0;
      parsed = parser.parseResponse(
        json.decode(dioResponse.data!) as Map<String, dynamic>,
      );
    } on dio.DioException catch (e, stackTrace) {
      throw ServerException(
        originalException: e,
        originalStackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      throw ResponseFormatException(
        originalException: e,
        originalStackTrace: stackTrace,
      );
    }

    if (statusCode >= 300 || (parsed.data == null && parsed.errors == null)) {
      throw ServerException(parsedResponse: parsed, statusCode: statusCode);
    }

    yield parsed;
  }
}
