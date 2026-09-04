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

/// Drives [ProfileSwitchPage](../pages/profile_switch_page.dart)'s data
/// operations for one [namespace] — creating, selecting, renaming, and
/// deleting [Profile]s — so the page itself only builds UI and reacts to
/// results.
class ProfileController {
  const ProfileController(this._ref, this.namespace);

  final Ref _ref;
  final String namespace;

  Future<Profile> create(String name) async {
    final storage = _ref.read(profileStorageProvider(namespace));
    final profile = await storage.create(name);
    await storage.saveCurrentId(profile.id);
    _ref.invalidate(profileListProvider(namespace));
    _ref.invalidate(currentProfileProvider(namespace));
    return profile;
  }

  Future<void> select(Profile profile) async {
    await _ref
        .read(profileStorageProvider(namespace))
        .saveCurrentId(profile.id);
    _ref.invalidate(currentProfileProvider(namespace));
  }

  Future<void> rename(Profile profile, String name) async {
    await _ref
        .read(profileStorageProvider(namespace))
        .update(profile.copyWith(name: name));
    _ref.invalidate(profileListProvider(namespace));
    _ref.invalidate(currentProfileProvider(namespace));
  }

  Future<void> delete(Profile profile) async {
    await _ref.read(profileStorageProvider(namespace)).delete(profile.id);
    _ref.invalidate(profileListProvider(namespace));
    _ref.invalidate(currentProfileProvider(namespace));
  }
}

final profileControllerProvider = Provider.family<ProfileController, String>((
  ref,
  namespace,
) {
  return ProfileController(ref, namespace);
});
