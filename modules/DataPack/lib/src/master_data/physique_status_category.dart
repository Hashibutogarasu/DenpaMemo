import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_status_category.freezed.dart';
part 'physique_status_category.g.dart';

/// A physique table's status axis (e.g. HP, speed), each with its own row
/// width (`columnCount`) — HP and speed tables don't have the same number
/// of growth stages. Sourced from the server's
/// `PhysiqueStatusCategoryEntity`, not bundled as a JSON asset.
@freezed
abstract class PhysiqueStatusCategory with _$PhysiqueStatusCategory {
  const factory PhysiqueStatusCategory({
    required String name,
    required int columnCount,
  }) = _PhysiqueStatusCategory;

  factory PhysiqueStatusCategory.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueStatusCategoryFromJson(json);
}
