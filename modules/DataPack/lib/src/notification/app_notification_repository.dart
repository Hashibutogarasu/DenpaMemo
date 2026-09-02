import 'app_notification.dart';

/// Persists [AppNotification]s, keyed by their own [AppNotification.kind].
abstract class AppNotificationRepository {
  List<AppNotification> getAll();

  AppNotification? getByKind(String kind);

  /// Replaces the notification at [AppNotification.kind], or inserts it if
  /// none exists yet.
  void upsert(AppNotification notification);

  void delete(String kind);
}
