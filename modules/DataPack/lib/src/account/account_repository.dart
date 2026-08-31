import 'account.dart';
import 'account_record.dart';

/// Persists [Account] entries.
///
/// Multi-account switching has no UI yet, so [getCurrent] always resolves
/// to the earliest-created account. Implementations must guarantee at
/// least one account exists once constructed, so callers may treat
/// [getCurrent]'s result as effectively non-null in practice.
abstract class AccountRepository {
  AccountRecord? getCurrent();

  /// Inserts [account] when [id] is 0 (the default), otherwise updates the
  /// existing record with that id. Returns the resulting record id.
  int save(Account account, {int id = 0});
}
