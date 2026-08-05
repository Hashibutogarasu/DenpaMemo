import 'package:freezed_annotation/freezed_annotation.dart';

part 'anntena.freezed.dart';
part 'anntena.g.dart';

/// Antenna master data entry, loaded from `assets/data/antennas.json`.
@freezed
abstract class Anntena with _$Anntena {
  const factory Anntena({required String id, required String displayName}) =
      _Anntena;

  factory Anntena.fromJson(Map<String, dynamic> json) =>
      _$AnntenaFromJson(json);
}
