import 'denpa_men_repository.dart';
import '../master_data/master_data.dart';

/// Renumbers [DenpaMen.catchOrder](denpa_men.dart) for every directly-caught
/// (empty [DenpaMen.parentIds](denpa_men.dart)) individual into a single
/// sequence unique across the whole app, ordered by [repository]'s capture
/// order (see [DenpaMenRepository.getAll]). Replaces the pre-fix numbering
/// that restarted at zero for every QR code, which let individuals caught
/// under different QR codes collide on the same value and, through
/// [DenpaMenCatchOrderResolution.newCatchOrder](denpa_men_catch_order.dart),
/// show the same catch-order badge in the lineage tree. Intended to run
/// once at startup before the UI starts reading from [repository].
void migrateDenpaMenCatchOrders(
  DenpaMenRepository repository,
  MasterData masterData,
) {
  final directCatches = repository
      .getAll(masterData)
      .where((record) => record.denpaMen.parentIds.isEmpty)
      .toList();
  for (final (index, record) in directCatches.indexed) {
    // ignore: deprecated_member_use_from_same_package
    if (record.denpaMen.catchOrder != index) {
      repository.save(
        // ignore: deprecated_member_use_from_same_package
        record.denpaMen.copyWith(catchOrder: index),
        id: record.id,
      );
    }
  }
}
