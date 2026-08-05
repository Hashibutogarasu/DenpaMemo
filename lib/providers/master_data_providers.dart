import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/master_data/json_master_data_repository.dart';
import '../domain/master_data/master_data.dart';

final masterDataRepositoryProvider = Provider<MasterDataRepository>((ref) {
  return JsonMasterDataRepository();
});

final masterDataProvider = FutureProvider<MasterData>((ref) {
  final repository = ref.watch(masterDataRepositoryProvider);
  return repository.load();
});
