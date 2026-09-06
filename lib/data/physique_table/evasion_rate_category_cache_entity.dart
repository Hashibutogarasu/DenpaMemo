import 'package:objectbox/objectbox.dart';

/// Locally cached representation of one row of
/// `GET /tables/evasion-rate-categories` (`PhysiqueEvasionRateCategoryRow`
/// on `modules/APIClient`), so physique identification can resolve
/// evasion-rate ranges to categories offline.
@Entity()
class EvasionRateCategoryEntity {
  @Id()
  int id;

  @Unique()
  String categoryId;

  int evasionRateStart;

  int evasionRateEnd;

  int columnIndex;

  String textKey;

  String? sign;

  EvasionRateCategoryEntity({
    this.id = 0,
    required this.categoryId,
    required this.evasionRateStart,
    required this.evasionRateEnd,
    required this.columnIndex,
    required this.textKey,
    this.sign,
  });
}
