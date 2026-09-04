import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import 'denpa_men_sync_providers.dart';

/// Runs every startup data task that must finish before the denpa men list
/// is usable: fetching [masterDataProvider] and syncing stored records
/// against it via [DenpaMenSyncService]. The single provider the app root
/// watches once at launch, kept independent of the splash screen so the
/// splash never needs to know what is loading.
final appInitializationProvider = FutureProvider<void>((ref) async {
  final masterData = await ref.watch(masterDataProvider.future);
  final service = ref.watch(denpaMenSyncServiceProvider);
  await service.sync(masterData);
});
