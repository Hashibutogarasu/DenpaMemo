import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/icon/entity_icon_storage.dart';

final denpaMenIconStorageProvider = Provider<EntityIconStorage>((ref) {
  return const EntityIconStorage('denpamens');
});

/// Loads the icon file for the `DenpaMen` with the given id, or null if it
/// has none set yet.
final denpaMenIconProvider = FutureProvider.family<File?, String>((
  ref,
  denpaMenId,
) {
  return ref.watch(denpaMenIconStorageProvider).loadIcon(denpaMenId);
});
