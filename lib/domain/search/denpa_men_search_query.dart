import 'package:freezed_annotation/freezed_annotation.dart';

part 'denpa_men_search_query.freezed.dart';

/// Single source of truth for every search filter applied to saved
/// [DenpaMen] individuals, shared by the home screen's quick name search
/// and the dedicated search page's full filter form.
@freezed
abstract class DenpaMenSearchQuery with _$DenpaMenSearchQuery {
  const factory DenpaMenSearchQuery({
    @Default('') String name,
    String? headShapeId,
    @Default(<String>[]) List<String> bodyColors,
    bool? isSpColor,
    @Default('') String memo,
    int? minHp,
    int? minAp,
    int? minAttack,
    int? minDefense,
    int? minSpeed,
    int? minEvasionRate,
  }) = _DenpaMenSearchQuery;

  const DenpaMenSearchQuery._();

  bool get isEmpty =>
      name.isEmpty &&
      headShapeId == null &&
      bodyColors.isEmpty &&
      isSpColor == null &&
      memo.isEmpty &&
      minHp == null &&
      minAp == null &&
      minAttack == null &&
      minDefense == null &&
      minSpeed == null &&
      minEvasionRate == null;
}
