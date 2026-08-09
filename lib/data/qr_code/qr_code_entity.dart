import 'package:objectbox/objectbox.dart';

/// Persisted representation of a
/// [QrCode](../../domain/qr_code/qr_code.dart).
@Entity()
class QrCodeEntity {
  @Id()
  int id;

  String cuid;

  String rawValue;

  @Unique()
  String hash;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  String? name;

  QrCodeEntity({
    this.id = 0,
    required this.cuid,
    required this.rawValue,
    required this.hash,
    required this.createdAt,
    this.name,
  });
}
