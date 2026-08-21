import '../denpa_men/denpa_men.dart';
import '../denpa_men/denpa_men_repository.dart';
import '../master_data/master_data.dart';

/// Whether any of [candidates] matches an existing record by
/// [DenpaMen.id] (cuid) in [repository].
bool hasAnyDuplicateDenpaMen(
  List<DenpaMen> candidates,
  DenpaMenRepository repository,
  MasterData masterData,
) {
  return candidates.any(
    (denpaMen) => repository.findByCuid(denpaMen.id, masterData) != null,
  );
}
