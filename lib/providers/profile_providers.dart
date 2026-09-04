import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile/profile.dart';
import '../data/profile/profile_storage.dart';
import '../i18n/gen/strings.g.dart';

final profileStorageProvider = Provider.family<ProfileStorage, String>((
  ref,
  namespace,
) {
  return ProfileStorage(namespace, ref);
});

final profileListProvider = FutureProvider.family<List<Profile>, String>((
  ref,
  namespace,
) {
  return ref.watch(profileStorageProvider(namespace)).loadAll();
});

/// The current [Profile] for [namespace], auto-creating a
/// [t.profile.defaultName]-named one on first use (see
/// `ProfileStorage.resolveCurrent`).
final currentProfileProvider = FutureProvider.family<Profile, String>((
  ref,
  namespace,
) {
  return ref
      .watch(profileStorageProvider(namespace))
      .resolveCurrent(t.profile.defaultName);
});
