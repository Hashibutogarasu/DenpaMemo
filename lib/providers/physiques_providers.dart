import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/physique_server_config.dart';
import '../data/server/physiques_api_client.dart';

final physiquesApiClientProvider = Provider<PhysiquesApiClient>(
  (ref) => PhysiquesApiClient(Uri.parse(physiqueServerConfig.baseUrl)),
);

/// Every `anntenaCategory` that has at least one row saved at any level,
/// derived from one unfiltered `GET /physiques` fetch. Used by
/// [PhysiqueTableListPage] to decide which antenna categories show an
/// edit shortcut.
final physiqueTableAnntenaCategoriesWithDataProvider = FutureProvider<Set<String>>((ref) async {
  final client = ref.watch(physiquesApiClientProvider);
  final records = await client.fetch();
  return {for (final record in records) record.anntenaCategory};
});
