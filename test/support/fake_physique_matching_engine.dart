import 'package:denpa_memo/services/physique_identification_service.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart' as rust;

class FakePhysiqueMatchingEngine implements PhysiqueMatchingEngine {
  const FakePhysiqueMatchingEngine({
    this.matches = const [],
    this.categories = const [],
  });

  final List<rust.StatusMatch> matches;
  final List<rust.CategoryMatch> categories;

  @override
  List<rust.StatusMatch> findMatchingColumns({
    required rust.StatusCriterion primary,
    required List<rust.StatusCriterion> others,
  }) => matches;

  @override
  List<rust.CategoryMatch> resolveCategories({
    required List<rust.RangeCategory> categories,
    required int value,
    required int columnIndex,
  }) => this.categories;
}
