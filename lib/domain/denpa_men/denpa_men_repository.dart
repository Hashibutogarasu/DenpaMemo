import '../master_data/master_data.dart';
import 'denpa_men.dart';
import 'denpa_men_record.dart';

/// Persists [DenpaMen] entries as a list, keyed by an opaque storage id.
///
/// Implementations resolve the master-data references embedded in a
/// [DenpaMen] (head shape, physique, personality, pattern, antenna,
/// corrections) against the [MasterData] passed to [watchAll] / [getAll],
/// so callers must supply the same [MasterData] the entries were created
/// with.
abstract class DenpaMenRepository {
  List<DenpaMenRecord> getAll(MasterData masterData);

  /// Emits the current list immediately, then again on every change.
  Stream<List<DenpaMenRecord>> watchAll(MasterData masterData);

  /// Inserts [denpaMen] when [id] is 0 (the default), otherwise updates the
  /// existing record with that id. Returns the resulting record id.
  int save(DenpaMen denpaMen, {int id = 0});

  void delete(int id);

  /// Resolves [denpaMen]'s `parentIds` to the parent [DenpaMenRecord]s they
  /// reference.
  List<DenpaMenRecord> getChildrens(DenpaMen denpaMen, MasterData masterData);
}
