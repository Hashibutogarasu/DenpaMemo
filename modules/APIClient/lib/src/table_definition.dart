import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_definition.freezed.dart';
part 'table_definition.g.dart';

/// One registered "table type" as returned by `GET /tables/types`, backing
/// the physique table type picker (e.g. HP, speed, evasion rate). The
/// caller never needs to know which types exist in advance — the full
/// list is always fetched from the server's table-type registry.
@freezed
abstract class TableDefinition with _$TableDefinition {
  const factory TableDefinition({
    required String type,
    required int columnCount,
    required String translationKey,
  }) = _TableDefinition;

  factory TableDefinition.fromJson(Map<String, dynamic> json) =>
      _$TableDefinitionFromJson(json);
}
