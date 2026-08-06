import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique.freezed.dart';
part 'physique.g.dart';

/// Physique master data entry, loaded from `assets/data/physiques.json`.
@freezed
abstract class Physique with _$Physique {
  const factory Physique({required String id}) = _Physique;

  factory Physique.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueFromJson(json);
}
