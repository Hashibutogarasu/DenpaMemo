/// Identifies one physique table: the `level`/`anntenaCategory` pair used
/// to filter `/physiques`. `level` is the character's experience-based
/// level (a number, entered as free text), not a `Physique` master-data
/// size id. Passed between the list/view/edit pages via `$extra`,
/// following this app's convention for data that can't round-trip through
/// a URL (see `SearchResultsRoute` and friends in `app_router.dart`).
class PhysiqueTableArgs {
  const PhysiqueTableArgs({required this.level, required this.anntenaCategory});

  final String level;
  final String anntenaCategory;
}
