/// Identifies which "matching location" grid to show: the level/antenna
/// pair `GET /tables/legend-grid` reads its tables from, plus the
/// specific column/lineOffset/evasion-rate that a physique-identification
/// search matched (see `PhysiqueColumnMatch`), so the page can highlight
/// that one cell. Passed via `$extra`, following this app's convention
/// for data that can't round-trip through a URL (see `PhysiqueTableArgs`).
class PhysiqueLegendGridArgs {
  const PhysiqueLegendGridArgs({
    required this.level,
    required this.anntenaCategory,
    required this.matchColumnIndex,
    required this.matchLineOffset,
    required this.matchEvasionRate,
  });

  final String level;
  final String anntenaCategory;
  final int matchColumnIndex;
  final int matchLineOffset;
  final int matchEvasionRate;

  @override
  bool operator ==(Object other) =>
      other is PhysiqueLegendGridArgs &&
      other.level == level &&
      other.anntenaCategory == anntenaCategory &&
      other.matchColumnIndex == matchColumnIndex &&
      other.matchLineOffset == matchLineOffset &&
      other.matchEvasionRate == matchEvasionRate;

  @override
  int get hashCode => Object.hash(
    level,
    anntenaCategory,
    matchColumnIndex,
    matchLineOffset,
    matchEvasionRate,
  );
}
