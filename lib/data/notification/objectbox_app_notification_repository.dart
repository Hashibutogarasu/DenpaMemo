import 'package:data_pack/data_pack.dart';

import '../../objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'app_notification_entity.dart';
import 'app_notification_mapper.dart';

/// [AppNotificationRepository] backed by the [AppNotificationEntity]
/// ObjectBox box.
class ObjectBoxAppNotificationRepository implements AppNotificationRepository {
  ObjectBoxAppNotificationRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<AppNotificationEntity> get _box => _objectBox.appNotificationBox;

  @override
  List<AppNotification> getAll() {
    final query = (_box.query()..order(AppNotificationEntity_.updatedAt)).build();
    try {
      return [for (final entity in query.find()) entity.toDomain()];
    } finally {
      query.close();
    }
  }

  @override
  AppNotification? getByKind(String kind) {
    final query = _box.query(AppNotificationEntity_.kind.equals(kind)).build();
    try {
      return query.findFirst()?.toDomain();
    } finally {
      query.close();
    }
  }

  @override
  void upsert(AppNotification notification) {
    final query = _box.query(AppNotificationEntity_.kind.equals(notification.kind)).build();
    final existingId = () {
      try {
        return query.findFirst()?.id ?? 0;
      } finally {
        query.close();
      }
    }();
    _box.put(notification.toEntity(id: existingId));
  }

  @override
  void delete(String kind) {
    final query = _box.query(AppNotificationEntity_.kind.equals(kind)).build();
    try {
      final entity = query.findFirst();
      if (entity != null) {
        _box.remove(entity.id);
      }
    } finally {
      query.close();
    }
  }
}
