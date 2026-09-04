import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';

/// Reads and writes which clipping profile id, if any, each `DenpaMen`
/// individual is explicitly assigned to, stored alongside the ObjectBox
/// database directory (under the current account's
/// [accountScopedAppDirectoryProvider]) as one JSON file per individual
/// under `denpa-men-clipping-profiles/<denpaMenId>.json`. Deliberately
/// separate from both `ClippingSlotStorage` (which stores each profile's
/// crop rectangles) and `ProfileStorage` (which stores the profile pool
/// and, for other features, an app-wide "current" pick): an individual
/// with no file here has no profile assigned at all, so rendering code
/// must skip cropping and show its raw image, regardless of whatever
/// profile happens to be selected elsewhere in the app.
class DenpaMenClippingProfileStorage {
  const DenpaMenClippingProfileStorage(this._ref);

  final Ref _ref;

  Future<File> _file(String denpaMenId) async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    return File(
      path.join(
        appDirectory.path,
        'denpa-men-clipping-profiles',
        '$denpaMenId.json',
      ),
    );
  }

  Future<String?> load(String denpaMenId) async {
    final file = await _file(denpaMenId);
    if (!await file.exists()) {
      return null;
    }
    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return json['profileId'] as String?;
  }

  /// Assigns [denpaMenId] to [profileId], or clears its assignment
  /// (rendering code then skips cropping for it) when [profileId] is
  /// null.
  Future<void> save(String denpaMenId, String? profileId) async {
    final file = await _file(denpaMenId);
    if (profileId == null) {
      if (await file.exists()) {
        await file.delete();
      }
      return;
    }
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode({'profileId': profileId}));
  }
}
