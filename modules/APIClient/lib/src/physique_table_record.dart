import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_table_record.freezed.dart';
part 'physique_table_record.g.dart';

/// One row of a physique table, as returned by and sent to the
/// `modules/server` `/tables` REST endpoints. `lineOffset` is the row's
/// position within the table identified by `type`/`level`/
/// `anntenaCategory`, and `values`' length must match that type's
/// `columnCount` — see `TableDefinition`/`GET /tables/types`. A cell can
/// be `null` — the server stores it exactly as sent, never coercing a
/// blank cell to `0`.
@freezed
abstract class PhysiqueTableRecord with _$PhysiqueTableRecord {
  const factory PhysiqueTableRecord({
    required String type,
    required String level,
    required String anntenaCategory,
    required int lineOffset,
    required List<int?> values,
  }) = _PhysiqueTableRecord;

  factory PhysiqueTableRecord.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueTableRecordFromJson(json);
}
