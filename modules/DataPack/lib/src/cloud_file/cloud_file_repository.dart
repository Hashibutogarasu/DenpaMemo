import 'cloud_file.dart';

/// Persists the [CloudFile]s this account has uploaded, as a local cache
/// of what the cloud already holds.
abstract class CloudFileRepository {
  List<CloudFile> getAll();

  void save(CloudFile cloudFile);

  void delete(String fileId);
}
