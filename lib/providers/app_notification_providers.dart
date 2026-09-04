import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification/objectbox_app_notification_repository.dart';
import 'objectbox_providers.dart';

final appNotificationRepositoryProvider = Provider<AppNotificationRepository>(
  (ref) => ObjectBoxAppNotificationRepository(ref.watch(objectBoxProvider)),
);

/// Every persisted [AppNotification], refreshed from
/// [appNotificationRepositoryProvider] on each write. Long-running
/// operations report their progress and outcome here instead of through
/// an ephemeral per-page provider, so that state survives independently
/// of whichever page started the operation.
class AppNotificationsNotifier extends Notifier<List<AppNotification>> {
  @override
  List<AppNotification> build() =>
      ref.watch(appNotificationRepositoryProvider).getAll();

  void upsert(AppNotification notification) {
    ref.read(appNotificationRepositoryProvider).upsert(notification);
    state = ref.read(appNotificationRepositoryProvider).getAll();
  }

  /// Shorthand for the common case of moving the notification at [kind] to
  /// a new [status], rather than constructing a full [AppNotification].
  void setStatus(
    String kind, {
    required AppNotificationStatus status,
    double? progress,
    String? message,
  }) {
    upsert(
      AppNotification(
        kind: kind,
        status: status,
        progress: progress,
        message: message,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void remove(String kind) {
    ref.read(appNotificationRepositoryProvider).delete(kind);
    state = ref.read(appNotificationRepositoryProvider).getAll();
  }
}

final appNotificationsProvider =
    NotifierProvider<AppNotificationsNotifier, List<AppNotification>>(
      AppNotificationsNotifier.new,
    );
