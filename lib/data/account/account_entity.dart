import 'package:objectbox/objectbox.dart';

/// Persisted representation of an
/// [Account](../../../modules/DataPack/lib/src/account/account.dart).
@Entity()
class AccountEntity {
  @Id()
  int id;

  String cuid;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  AccountEntity({this.id = 0, required this.cuid, required this.createdAt});
}
