import 'package:app_metadata/app_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_metadata.freezed.dart';
part 'app_metadata.g.dart';

@AppMetaData()
@freezed
abstract class AppMetadataConfig with _$AppMetadataConfig {
  const factory AppMetadataConfig({
    required String author,
    required String license,
  }) = _AppMetadataConfig;
}
