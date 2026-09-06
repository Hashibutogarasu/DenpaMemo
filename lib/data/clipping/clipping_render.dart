import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart' as img;

/// Caches every rendered crop this app produces, keyed by a fingerprint of
/// its inputs (see [renderClippedImage]) rather than by a fixed per-entity
/// key, so a stale entry is simply never looked up again instead of needing
/// to be deleted by hand — [flutter_cache_manager] ages out whichever
/// entries haven't been read in [stalePeriod] or once the cache holds more
/// than [maxNrOfCacheObjects], on its own.
final CacheManager clippedImageCacheManager = CacheManager(
  Config(
    'clippedImageCache',
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 500,
  ),
);

/// Applies [clippingSlot]'s relative crop rectangle to [rawFile]
/// in-memory, or returns [rawFile] unmodified if [clippingSlot] is
/// null. Entirely entity-agnostic: works the same for any raw image a
/// caller has saved, given whichever [ClippingSlot] currently applies
/// to it — callers only need to make sure their own provider watches
/// both the raw image and the [ClippingSlot] so switching clipping
/// profiles or re-registering a crop takes effect immediately.
/// [cacheKey] should uniquely identify the raw image/slot pair.
///
/// The actual cropped bytes are stored in [clippedImageCacheManager],
/// keyed by [cacheKey] plus a fingerprint of [rawFile]'s size/modified
/// time and [clippingSlot]'s own fields, so `copyCrop` only reruns when
/// one of those actually changed rather than on every read — this is
/// what keeps a long list of already-cropped thumbnails from re-cropping
/// on every rebuild.
///
/// The cache key includes that fingerprint, rather than staying fixed
/// per [cacheKey], for the same reason the old ad hoc rendered-file name
/// did: `Image.file` resolves through Flutter's engine-level image
/// cache, keyed only by file path, so reusing one fixed path would leave
/// already-displayed widgets showing the old crop until the app
/// restarts.
Future<File?> renderClippedImage({
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

  final stat = await rawFile.stat();
  final fingerprint = sha1
      .convert(
        utf8.encode(
          jsonEncode({
            'rawFileModifiedMillis': stat.modified.millisecondsSinceEpoch,
            'rawFileSize': stat.size,
            'clippingSlot': clippingSlot.toJson(),
          }),
        ),
      )
      .toString()
      .substring(0, 16);
  final key = '$cacheKey-$fingerprint';

  final cached = await clippedImageCacheManager.getFileFromCache(key);
  if (cached != null) {
    return cached.file;
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

  return clippedImageCacheManager.putFile(
    key,
    img.encodePng(cropped),
    key: key,
    fileExtension: 'png',
  );
}
