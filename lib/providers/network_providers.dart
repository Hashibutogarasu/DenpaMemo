import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Overridden with the single [Dio] instance created in `main` before
/// `runApp` (see [createSharedDio]), so every REST and GraphQL client in
/// the app shares one client and one debug-log interceptor.
final sharedDioProvider = Provider<Dio>((ref) {
  throw UnimplementedError('sharedDioProvider must be overridden in main()');
});

/// Builds the app's single [Dio] instance, with the one
/// [DioLoggingInterceptor] attached — call this exactly once in `main`,
/// then pass the result to every place that overrides [sharedDioProvider]
/// or `firebase_sign_in`'s own `sharedDioProvider` placeholder.
Dio createSharedDio() => Dio()..interceptors.add(DioLoggingInterceptor());
