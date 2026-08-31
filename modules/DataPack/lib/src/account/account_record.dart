import 'account.dart';

/// An [Account] paired with the opaque storage id it was persisted under.
class AccountRecord {
  const AccountRecord({required this.id, required this.account});

  final int id;
  final Account account;
}
