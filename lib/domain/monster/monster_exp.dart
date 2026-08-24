import 'package:freezed_annotation/freezed_annotation.dart';

part 'monster_exp.freezed.dart';
part 'monster_exp.g.dart';

/// Records the outcome of defeating a [Monster]: how many were defeated,
/// the individual's level/exp afterward, and how many teammates were
/// involved. Attached to `DenpaMen.monsterExp`.
@freezed
abstract class MonsterExp with _$MonsterExp {
  const factory MonsterExp({
    required String monsterId,
    required int count,
    required int exp,
    required int level,
    required int maxLevelTeammateCount,
    required int expRecipientCount,
  }) = _MonsterExp;

  factory MonsterExp.fromJson(Map<String, dynamic> json) =>
      _$MonsterExpFromJson(json);
}
