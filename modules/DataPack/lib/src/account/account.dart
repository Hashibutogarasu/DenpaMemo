import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

/// A user identity that owns the app's data. Every persisted entity is
/// meant to eventually be scoped to one of these, so cloud sync can later
/// tell whose data is whose.
@freezed
abstract class Account with _$Account {
  const factory Account({required String cuid, required DateTime createdAt}) =
      _Account;
}
