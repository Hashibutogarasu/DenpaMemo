import 'package:app_datas/app_datas.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../objectbox.g.dart';
import '../denpa_men/denpa_men_entity.dart';
import '../qr_code/qr_code_entity.dart';

/// Owns the ObjectBox [Store] for this app and the boxes derived from it.
///
/// Must be created once via [ObjectBox.create] before [runApp] and provided
/// to the widget tree (see `objectBoxProvider` in
/// `providers/objectbox_providers.dart`).
class ObjectBox {
  final Store store;
  late final Box<DenpaMenEntity> denpaMenBox;
  late final Box<QrCodeEntity> qrCodeBox;

  ObjectBox._create(this.store) {
    denpaMenBox = Box<DenpaMenEntity>(store);
    qrCodeBox = Box<QrCodeEntity>(store);
  }

  static Future<ObjectBox> create() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final storeDirectory = await AppPaths.objectboxDirectory(
      packageInfo.packageName,
    );
    final store = await openStore(directory: storeDirectory.path);
    return ObjectBox._create(store);
  }

  /// Opens a throwaway in-memory store, for use in tests only.
  factory ObjectBox.createInMemory() {
    return ObjectBox._create(
      Store(getObjectBoxModel(), directory: 'memory:test-db'),
    );
  }
}
