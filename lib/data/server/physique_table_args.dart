/// Identifies one physique table: the `type`/`level`/`anntenaCategory`
/// triple used to filter `/tables`. `level` is the character's
/// experience-based level (a number, entered as free text), not a
/// `Physique` master-data size id. `type` is the table's registered type
/// (e.g. HP, speed — see `TableDefinition`/`GET /tables/types`). Column
/// count is deliberately NOT carried here: it must always be read fresh
/// from [tableTypesProvider] at the point of use (display and row
/// creation alike), so a column count change on the server is reflected
/// immediately rather than through a value copied at selection time.
/// Passed between the list/view/edit pages via `$extra`, following this
/// app's convention for data that can't round-trip through a URL (see
/// `SearchResultsRoute` and friends in `app_router.dart`).
class PhysiqueTableArgs {
  const PhysiqueTableArgs({
    required this.type,
    required this.level,
    required this.anntenaCategory,
  });

  final String type;
  final String level;
  final String anntenaCategory;
}
