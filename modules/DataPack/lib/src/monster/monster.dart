import 'package:freezed_annotation/freezed_annotation.dart';

part 'monster.freezed.dart';
part 'monster.g.dart';

/// Monster catalog entry, loaded from the server's isolated `monsters`
/// query (not part of [MasterData]).
@freezed
abstract class Monster with _$Monster {
  const factory Monster({
    @JsonKey(name: 'translateKey') required String id,
  }) = _Monster;

  factory Monster.fromJson(Map<String, dynamic> json) =>
      _$MonsterFromJson(json);
}
