import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';

class _ClippingRenderCacheInput {
  const _ClippingRenderCacheInput({
    required this.rawFileModifiedMillis,
    required this.rawFileSize,
    required this.clippingSlot,
  });

  final int rawFileModifiedMillis;
  final int rawFileSize;
  final ClippingSlot clippingSlot;

  factory _ClippingRenderCacheInput.fromJson(Map<String, dynamic> json) {
    return _ClippingRenderCacheInput(
      rawFileModifiedMillis: json['rawFileModifiedMillis'] as int,
      rawFileSize: json['rawFileSize'] as int,
      clippingSlot: ClippingSlot.fromJson(
        json['clippingSlot'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'rawFileModifiedMillis': rawFileModifiedMillis,
    'rawFileSize': rawFileSize,
    'clippingSlot': clippingSlot.toJson(),
  };
}

class _ClippingRenderCacheOutput {
  const _ClippingRenderCacheOutput({required this.path});

  final String path;

  factory _ClippingRenderCacheOutput.fromJson(Map<String, dynamic> json) {
    return _ClippingRenderCacheOutput(path: json['path'] as String);
  }

  Map<String, dynamic> toJson() => {'path': path};
}

/// Applies [clippingSlot]'s relative crop rectangle to [rawFile]
/// in-memory, or returns [rawFile] unmodified if [clippingSlot] is
/// null. Entirely entity-agnostic: works the same for any raw image a
/// caller has saved, given whichever [ClippingSlot] currently applies
/// to it — callers only need to make sure their own provider watches
/// both the raw image and the [ClippingSlot] so switching clipping
/// profiles or re-registering a crop takes effect immediately.
/// [cacheKey] should uniquely identify the raw image/slot pair.
///
/// Reuses [dataCacheProvider]'s hash-comparison cache (the same
/// mechanism the denpa men resistance calculation cache uses) keyed by
/// [cacheKey], comparing the raw file's size/modified time and
/// [clippingSlot]'s own fields against what produced the last cached
/// result — recropping in-memory only when one of those actually
/// changed, rather than on every read. This is what keeps a long list
/// of already-cropped thumbnails from re-running `copyCrop` on every
/// rebuild.
///
/// The rendered file's name includes a hash of [input], rather than
/// staying fixed per [cacheKey]: `Image.file` resolves through
/// Flutter's engine-level image cache, keyed only by file path, so
/// overwriting one fixed path would leave already-displayed widgets
/// showing the old crop until the app restarts.
Future<File?> renderClippedImage(
  Ref ref, {
  required File? rawFile,
  required ClippingSlot? clippingSlot,
  required String cacheKey,
}) async {
  if (rawFile == null) {
    return null;
  }
  if (clippingSlot == null) {
    return rawFile;
  }

  final cache = ref.read(dataCacheProvider);
  final stat = await rawFile.stat();
  final input = _ClippingRenderCacheInput(
    rawFileModifiedMillis: stat.modified.millisecondsSinceEpoch,
    rawFileSize: stat.size,
    clippingSlot: clippingSlot,
  );

  final cached = await cache.read<
    _ClippingRenderCacheInput,
    _ClippingRenderCacheOutput
  >(
    cacheKey,
    inputFromJson: _ClippingRenderCacheInput.fromJson,
    outputFromJson: _ClippingRenderCacheOutput.fromJson,
  );
  if (cached != null) {
    final unchanged = !await cache.canMerge(cacheKey, input, cached.output);
    final cachedFile = File(cached.output.path);
    if (unchanged && await cachedFile.exists()) {
      return cachedFile;
    }
  }

  final source = img.decodeImage(await rawFile.readAsBytes());
  if (source == null) {
    return rawFile;
  }
  final cropped = img.copyCrop(
    source,
    x: (clippingSlot.left * source.width).round(),
    y: (clippingSlot.top * source.height).round(),
    width: (clippingSlot.width * source.width).round(),
    height: (clippingSlot.height * source.height).round(),
  );

  final tempDirectory = await ref.read(
    accountScopedTempDirectoryProvider.future,
  );
  final fingerprint = sha1
      .convert(utf8.encode(jsonEncode(input.toJson())))
      .toString()
      .substring(0, 16);
  final renderedFile = File(
    path.join(tempDirectory.path, '$cacheKey-$fingerprint.png'),
  );
  await renderedFile.writeAsBytes(img.encodePng(cropped));

  final stalePath = cached?.output.path;
  if (stalePath != null && stalePath != renderedFile.path) {
    final staleFile = File(stalePath);
    if (await staleFile.exists()) {
      await staleFile.delete();
    }
  }

  await cache.save(
    cacheKey,
    input,
    _ClippingRenderCacheOutput(path: renderedFile.path),
  );
  return renderedFile;
}
