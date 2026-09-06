import 'package:collection/collection.dart';

import '../data/physique_table/objectbox_physique_table_metadata_cache_repository.dart';

/// Resolves an antenna id to its physique table `anntenaCategory` string,
/// the same way the server's `resolveAntennaCategory` does — by matching
/// the antenna category link whose `antennaId` equals [antennaId] and
/// taking its `minor` field — but from cached metadata instead of a
/// database, so it works offline.
class PhysiqueAntennaCategoryResolver {
  const PhysiqueAntennaCategoryResolver(this._metadataCacheRepository);

  final PhysiqueTableMetadataCacheRepository _metadataCacheRepository;

  String? resolve(String antennaId) {
    final metadata = _metadataCacheRepository.cachedMetadata();
    if (metadata == null) return null;
    return metadata.physiqueAntennaCategoryAntennaLinks
        .firstWhereOrNull((link) => link.antennaId == antennaId)
        ?.minor;
  }
}
