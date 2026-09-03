import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql_client_provider.dart';
import 'graphql_physique_antenna_category_repository.dart';

final physiqueAntennaCategoryRepositoryProvider =
    Provider<GraphqlPhysiqueAntennaCategoryRepository>((ref) {
      final client = ref.watch(graphQLClientProvider);
      return GraphqlPhysiqueAntennaCategoryRepository(client: client);
    });

final physiqueTableMetadataProvider = FutureProvider<PhysiqueTableMetadata>((
  ref,
) {
  final repository = ref.watch(physiqueAntennaCategoryRepositoryProvider);
  return repository.load();
});
