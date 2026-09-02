import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_table_record.freezed.dart';
part 'physique_table_record.g.dart';

/// One row of a physique table, as returned by and sent to the
/// `modules/server` `/physiques` REST endpoints. `lineOffset` is the row's
/// position within the table identified by `level`/`anntenaCategory`, and
/// `values` always holds `PHYSIQUE_TABLE_COLUMN_COUNT` (10) entries — see
/// `PhysiqueTableEntity` on the server.
@freezed
abstract class PhysiqueTableRecord with _$PhysiqueTableRecord {
  const factory PhysiqueTableRecord({
    required String level,
    required String anntenaCategory,
    required int lineOffset,
    required List<int> values,
  }) = _PhysiqueTableRecord;

  factory PhysiqueTableRecord.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueTableRecordFromJson(json);
}
