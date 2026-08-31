import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/account/objectbox_account_repository.dart';
import 'objectbox_providers.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return ObjectBoxAccountRepository(ref.watch(objectBoxProvider));
});

/// `ObjectBox` guarantees at least one account exists once constructed
/// (see `ObjectBox._create`), so `getCurrent()` is safe to unwrap here.
final currentAccountProvider = Provider<AccountRecord>((ref) {
  return ref.watch(accountRepositoryProvider).getCurrent()!;
});
