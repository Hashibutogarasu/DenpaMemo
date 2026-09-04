import 'dart:convert';
import 'dart:io';

import 'package:cuid2/cuid2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';
import 'profile.dart';

/// Reads and writes one [namespace]'s list of [Profile]s and which one is
/// current, stored alongside the ObjectBox database directory (under the
/// current account's [accountScopedAppDirectoryProvider]) under
/// `profiles/<namespace>/`. Entirely domain-agnostic: [namespace] is just
/// an opaque string a feature picks for itself (e.g. `'clipping-slots'`)
/// so its profile pool doesn't collide with any other feature's.
class ProfileStorage {
  const ProfileStorage(this.namespace, this._ref);

  final String namespace;
  final Ref _ref;

  Future<Directory> _namespaceDirectory() async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    return Directory(path.join(appDirectory.path, 'profiles', namespace));
  }

  Future<File> _profilesFile() async {
    final directory = await _namespaceDirectory();
    return File(path.join(directory.path, 'profiles.json'));
  }

  Future<File> _currentFile() async {
    final directory = await _namespaceDirectory();
    return File(path.join(directory.path, 'current.json'));
  }

  Future<List<Profile>> loadAll() async {
    final file = await _profilesFile();
    if (!await file.exists()) {
      return [];
    }
    final json = jsonDecode(await file.readAsString()) as List<dynamic>;
    return [
      for (final entry in json) Profile.fromJson(entry as Map<String, dynamic>),
    ];
  }

  Future<void> _saveAll(List<Profile> profiles) async {
    final file = await _profilesFile();
    await file.parent.create(recursive: true);
    await file.writeAsString(
      jsonEncode([for (final profile in profiles) profile.toJson()]),
    );
  }

  Future<Profile> create(String name) async {
    final profiles = await loadAll();
    final profile = Profile(id: cuid(), name: name);
    await _saveAll([...profiles, profile]);
    return profile;
  }

  /// Replaces the stored profile with the same [Profile.id] as
  /// [updated]. Does nothing if no profile with that id is stored.
  Future<void> update(Profile updated) async {
    final profiles = await loadAll();
    await _saveAll([
      for (final profile in profiles)
        if (profile.id == updated.id) updated else profile,
    ]);
  }

  /// Removes the profile with [profileId], if any. If it was the current
  /// profile, [loadCurrentId] keeps pointing at the now-deleted id until
  /// the next [resolveCurrent] call, which falls back to another
  /// existing profile (or creates a fresh default one) automatically.
  Future<void> delete(String profileId) async {
    final profiles = await loadAll();
    await _saveAll([
      for (final profile in profiles)
        if (profile.id != profileId) profile,
    ]);
  }

  Future<String?> loadCurrentId() async {
    final file = await _currentFile();
    if (!await file.exists()) {
      return null;
    }
    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return json['profileId'] as String?;
  }

  Future<void> saveCurrentId(String profileId) async {
    final file = await _currentFile();
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode({'profileId': profileId}));
  }

  /// Returns the current profile if one has been explicitly selected (by
  /// [saveCurrentId], directly or via [resolveCurrent]), else null.
  /// Unlike [resolveCurrent], never creates or selects a profile as a
  /// side effect — for callers that must tell "nothing selected yet"
  /// apart from "selected, but not configured".
  Future<Profile?> peekCurrent() async {
    final currentId = await loadCurrentId();
    if (currentId == null) {
      return null;
    }
    final profiles = await loadAll();
    for (final profile in profiles) {
      if (profile.id == currentId) {
        return profile;
      }
    }
    return null;
  }

  /// Returns the current profile, first falling back to any existing
  /// profile, then creating and selecting a new one named [defaultName]
  /// if there are none yet. Callers never need to check for an
  /// unconfigured namespace themselves.
  Future<Profile> resolveCurrent(String defaultName) async {
    final profiles = await loadAll();
    final currentId = await loadCurrentId();
    if (currentId != null) {
      for (final profile in profiles) {
        if (profile.id == currentId) {
          return profile;
        }
      }
    }
    if (profiles.isNotEmpty) {
      await saveCurrentId(profiles.first.id);
      return profiles.first;
    }
    final created = await create(defaultName);
    await saveCurrentId(created.id);
    return created;
  }
}
