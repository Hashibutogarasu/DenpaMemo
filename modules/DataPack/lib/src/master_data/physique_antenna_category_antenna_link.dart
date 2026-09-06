import 'package:freezed_annotation/freezed_annotation.dart';

part 'physique_antenna_category_antenna_link.freezed.dart';
part 'physique_antenna_category_antenna_link.g.dart';

/// Links one physique antenna category (major + minor, already resolved
/// to display text server-side) to one concrete antenna's display name.
/// The server owns this translation, not this app.
@freezed
abstract class PhysiqueAntennaCategoryAntennaLink
    with _$PhysiqueAntennaCategoryAntennaLink {
  const factory PhysiqueAntennaCategoryAntennaLink({
    required String major,
    required String minor,
    required String antennaName,
  }) = _PhysiqueAntennaCategoryAntennaLink;

  factory PhysiqueAntennaCategoryAntennaLink.fromJson(
    Map<String, dynamic> json,
  ) => _$PhysiqueAntennaCategoryAntennaLinkFromJson(json);
}
