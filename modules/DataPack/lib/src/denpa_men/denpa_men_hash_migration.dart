import '../master_data/master_data.dart';
import 'denpa_men_hash.dart';
import 'denpa_men_repository.dart';

/// Recomputes [DenpaMen.hash] for every persisted record whose stored hash
/// is missing or stale, and writes the corrected value back. Intended to
/// run once at startup before the UI starts reading from [repository].
void migrateDenpaMenHashes(
  DenpaMenRepository repository,
  MasterData masterData,
) {
  for (final record in repository.getAll(masterData)) {
    final expected = computeDenpaMenHash(record.denpaMen);
    if (record.denpaMen.hash != expected) {
      repository.save(record.denpaMen.copyWith(hash: expected), id: record.id);
    }
  }
}
