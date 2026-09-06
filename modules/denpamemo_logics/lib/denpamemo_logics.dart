library;

export 'src/rust/category_grid.dart';
export 'src/rust/frb_generated.dart' show RustLib;
export 'src/rust/range_category.dart';
export 'src/rust/status_match.dart';
export 'src/rust/table_row.dart';

import 'src/rust/category_grid.dart' as category_grid;
import 'src/rust/category_grid.dart';
import 'src/rust/range_category.dart' as range_category;
import 'src/rust/range_category.dart';
import 'src/rust/status_match.dart' as status_match;
import 'src/rust/status_match.dart';

/// Domain-agnostic entry point onto `denpamemo_logics`'s Rust logic: finds
/// columns that satisfy several status criteria at once, resolves values
/// against range-to-category tables, and builds a combined display grid.
/// Callers translate their own domain's vocabulary (e.g. physique's
/// hp/evasionRate/anntenaCategory) to/from this crate's generic shapes.
class StatusMatchingEngine {
  const StatusMatchingEngine();

  List<StatusMatch> findMatchingColumns({
    required StatusCriterion primary,
    required List<StatusCriterion> others,
  }) => status_match.findMatchingColumns(primary: primary, others: others);

  List<CategoryMatch> resolveCategories({
    required List<RangeCategory> categories,
    required int value,
    required int columnIndex,
  }) => range_category.resolveCategories(categories: categories, value: value, columnIndex: columnIndex);

  CategoryGrid buildCategoryGrid(CategoryGridRequest request) =>
      category_grid.buildCategoryGrid(request: request);
}
