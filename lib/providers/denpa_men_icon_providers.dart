import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/icon/entity_icon_storage.dart';

final denpaMenIconStorageProvider = Provider<EntityIconStorage>((ref) {
  return EntityIconStorage('denpamens', ref);
});

/// Loads the icon file for the `DenpaMen` with the given id, or null if it
/// has none set yet.
final denpaMenIconProvider = FutureProvider.family<File?, String>((
  ref,
  denpaMenId,
) {
  return ref.watch(denpaMenIconStorageProvider).loadIcon(denpaMenId);
});

/// Resolves every id in [denpaMenIds] to its icon file via
/// [denpaMenIconProvider], for callers (e.g. `ExportCompleteDialog.show`,
/// `ImportCompleteDialog.show`) that need a `Map<String, File?>` up front
/// rather than resolving each icon reactively.
Future<Map<String, File?>> resolveDenpaMenIcons(WidgetRef ref, Iterable<String> denpaMenIds) async {
  final ids = denpaMenIds.toSet();
  final files = await Future.wait(
    ids.map((id) => ref.read(denpaMenIconProvider(id).future)),
  );
  return Map.fromIterables(ids, files);
}
