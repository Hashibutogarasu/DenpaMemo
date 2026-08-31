import 'package:data_pack/data_pack.dart';

import 'account_entity.dart';

/// Converts a domain [Account] to its persisted [AccountEntity] form.
extension AccountEntityMapper on Account {
  AccountEntity toEntity({int id = 0}) {
    return AccountEntity(id: id, cuid: cuid, createdAt: createdAt);
  }
}

/// Rebuilds the domain [Account] from a persisted [AccountEntity].
extension AccountEntityToDomain on AccountEntity {
  Account toDomain() {
    return Account(cuid: cuid, createdAt: createdAt);
  }
}
