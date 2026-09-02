/// One row of the physique table category picker: an antenna name
/// (`anntenaCategory`, e.g. `"単体回復"`) grouped under a display
/// category (`category`, e.g. `"回復系"`).
class PhysiqueAntennaCategory {
  const PhysiqueAntennaCategory({
    required this.category,
    required this.anntenaCategory,
  });

  final String category;
  final String anntenaCategory;
}
