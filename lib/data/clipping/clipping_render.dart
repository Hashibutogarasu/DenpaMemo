import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';

/// Applies [clippingSlot]'s relative crop rectangle to [rawFile]
/// in-memory and writes the result to a fresh temp file, or returns
/// [rawFile] unmodified if [clippingSlot] is null. Entirely
/// entity-agnostic: works the same for any raw image a caller has
/// saved, given whichever [ClippingSlot] currently applies to it —
/// callers only need to make sure their own provider watches both the
/// raw image and the [ClippingSlot] so switching clipping profiles or
/// re-registering a crop takes effect immediately. [cacheKey] should
/// uniquely identify the raw image/slot pair, to keep temp file names
/// from colliding across different callers.
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
  final renderedFile = File(
    path.join(
      tempDirectory.path,
      '$cacheKey-${DateTime.now().microsecondsSinceEpoch}.png',
    ),
  );
  await renderedFile.writeAsBytes(img.encodePng(cropped));
  return renderedFile;
}
