import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_connectivity_interceptor.dart';
import 'network_connectivity_monitor.dart';

/// Overridden with the single [Dio] instance created in `main` before
/// `runApp` (see [createSharedDio]), so every REST and GraphQL client in
/// the app shares one client and one debug-log interceptor.
final sharedDioProvider = Provider<Dio>((ref) {
  throw UnimplementedError('sharedDioProvider must be overridden in main()');
});

/// Builds the app's single [Dio] instance, with [DioLoggingInterceptor]
/// and [NetworkConnectivityGateInterceptor] attached in that order (so an
/// offline rejection is still recorded via the logging interceptor's
/// `onError`) — call this once in `main`, passing the result to every
/// override of [sharedDioProvider] or `firebase_sign_in`'s own copy.
Dio createSharedDio(NetworkConnectivityMonitor connectivityMonitor) => Dio()
  ..interceptors.add(DioLoggingInterceptor())
  ..interceptors.add(NetworkConnectivityGateInterceptor(connectivityMonitor));
