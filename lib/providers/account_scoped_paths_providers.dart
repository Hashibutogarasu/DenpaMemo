import 'dart:io';

import 'package:app_datas/app_datas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'account_providers.dart';

/// The current account's persistent data directory. Every feature that
/// needs to read/write files scoped to the current account (icon storage,
/// and anything added later) should depend on this provider instead of
/// resolving the app id and account id itself.
final accountScopedAppDirectoryProvider = FutureProvider<Directory>((
  ref,
) async {
  final account = ref.watch(currentAccountProvider);
  final packageInfo = await PackageInfo.fromPlatform();
  return AppPaths.appDirectory(packageInfo.packageName, account.account.cuid);
});

/// The current account's temporary data directory, for the same reason as
/// [accountScopedAppDirectoryProvider].
final accountScopedTempDirectoryProvider = FutureProvider<Directory>((
  ref,
) async {
  final account = ref.watch(currentAccountProvider);
  final packageInfo = await PackageInfo.fromPlatform();
  return AppPaths.tempAppDirectory(
    packageInfo.packageName,
    account.account.cuid,
  );
});
