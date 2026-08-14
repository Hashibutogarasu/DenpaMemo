import 'package:freezed_annotation/freezed_annotation.dart';

import 'attribute.dart';

part 'anntena.freezed.dart';
part 'anntena.g.dart';

enum AnntenaCategory { attack, support, other }

/// Antenna master data entry, loaded from `assets/data/antennas/*.json`
/// (one file per antenna id, containing a list of its pattern/evolution
/// variants).
///
/// [attackAttributes] is resolved from the source JSON's
/// `attackAttributeIds` id list by [JsonMasterDataRepository], not
/// deserialized directly.
@freezed
abstract class Anntena with _$Anntena {
  const factory Anntena({
    required String id,
    required AnntenaCategory category,
    int? targetCount,
    @Default(false) bool targetsAll,
    @Default(false) bool dealsDamage,
    @Default(<Attribute>[]) List<Attribute> attackAttributes,
    @Default(false) bool isInheritable,
    String? evolvesToId,
    int? maxLevel,
    String? variantGroupId,
    @Default(true) bool hasLevel,
  }) = _Anntena;

  factory Anntena.fromJson(Map<String, dynamic> json) =>
      _$AnntenaFromJson(json);
}
