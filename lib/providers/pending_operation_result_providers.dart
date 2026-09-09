import 'package:flutter_riverpod/flutter_riverpod.dart';

/// In-memory (never persisted) holding area for the result payload
/// (`ImportResult`/`ExportResult`) of a long-running operation reported
/// through [appNotificationsProvider](app_notification_providers.dart), so
/// the global result listener in `main.dart` can retrieve it once the
/// matching [AppNotification] transitions to `completed` without storing
/// that payload in ObjectBox.
class PendingOperationResultNotifier extends Notifier<Map<String, Object>> {
  @override
  Map<String, Object> build() => {};

  void set(String kind, Object result) {
    state = {...state, kind: result};
  }

  /// Reads and removes the pending result for [kind], if any.
  Object? take(String kind) {
    final result = state[kind];
    if (result != null) {
      state = {...state}..remove(kind);
    }
    return result;
  }
}

final pendingOperationResultProvider =
    NotifierProvider<PendingOperationResultNotifier, Map<String, Object>>(
      PendingOperationResultNotifier.new,
    );
