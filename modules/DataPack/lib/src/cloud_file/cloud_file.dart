import 'package:freezed_annotation/freezed_annotation.dart';

part 'cloud_file.freezed.dart';

/// A `.dm` file backed up to the cloud, tracked locally once its upload
/// completes so [CloudFileRepository] can list it without re-querying the
/// server every time.
@freezed
abstract class CloudFile with _$CloudFile {
  const factory CloudFile({
    required String fileId,
    required String filename,
    required DateTime uploadedAt,
  }) = _CloudFile;
}
