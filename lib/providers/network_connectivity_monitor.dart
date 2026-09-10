import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the device's current connectivity via `flutter_offline`'s
/// [Connectivity], exposing the latest known state synchronously so
/// [NetworkConnectivityGateInterceptor] can check it in `onRequest`
/// without awaiting a platform channel call on every request.
class NetworkConnectivityMonitor {
  NetworkConnectivityMonitor({Connectivity? connectivityService})
    : _connectivityService = connectivityService ?? Connectivity() {
    _subscription = _connectivityService.onConnectivityChanged.listen(
      _updateFromResults,
    );
    _connectivityService.checkConnectivity().then(_updateFromResults);
  }

  final Connectivity _connectivityService;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  void _updateFromResults(List<ConnectivityResult> results) {
    _isOnline = results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() => _subscription.cancel();
}

/// Overridden with the single [NetworkConnectivityMonitor] created in
/// `main` before `runApp`, alongside [sharedDioProvider]'s [Dio].
final networkConnectivityMonitorProvider = Provider<NetworkConnectivityMonitor>(
  (ref) {
    throw UnimplementedError(
      'networkConnectivityMonitorProvider must be overridden in main()',
    );
  },
);
