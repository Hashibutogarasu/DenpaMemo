import 'package:freezed_annotation/freezed_annotation.dart';

import '../denpa_men/denpa_men.dart';

part 'export_result.freezed.dart';

/// Outcome of one `.dm` export. [orphaned] is a subset of [exported]:
/// individuals whose [DenpaMen.parentIds] point outside the exported set,
/// so a future import of this file cannot restore their parent links.
@freezed
abstract class ExportResult with _$ExportResult {
  const factory ExportResult({
    @Default(<DenpaMen>[]) List<DenpaMen> exported,
    @Default(<DenpaMen>[]) List<DenpaMen> orphaned,
  }) = _ExportResult;
}
