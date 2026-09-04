import 'dart:io';
import 'dart:ui' as ui;

import 'package:croppy/croppy.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';
import '../../providers/clipping_slot_providers.dart';
import '../../providers/denpa_men_icon_providers.dart';

/// A single [DenpaMenImageSlotType]'s icon (`face`/`wholeBody`/`icon`)
/// that, when tapped, lets the user pick an image via `file_picker` and
/// save it as that slot's image. If a [ClippingSlot] is already
/// registered for [slot] (see the clipping settings screen), its stored
/// relative crop rectangle is applied automatically and the interactive
/// cropper is skipped entirely; otherwise `croppy`'s cropper opens as
/// before.
class EditableDenpaMenIcon extends ConsumerWidget {
  const EditableDenpaMenIcon({
    super.key,
    required this.denpaMenId,
    required this.slot,
    required this.size,
  });

  final String denpaMenId;
  final DenpaMenImageSlotType slot;
  final double size;

  Future<File> _writeUiImageToTempFile(ui.Image image, WidgetRef ref) async {
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final tempDirectory = await ref.read(
      accountScopedTempDirectoryProvider.future,
    );
    final file = File(
      path.join(
        tempDirectory.path,
        '${DateTime.now().microsecondsSinceEpoch}.png',
      ),
    );
    await file.writeAsBytes(bytes!.buffer.asUint8List());
    return file;
  }

  Future<File> _applyStoredCrop(
    File pickedFile,
    ClippingSlot clippingSlot,
    WidgetRef ref,
  ) async {
    final source = img.decodeImage(await pickedFile.readAsBytes())!;
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
    final file = File(
      path.join(
        tempDirectory.path,
        '${DateTime.now().microsecondsSinceEpoch}.png',
      ),
    );
    await file.writeAsBytes(img.encodePng(cropped));
    return file;
  }

  Future<void> _pickAndSetIcon(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }

    final clippingSlot = await ref.read(clippingSlotProvider(slot).future);

    File? croppedFile;
    if (clippingSlot != null) {
      croppedFile = await _applyStoredCrop(File(pickedPath), clippingSlot, ref);
    } else {
      if (!context.mounted) {
        return;
      }
      final cropResult = await showMaterialImageCropper(
        context,
        imageProvider: FileImage(File(pickedPath)),
        allowedAspectRatios: slot == DenpaMenImageSlotType.icon
            ? const [CropAspectRatio(width: 1, height: 1)]
            : null,
      );
      if (cropResult == null) {
        return;
      }
      croppedFile = await _writeUiImageToTempFile(cropResult.uiImage, ref);
    }

    try {
      await ref
          .read(denpaMenIconStorageProvider)
          .saveIcon(denpaMenId, croppedFile, slot: slot.name);
      if (slot == DenpaMenImageSlotType.icon) {
        ref.invalidate(denpaMenIconProvider(denpaMenId));
      } else {
        ref.invalidate(denpaMenImageProvider((denpaMenId, slot)));
      }
    } finally {
      if (await croppedFile.exists()) {
        await croppedFile.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = slot == DenpaMenImageSlotType.icon
        ? ref.watch(denpaMenIconProvider(denpaMenId)).value
        : ref.watch(denpaMenImageProvider((denpaMenId, slot))).value;
    return GestureDetector(
      onTap: () => _pickAndSetIcon(context, ref),
      child: ResolvedEntityIcon(file: file, size: size),
    );
  }
}
