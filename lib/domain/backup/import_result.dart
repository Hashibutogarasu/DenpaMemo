import 'package:data_pack/data_pack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'dm_import_error.dart';

part 'import_result.freezed.dart';

/// Outcome of one `.dm` import, grouping every processed backup entry by
/// what happened to it. [orphaned] is a subset condition layered on top
/// of [added]/[merged] (an individual there also appears in exactly one
/// of those two, since a missing parent is a warning about an outcome
/// that already happened, not an alternative outcome). [failed] holds
/// every [DenpaMenEntryParseError] caught while decoding `entries.json`.
@freezed
abstract class ImportResult with _$ImportResult {
  const factory ImportResult({
    @Default(<DenpaMen>[]) List<DenpaMen> added,
    @Default(<DenpaMen>[]) List<DenpaMen> merged,
    @Default(<DenpaMen>[]) List<DenpaMen> orphaned,
    @Default(<DenpaMenEntryParseError>[]) List<DenpaMenEntryParseError> failed,
  }) = _ImportResult;
}
