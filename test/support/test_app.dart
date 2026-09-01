import 'package:data_cache/data_cache.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/misc.dart' show Override;

import 'file_master_data_repository.dart';
import 'package:graphql_client/graphql_client.dart';

/// Shared override swapping the real GraphQL-backed
/// `masterDataRepositoryProvider` for [FileMasterDataRepository], so
/// widget tests get the same real game data as before the server
/// migration without needing a running `modules/server` instance.
final testMasterDataRepositoryOverride =
    masterDataRepositoryProvider.overrideWithValue(FileMasterDataRepository());

/// Drop-in replacement for [MyApp] in widget tests: identical except its
/// master data comes from [testMasterDataRepositoryOverride] instead of a
/// live server. Pass additional [overrides] for anything a specific test
/// needs on top of that.
class TestApp extends StatelessWidget {
  const TestApp({super.key, required this.objectBox, this.overrides = const []});

  final ObjectBox objectBox;
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) {
    return MyApp(
      objectBox: objectBox,
      cacheIndexRepository: CacheIndexRepository.createInMemory(),
      overrides: [testMasterDataRepositoryOverride, ...overrides],
    );
  }
}
