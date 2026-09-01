import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Resolves the directories under which an app keeps its files, all rooted
/// under a single per-app subdirectory named after the caller-supplied
/// [appId] (typically the platform application id). Callers are
/// responsible for obtaining [appId] themselves; this class only decides
/// how directories are laid out beneath it.
class AppPaths {
  const AppPaths._();

  /// The current account's persistent data directory:
  /// `<ApplicationDocumentsDirectory>/<appId>/<accountId>/`.
  static Future<Directory> appDirectory(String appId, String accountId) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final directory = Directory(
      path.join(documentsDirectory.path, appId, accountId),
    );
    await directory.create(recursive: true);
    return directory;
  }

  /// The current account's temporary data directory:
  /// `<TemporaryDirectory>/<appId>/<accountId>/`.
  static Future<Directory> tempAppDirectory(
    String appId,
    String accountId,
  ) async {
    final temporaryDirectory = await getTemporaryDirectory();
    final directory = Directory(
      path.join(temporaryDirectory.path, appId, accountId),
    );
    await directory.create(recursive: true);
    return directory;
  }

  /// The directory the ObjectBox store should open in:
  /// `<ApplicationDocumentsDirectory>/<appId>/objectbox`. Not scoped by
  /// account, since the store itself is what accounts are read from.
  static Future<Directory> objectboxDirectory(String appId) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return Directory(path.join(documentsDirectory.path, appId, 'objectbox'));
  }

  /// The directory the offline data cache's SQLite database should open in:
  /// `<ApplicationDocumentsDirectory>/<appId>/local_cache`. Not scoped by
  /// account, matching [objectboxDirectory].
  static Future<Directory> localCacheDirectory(String appId) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return Directory(path.join(documentsDirectory.path, appId, 'local_cache'));
  }
}
