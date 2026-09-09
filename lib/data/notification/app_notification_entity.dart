import 'package:objectbox/objectbox.dart';

/// Persisted representation of an
/// [AppNotification](../../../modules/DataPack/lib/src/notification/app_notification.dart).
/// [status] is stored as its enum name, since ObjectBox has no native enum
/// column type.
@Entity()
class AppNotificationEntity {
  @Id()
  int id;

  @Unique()
  String kind;

  String status;

  double? progress;

  String? message;

  String? errorKind;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  AppNotificationEntity({
    this.id = 0,
    required this.kind,
    required this.status,
    this.progress,
    this.message,
    this.errorKind,
    required this.updatedAt,
  });
}
