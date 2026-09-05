import 'package:json_annotation/json_annotation.dart';

/// Which side of the evasion-rate table's overlapping column patterns a
/// physique category falls on. Mirrors the server's `EvasionRateSign`
/// (`'plus' | 'minus' | null` — see
/// `physique-evasion-rate-category.ts`); `null` there means "not part of
/// a plus/minus pair", represented here by the field simply being
/// omitted/absent rather than by a third enum value.
enum EvasionRateSign {
  @JsonValue('plus')
  plus,
  @JsonValue('minus')
  minus,
}
