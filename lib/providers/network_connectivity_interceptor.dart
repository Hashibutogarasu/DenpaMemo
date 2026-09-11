import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';

import 'network_connectivity_monitor.dart';

/// Rejects every request while [monitor] reports the device offline,
/// before it ever reaches the socket/DNS layer, marking it with
/// [DioLoggingExtraKeys.skippedOffline] so [DioLoggingInterceptor] records
/// it as [NetworkLogStatus.skipped] rather than a connection error.
class NetworkConnectivityGateInterceptor extends Interceptor {
  NetworkConnectivityGateInterceptor(this._monitor);

  final NetworkConnectivityMonitor _monitor;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_monitor.isOnline) {
      handler.next(options);
      return;
    }
    options.extra[DioLoggingExtraKeys.skippedOffline] = true;
    handler.reject(
      DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: const OfflineNetworkException(),
      ),
    );
  }
}
