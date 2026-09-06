import 'package:api_client/api_client.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox/objectbox.dart';
import 'evasion_rate_category_cache_entity.dart';

/// Local ObjectBox-backed cache of the physique-category legend
/// (`GET /tables/evasion-rate-categories`), so identification can resolve
/// evasion-rate ranges to categories without reaching `modules/server`.
class EvasionRateCategoryCacheRepository {
  EvasionRateCategoryCacheRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<EvasionRateCategoryEntity> get _box => _objectBox.evasionRateCategoryBox;

  /// Every cached legend row, or `null` when nothing has been cached yet.
  List<PhysiqueEvasionRateCategoryRow>? cachedCategories() {
    final entities = _box.getAll();
    if (entities.isEmpty) return null;
    return [for (final entity in entities) _toRow(entity)];
  }

  /// Replaces every cached legend row with [categories].
  void replaceAll(List<PhysiqueEvasionRateCategoryRow> categories) {
    _box.removeAll();
    _box.putMany([for (final category in categories) _toEntity(category)]);
  }

  EvasionRateCategoryEntity _toEntity(PhysiqueEvasionRateCategoryRow row) => EvasionRateCategoryEntity(
    categoryId: row.id,
    evasionRateStart: row.evasionRateStart,
    evasionRateEnd: row.evasionRateEnd,
    columnIndex: row.columnIndex,
    textKey: row.textKey,
    sign: row.sign?.name,
  );

  PhysiqueEvasionRateCategoryRow _toRow(EvasionRateCategoryEntity entity) => PhysiqueEvasionRateCategoryRow(
    id: entity.categoryId,
    evasionRateStart: entity.evasionRateStart,
    evasionRateEnd: entity.evasionRateEnd,
    columnIndex: entity.columnIndex,
    textKey: entity.textKey,
    sign: entity.sign == null ? null : EvasionRateSign.values.byName(entity.sign!),
  );
}
