import '../denpa_men/denpa_men.dart';
import '../master_data/master_data.dart';

/// Whether [denpaMen]'s master-data references ([DenpaMen.headShape],
/// [DenpaMen.physique], [DenpaMen.personality], [DenpaMen.pattern],
/// [DenpaMen.anntena], [DenpaMen.corrections]) all still exist in
/// [masterData]. Individuals that fail this check reference master data
/// that has since been removed or renamed (e.g. after an app update) and
/// are excluded from the export rather than failing the whole operation.
bool isDenpaMenConsistentWithMasterData(DenpaMen denpaMen, MasterData masterData) {
  final headShapeIds = {for (final v in masterData.headShapes) v.id};
  final physiqueIds = {for (final v in masterData.physiques) v.id};
  final personalityIds = {for (final v in masterData.personalities) v.id};
  final patternIds = {for (final v in masterData.patterns) v.id};
  final anntenaIds = {for (final v in masterData.anntenas) v.id};
  final correctionIds = {for (final v in masterData.corrections) v.id};

  return headShapeIds.contains(denpaMen.headShape.id) &&
      physiqueIds.contains(denpaMen.physique.id) &&
      personalityIds.contains(denpaMen.personality.id) &&
      patternIds.contains(denpaMen.pattern.id) &&
      anntenaIds.contains(denpaMen.anntena.id) &&
      denpaMen.corrections.every((c) => correctionIds.contains(c.id));
}

/// Whether [denpaMen]'s [DenpaMen.parentIds] are fully contained in the
/// exported set. [exportedIds] is the set of [DenpaMen.id] values chosen
/// for export (after the master-data consistency filter), so an
/// individual is orphaned only relative to what this specific export
/// actually includes.
bool isDenpaMenOrphanedInExport(DenpaMen denpaMen, Set<String> exportedIds) {
  return denpaMen.parentIds.any((parentId) => !exportedIds.contains(parentId));
}
