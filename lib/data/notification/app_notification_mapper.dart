import 'package:data_pack/data_pack.dart';

import 'app_notification_entity.dart';

/// Converts a domain [AppNotification] to its persisted
/// [AppNotificationEntity] form.
extension AppNotificationEntityMapper on AppNotification {
  AppNotificationEntity toEntity({int id = 0}) {
    return AppNotificationEntity(
      id: id,
      kind: kind,
      status: status.name,
      progress: progress,
      message: message,
      errorKind: errorKind,
      updatedAt: updatedAt,
    );
  }
}

/// Rebuilds the domain [AppNotification] from a persisted
/// [AppNotificationEntity].
extension AppNotificationEntityToDomain on AppNotificationEntity {
  AppNotification toDomain() {
    return AppNotification(
      kind: kind,
      status: AppNotificationStatus.values.byName(status),
      progress: progress,
      message: message,
      errorKind: errorKind,
      updatedAt: updatedAt,
    );
  }
}
