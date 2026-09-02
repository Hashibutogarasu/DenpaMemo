/// Identifies one physique table: the `statusCategory`/`level`/
/// `anntenaCategory` triple used to filter `/physiques`. `level` is the
/// character's experience-based level (a number, entered as free text),
/// not a `Physique` master-data size id. `statusCategory` is the table's
/// status axis (e.g. HP, speed — see `PhysiqueStatusCategory`), and
/// `columnCount` is that category's row width, carried along from
/// selection time so pages don't need to re-fetch it. Passed between the
/// list/view/edit pages via `$extra`, following this app's convention for
/// data that can't round-trip through a URL (see `SearchResultsRoute` and
/// friends in `app_router.dart`).
class PhysiqueTableArgs {
  const PhysiqueTableArgs({
    required this.statusCategory,
    required this.columnCount,
    required this.level,
    required this.anntenaCategory,
  });

  final String statusCategory;
  final int columnCount;
  final String level;
  final String anntenaCategory;
}
