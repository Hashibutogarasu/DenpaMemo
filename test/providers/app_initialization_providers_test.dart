import 'package:api_client/api_client.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/providers/app_initialization_providers.dart';
import 'package:denpa_memo/providers/objectbox_providers.dart';
import 'package:denpa_memo/providers/physique_table_cache_providers.dart';
import 'package:denpa_memo/providers/physiques_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_client/graphql_client.dart';

class _FailingMasterDataRepository implements MasterDataRepository {
  @override
  Future<MasterData> load() => throw Exception('master data unreachable');
}

class _FakePhysiquesApiClient extends PhysiquesApiClient {
  _FakePhysiquesApiClient({required this.categories}) : super(Uri.parse('http://unused.invalid'));

  final List<PhysiqueEvasionRateCategoryRow> categories;

  @override
  Future<List<TableDefinition>> fetchTypes() async => const [];

  @override
  Future<List<PhysiqueEvasionRateCategoryRow>> fetchEvasionRateCategories() async => categories;
}

void main() {
  test(
    'masterDataProvider rejects promptly when its repository fails, without retrying',
    () async {
      final container = ProviderContainer(
        overrides: [
          masterDataRepositoryProvider.overrideWithValue(_FailingMasterDataRepository()),
        ],
      );
      addTearDown(container.dispose);

      await expectLater(container.read(masterDataProvider.future), throwsException);
    },
  );

  test(
    'appInitializationProvider completes promptly instead of retrying when master data fails',
    () async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);

      final container = ProviderContainer(
        overrides: [
          objectBoxProvider.overrideWithValue(objectBox),
          masterDataRepositoryProvider.overrideWithValue(_FailingMasterDataRepository()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(appInitializationProvider.future);
    },
  );

  test(
    'a failure fetching master data does not prevent the physique-table caches from being warmed',
    () async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);

      final metadata = PhysiqueTableMetadata(
        physiqueAntennaCategories: const [],
        physiqueStatusCategories: const [],
        physiqueAntennaCategoryAntennaLinks: const [],
      );
      const categories = [
        PhysiqueEvasionRateCategoryRow(
          id: 'largest',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 3,
          textKey: 'largest',
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          objectBoxProvider.overrideWithValue(objectBox),
          masterDataRepositoryProvider.overrideWithValue(_FailingMasterDataRepository()),
          physiquesApiClientProvider.overrideWithValue(_FakePhysiquesApiClient(categories: categories)),
          physiqueTableMetadataProvider.overrideWith((ref) async => metadata),
        ],
      );
      addTearDown(container.dispose);

      await container.read(appInitializationProvider.future);

      expect(container.read(physiqueTableMetadataCacheRepositoryProvider).cachedMetadata(), metadata);
      expect(container.read(physiqueTableMetadataCacheRepositoryProvider).cachedTableTypes(), const []);
      expect(container.read(evasionRateCategoryCacheRepositoryProvider).cachedCategories(), categories);
    },
  );
}
