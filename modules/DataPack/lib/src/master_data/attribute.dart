import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

/// Attribute master data entry, loaded from
/// `assets/data/attributes/elemental|special/*.json` (one file per
/// attribute). [index] determines display order in the UI (e.g. resistance
/// lists), independent of the order entries happen to appear in the source
/// JSON.
///
/// [isElemental] reflects which of those two directories the entry was
/// loaded from, set by [JsonMasterDataRepository] rather than read from the
/// JSON itself. Special (non-elemental) attributes, like physical damage or
/// instant death, are excluded from "every attribute" semantics elsewhere in
/// the domain (e.g. a body color's full-coverage resistance check), since
/// they aren't part of the elemental type chart.
///
/// [resistantTo]/[weakTo] are resolved from the source JSON's
/// `resistantToIds`/`weakToIds` id lists by [JsonMasterDataRepository], not
/// deserialized directly: the referenced [Attribute]s are shallow (their own
/// [resistantTo]/[weakTo] are empty), since freezed's immutable classes
/// can't represent a true circular object graph.
@freezed
abstract class Attribute with _$Attribute {
  const factory Attribute({
    required String id,
    required int index,
    @Default(true) bool isElemental,
    @Default(<Attribute>[]) List<Attribute> resistantTo,
    @Default(<Attribute>[]) List<Attribute> weakTo,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
}
