import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/denpa_men_icon/denpa_men_icon_storage.dart';

final denpaMenIconStorageProvider = Provider<DenpaMenIconStorage>((ref) {
  return DenpaMenIconStorage();
});

/// Loads the icon file for the `DenpaMen` with the given id, or null if it
/// has none set yet.
final denpaMenIconProvider = FutureProvider.family<File?, String>((
  ref,
  denpaMenId,
) {
  return ref.watch(denpaMenIconStorageProvider).loadIcon(denpaMenId);
});
