import 'denpa_men_hash.dart';
import 'denpa_men_record.dart';
import 'denpa_men_repository.dart';

/// Recomputes [DenpaMen.hash] for every record in [records] whose stored
/// hash is missing or stale, and writes the corrected value back to
/// [repository]. Intended to run once at startup before the UI starts
/// reading from [repository], against a [records] list the caller already
/// fetched (so callers doing further work over the same records don't pay
/// for a second full [DenpaMenRepository.getAll] pass). Yields to the event
/// loop between records so a large record set doesn't block a single frame.
Future<void> migrateDenpaMenHashes(
  DenpaMenRepository repository,
  List<DenpaMenRecord> records,
) async {
  for (final record in records) {
    final expected = computeDenpaMenHash(record.denpaMen);
    if (record.denpaMen.hash != expected) {
      repository.save(record.denpaMen.copyWith(hash: expected), id: record.id);
    }
    await Future(() {});
  }
}
