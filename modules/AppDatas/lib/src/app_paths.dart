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

  /// The app's persistent data directory:
  /// `<ApplicationDocumentsDirectory>/<appId>/`.
  static Future<Directory> appDirectory(String appId) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final directory = Directory(path.join(documentsDirectory.path, appId));
    await directory.create(recursive: true);
    return directory;
  }

  /// The app's temporary data directory:
  /// `<TemporaryDirectory>/<appId>/`.
  static Future<Directory> tempAppDirectory(String appId) async {
    final temporaryDirectory = await getTemporaryDirectory();
    final directory = Directory(path.join(temporaryDirectory.path, appId));
    await directory.create(recursive: true);
    return directory;
  }

  /// The directory the ObjectBox store should open in:
  /// `<appDirectory>/objectbox`.
  static Future<Directory> objectboxDirectory(String appId) async {
    final appDir = await appDirectory(appId);
    return Directory(path.join(appDir.path, 'objectbox'));
  }
}
