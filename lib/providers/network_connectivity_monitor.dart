import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_logging/app_logging.dart';

/// Tracks the device's current connectivity, exposing the latest known
/// state synchronously so [NetworkConnectivityGateInterceptor] can check
/// it per-request without awaiting a platform channel call. [create]
/// awaits one real check before returning, so no request can slip through
/// the gate before the state is known.
class NetworkConnectivityMonitor {
  NetworkConnectivityMonitor._(this._connectivityService, this._isOnline) {
    _subscription = _connectivityService.onConnectivityChanged.listen(
      _updateFromResults,
    );
  }

  static Future<NetworkConnectivityMonitor> create({
    Connectivity? connectivityService,
  }) async {
    final service = connectivityService ?? Connectivity();
    final initialResults = await service.checkConnectivity();
    return NetworkConnectivityMonitor._(service, _isOnlineFrom(initialResults));
  }

  final Connectivity _connectivityService;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isOnline;

  bool get isOnline => _isOnline;

  void _updateFromResults(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = _isOnlineFrom(results);
    if (wasOnline && !_isOnline) {
      LogBus.instance.markPendingNetworkRequestsOffline();
    }
  }

  static bool _isOnlineFrom(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

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
