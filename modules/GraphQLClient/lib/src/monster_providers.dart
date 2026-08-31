import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'graphql_client_provider.dart';
import 'monster/graphql_monster_repository.dart';

final monsterRepositoryProvider = Provider<MonsterRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return GraphqlMonsterRepository(client: client);
});

final monsterListProvider = FutureProvider<List<Monster>>((ref) {
  final repository = ref.watch(monsterRepositoryProvider);
  return repository.load();
}, retry: (_, _) => null);
