import 'package:api_client/api_client.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart' as rust;

import '../widgets/physique_table/physique_table_row.dart';

/// Converts one cached physique table row into `denpamemo_logics`'s
/// generic [rust.TableRow], shared by [PhysiqueIdentificationService] and
/// [PhysiqueLegendGridService] so both map to/from the Rust engine's
/// shapes the same way.
rust.TableRow toRustRow(
  PhysiqueTableRow row, {
  required String level,
  required String anntenaCategory,
}) => rust.TableRow(
  group: [level, anntenaCategory],
  lineOffset: row.lineOffset,
  values: [for (final value in row.values) int.tryParse(value)],
);

rust.RangeCategory toRustCategory(PhysiqueEvasionRateCategoryRow row) =>
    rust.RangeCategory(
      id: row.id,
      rangeStart: row.evasionRateStart,
      rangeEnd: row.evasionRateEnd,
      columnIndex: row.columnIndex,
      categoryKey: row.textKey,
      tag: row.sign?.name,
    );

EvasionRateSign? toApiSign(String? tag) =>
    tag == null ? null : EvasionRateSign.values.byName(tag);
