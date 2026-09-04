import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'cloud_files_providers.dart';

final cloudFileSelectionModeProvider = StateProvider<bool>((ref) => false);

final selectedCloudFileIdsProvider = StateProvider<Set<String>>((ref) => {});

void toggleCloudFileSelected(WidgetRef ref, String fileId) {
  final selected = Set<String>.from(ref.read(selectedCloudFileIdsProvider));
  if (!selected.remove(fileId)) {
    selected.add(fileId);
  }
  ref.read(selectedCloudFileIdsProvider.notifier).state = selected;
}

/// [cloudFilesProvider], sorted by [CloudFile.uploadedAt] descending, so
/// the newest upload is first.
final sortedCloudFilesProvider = Provider<List<CloudFile>>((ref) {
  return [...ref.watch(cloudFilesProvider)]
    ..sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt));
});

/// Fires [CloudFilesNotifier.refreshFromServer] once per watch — the
/// backup history page watches this purely for the side effect, and reads
/// [sortedCloudFilesProvider] for the list content, so the list still
/// renders from the local cache immediately and updates once this
/// completes.
final cloudFilesSyncProvider = FutureProvider.autoDispose<void>((ref) {
  return ref.read(cloudFilesProvider.notifier).refreshFromServer();
});
