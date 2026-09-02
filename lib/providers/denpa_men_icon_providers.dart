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

/// Resolves every id in [denpaMenIds] to its icon file via [loadIcon], for
/// callers (e.g. `ExportCompleteDialog.show`, `ImportCompleteDialog.show`,
/// `resolveDuplicates` callbacks) that need a `Map<String, File?>` up
/// front rather than resolving each icon reactively. [loadIcon] is a
/// plain callback rather than a `Ref`/`WidgetRef` parameter, since callers
/// reach this from both widget code (`WidgetRef`) and plain controllers
/// (`Ref`) — pass `(id) => ref.read(denpaMenIconProvider(id).future)` from
/// either.
Future<Map<String, File?>> resolveDenpaMenIcons(
  Future<File?> Function(String id) loadIcon,
  Iterable<String> denpaMenIds,
) async {
  final ids = denpaMenIds.toSet();
  final files = await Future.wait(ids.map(loadIcon));
  return Map.fromIterables(ids, files);
}
