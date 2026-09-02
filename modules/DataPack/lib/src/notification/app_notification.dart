import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

/// Lifecycle of one [AppNotification].
enum AppNotificationStatus { running, completed, failed, cancelled }

/// A persisted record of one long-running operation. [kind] is an opaque
/// id owned by whichever feature reports under it; at most one
/// [AppNotification] exists per [kind].
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String kind,
    required AppNotificationStatus status,
    double? progress,
    String? message,
    required DateTime updatedAt,
  }) = _AppNotification;
}
