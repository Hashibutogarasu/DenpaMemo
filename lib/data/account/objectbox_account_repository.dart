import 'package:data_pack/data_pack.dart';

import '../../objectbox.g.dart';
import '../objectbox/objectbox.dart';
import 'account_entity.dart';
import 'account_mapper.dart';

/// [AccountRepository] backed by the [AccountEntity] ObjectBox box.
/// [getCurrent] resolves to the earliest-created account, since there is
/// no multi-account switching UI yet.
class ObjectBoxAccountRepository implements AccountRepository {
  ObjectBoxAccountRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<AccountEntity> get _box => _objectBox.accountBox;

  @override
  AccountRecord? getCurrent() {
    final query = (_box.query()..order(AccountEntity_.createdAt)).build();
    try {
      final entity = query.findFirst();
      return entity == null
          ? null
          : AccountRecord(id: entity.id, account: entity.toDomain());
    } finally {
      query.close();
    }
  }

  @override
  int save(Account account, {int id = 0}) {
    return _box.put(account.toEntity(id: id));
  }
}
