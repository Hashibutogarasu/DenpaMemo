import 'dart:typed_data';

import 'package:data_pack/data_pack.dart';
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../data/cloud_file/objectbox_cloud_file_repository.dart';
import 'cloud_account_providers.dart';
import 'objectbox_providers.dart';

final cloudFileRepositoryProvider = Provider<CloudFileRepository>(
  (ref) => ObjectBoxCloudFileRepository(ref.watch(objectBoxProvider)),
);

/// Drives `GET /dmfile/link`, `GET /dmfile/download/:fileId`, and
/// `DELETE /dmfile`. The list this exposes is read from
/// [cloudFileRepositoryProvider]'s local cache, not fetched fresh from
/// `GET /dmfiles` on every read — a cloud file only appears here once its
/// upload has completed and been registered locally.
class CloudFilesNotifier extends Notifier<List<CloudFile>> {
  @override
  List<CloudFile> build() => ref.watch(cloudFileRepositoryProvider).getAll();

  /// Awaits [firebaseSignInProvider]'s build before reading its notifier,
  /// since [FirebaseSignInNotifier] only sets up its backend at the end of
  /// that build — calling `.notifier` beforehand crashes with a null
  /// check on the not-yet-assigned backend.
  Future<String> _requireIdToken() async {
    await ref.read(firebaseSignInProvider.future);
    final idToken = await ref.read(firebaseSignInProvider.notifier).getIdToken();
    if (idToken == null) {
      throw const NotSignedInException();
    }
    return idToken;
  }

  /// Requests an upload link via GET /dmfile/link, PUTs [bytes] to the
  /// returned uploadUrl, then registers the resulting [CloudFile] locally.
  /// Throws [CloudUploadFailedException] if R2 rejects the PUT, so a failed
  /// upload is never mistaken for a completed one.
  Future<CloudFile> uploadDmFile(String filename, Uint8List bytes) async {
    final idToken = await _requireIdToken();
    final link = await ref.read(authApiClientProvider).requestUploadLink(idToken, filename);
    final response = await http.put(Uri.parse(link.uploadUrl), body: bytes);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw CloudUploadFailedException(response.statusCode);
    }
    final cloudFile = CloudFile(
      fileId: link.fileId,
      filename: link.filename,
      uploadedAt: DateTime.now(),
    );
    ref.read(cloudFileRepositoryProvider).save(cloudFile);
    state = ref.read(cloudFileRepositoryProvider).getAll();
    return cloudFile;
  }

  /// Calls GET /dmfile/download/:fileId and returns the signed download URL.
  Future<String> getDownloadLink(String fileId) async {
    final idToken = await _requireIdToken();
    return ref.read(authApiClientProvider).requestDownloadLink(idToken, fileId);
  }

  /// Calls DELETE /dmfile, then removes the file from the local cache.
  Future<void> deleteCloudFile(String fileId) async {
    final idToken = await _requireIdToken();
    await ref.read(authApiClientProvider).deleteCloudFile(idToken, fileId);
    ref.read(cloudFileRepositoryProvider).delete(fileId);
    state = ref.read(cloudFileRepositoryProvider).getAll();
  }

  /// Calls DELETE /dmfile once per id in [fileIds] (the server has no
  /// batch-delete endpoint), then refreshes state once at the end rather
  /// than after every request.
  Future<void> deleteCloudFiles(Iterable<String> fileIds) async {
    final idToken = await _requireIdToken();
    for (final fileId in fileIds) {
      await ref.read(authApiClientProvider).deleteCloudFile(idToken, fileId);
      ref.read(cloudFileRepositoryProvider).delete(fileId);
    }
    state = ref.read(cloudFileRepositoryProvider).getAll();
  }

  /// Reconciles the local cache against GET /dmfiles, so a file uploaded
  /// from — or deleted on — another device on the same account is
  /// reflected here too, rather than only ever seeing this device's own
  /// uploads.
  Future<void> refreshFromServer() async {
    final idToken = await _requireIdToken();
    final serverFiles = await ref.read(authApiClientProvider).listDmFiles(idToken);
    final serverFileIds = {for (final file in serverFiles) file.fileId};
    final repository = ref.read(cloudFileRepositoryProvider);
    for (final cloudFile in repository.getAll()) {
      if (!serverFileIds.contains(cloudFile.fileId)) {
        repository.delete(cloudFile.fileId);
      }
    }
    for (final file in serverFiles) {
      repository.save(
        CloudFile(fileId: file.fileId, filename: file.filename, uploadedAt: file.uploaded),
      );
    }
    state = repository.getAll();
  }
}

/// Thrown by [CloudFilesNotifier.uploadDmFile] when R2 responds to the PUT
/// with a non-2xx status.
class CloudUploadFailedException implements Exception {
  const CloudUploadFailedException(this.statusCode);

  final int statusCode;

  @override
  String toString() => 'CloudUploadFailedException($statusCode)';
}

final cloudFilesProvider = NotifierProvider<CloudFilesNotifier, List<CloudFile>>(
  CloudFilesNotifier.new,
);
