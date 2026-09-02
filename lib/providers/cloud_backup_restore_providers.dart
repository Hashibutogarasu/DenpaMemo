import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide Translations, BuildContextTranslationsExtension;
import 'package:dm_file/dm_file.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../i18n/gen/strings.g.dart';
import 'account_scoped_paths_providers.dart';
import 'app_notification_providers.dart';
import 'cancellation.dart';
import 'cloud_files_providers.dart';
import 'denpa_men_icon_providers.dart';
import 'denpa_men_providers.dart';
import 'qr_code_providers.dart';

const _notificationKind = 'cloud_backup_restore';

/// Thrown by [CloudBackupRestoreController.restore] when there is no cloud
/// file to restore from.
class CloudBackupNotFoundException implements Exception {
  const CloudBackupNotFoundException();
}

/// The restore download's [AppNotification] within [notifications] (as
/// read from [appNotificationsProvider]), if any.
AppNotification? cloudBackupRestoreNotificationOf(List<AppNotification> notifications) =>
    notifications.firstWhereOrNull((n) => n.kind == _notificationKind);

/// Downloads the most recently uploaded cloud file and merges it into
/// local storage with [DMFile.readImport] (the same pipeline
/// `DmImportController` uses for a picked file), reporting progress and
/// outcome through [appNotificationsProvider].
class CloudBackupRestoreController {
  const CloudBackupRestoreController(this._ref);

  final Ref _ref;

  /// Returns the [ImportResult] once the download and merge complete, or
  /// null if the user declined to resolve duplicate individuals partway
  /// through. Throws [CloudBackupNotFoundException] if no cloud backup
  /// exists yet, or [CancelledException] if [cancellation] is requested
  /// during the download.
  Future<ImportResult?> restore(BuildContext context, {required Cancellation cancellation}) async {
    final t = context.t;
    final latest = _latestCloudFile();
    if (latest == null) {
      throw const CloudBackupNotFoundException();
    }

    final notifications = _ref.read(appNotificationsProvider.notifier);
    notifications.setStatus(_notificationKind, status: AppNotificationStatus.running, progress: 0);

    File? tempFile;
    try {
      final downloadUrl = await _ref
          .read(cloudFilesProvider.notifier)
          .getDownloadLink(latest.fileId);
      final bytes = await _downloadWithProgress(
        Uri.parse(downloadUrl),
        cancellation: cancellation,
        onProgress: (received, total) {
          if (total == null) return;
          notifications.setStatus(
            _notificationKind,
            status: AppNotificationStatus.running,
            progress: (received / total) * 0.5,
          );
        },
      );

      tempFile = await _writeToTempFile(latest.filename, bytes);
      final masterData = _ref.read(masterDataProvider).value!;
      final storage = _ref.read(denpaMenIconStorageProvider);

      notifications.setStatus(_notificationKind, status: AppNotificationStatus.running, progress: 0.5);
      final result = await DMFile.readImport(
        inputFile: tempFile,
        masterData: masterData,
        denpaMenRepository: _ref.read(denpaMenRepositoryProvider),
        qrCodeRepository: _ref.read(qrCodeRepositoryProvider),
        loadIcon: storage.loadIcon,
        saveIcon: (denpaMenId, iconFile) async {
          await storage.saveIcon(denpaMenId, iconFile);
          _ref.invalidate(denpaMenIconProvider(denpaMenId));
        },
        resolveDuplicates: (candidates) => DenpaMenSelectionDialog.show(
          context,
          title: t.home.importMergeConfirmTitle,
          candidates: candidates,
          initial: candidates,
          totalAttributeCount: masterData.attributes.length,
        ),
        onProgress: (value) {
          if (value == null) return;
          notifications.setStatus(
            _notificationKind,
            status: AppNotificationStatus.running,
            progress: 0.5 + value * 0.5,
          );
        },
      );

      notifications.setStatus(
        _notificationKind,
        status: result == null ? AppNotificationStatus.cancelled : AppNotificationStatus.completed,
        progress: result == null ? null : 1,
      );
      return result;
    } on CancelledException {
      notifications.setStatus(_notificationKind, status: AppNotificationStatus.cancelled);
      rethrow;
    } catch (error) {
      notifications.setStatus(_notificationKind, status: AppNotificationStatus.failed, message: '$error');
      rethrow;
    } finally {
      await tempFile?.delete();
    }
  }

  /// The most recently uploaded [CloudFile] from
  /// [cloudFilesProvider]'s local cache, or null if it is empty.
  CloudFile? _latestCloudFile() {
    final cloudFiles = [..._ref.read(cloudFilesProvider)]
      ..sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt));
    return cloudFiles.firstOrNull;
  }

  /// Streams the response body at [uri], reporting [onProgress] with the
  /// bytes received so far and the total byte count (null if the response
  /// carries no `Content-Length`). Throws [CancelledException] (closing
  /// the connection) as soon as [cancellation] is observed requested.
  Future<Uint8List> _downloadWithProgress(
    Uri uri, {
    required Cancellation cancellation,
    required void Function(int received, int? total) onProgress,
  }) async {
    final client = http.Client();
    try {
      final response = await client.send(http.Request('GET', uri));
      final total = response.contentLength;
      final builder = BytesBuilder(copy: false);
      var received = 0;
      await for (final chunk in response.stream) {
        if (cancellation.isRequested) {
          throw const CancelledException();
        }
        builder.add(chunk);
        received += chunk.length;
        onProgress(received, total);
      }
      return builder.takeBytes();
    } finally {
      client.close();
    }
  }

  /// Writes [bytes] as [filename] under the current account's temporary
  /// directory, since [DMFile.readImport] reads from a [File] rather than
  /// raw bytes.
  Future<File> _writeToTempFile(String filename, Uint8List bytes) async {
    final tempDirectory = await _ref.read(accountScopedTempDirectoryProvider.future);
    final file = File(path.join(tempDirectory.path, filename));
    return file.writeAsBytes(bytes);
  }
}

final cloudBackupRestoreControllerProvider = Provider<CloudBackupRestoreController>(
  (ref) => CloudBackupRestoreController(ref),
);
