import '../master_data/master_data.dart';
import 'denpa_men.dart';
import 'denpa_men_catch_order.dart';
import 'denpa_men_repository.dart';

/// Renumbers every directly-caught (empty [DenpaMen.parentIds]) individual
/// into a single app-wide [DenpaMen.catchOrder] sequence, then denormalizes
/// each bred individual's order from that numbering via
/// [DenpaMenCatchOrderResolution.resolveCatchOrder]. Runs once at startup.
void migrateDenpaMenCatchOrders(
  DenpaMenRepository repository,
  MasterData masterData,
) {
  final records = repository.getAll(masterData);
  final byId = <String, DenpaMen>{
    for (final record in records) record.denpaMen.id: record.denpaMen,
  };

  final directCatches = records
      .where((record) => record.denpaMen.parentIds.isEmpty)
      .toList();
  for (final (index, record) in directCatches.indexed) {
    final current = record.denpaMen;
    if (current.catchOrder == index) {
      continue;
    }
    final renumbered = current.copyWith(catchOrder: index);
    byId[current.id] = renumbered;
    repository.save(renumbered, id: record.id);
  }

  final bred = records
      .where((record) => record.denpaMen.parentIds.isNotEmpty)
      .toList();
  for (final record in bred) {
    final current = byId[record.denpaMen.id]!;
    final resolved = current.resolveCatchOrder(byId);
    if (current.catchOrder == resolved) {
      continue;
    }
    final denormalized = current.copyWith(catchOrder: resolved);
    byId[current.id] = denormalized;
    repository.save(denormalized, id: record.id);
  }
}
