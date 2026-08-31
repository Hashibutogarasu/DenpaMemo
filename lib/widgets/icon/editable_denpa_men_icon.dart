import 'dart:io';
import 'dart:ui' as ui;

import 'package:app_datas/app_datas.dart';
import 'package:croppy/croppy.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

import '../../providers/denpa_men_icon_providers.dart';
import 'denpa_men_icon.dart';

/// [DenpaMenIcon] that, when tapped, lets the user pick an image via
/// `file_picker`, crop it via `croppy`, and save the result as the
/// `DenpaMen`'s icon.
class EditableDenpaMenIcon extends ConsumerWidget {
  const EditableDenpaMenIcon({
    super.key,
    required this.denpaMenId,
    required this.size,
  });

  final String denpaMenId;
  final double size;

  Future<File> _writeUiImageToTempFile(ui.Image image) async {
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final packageInfo = await PackageInfo.fromPlatform();
    final tempDirectory = await AppPaths.tempAppDirectory(
      packageInfo.packageName,
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

  Future<void> _pickAndSetIcon(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }

    final cropResult = await showMaterialImageCropper(
      context,
      imageProvider: FileImage(File(pickedPath)),
      allowedAspectRatios: const [CropAspectRatio(width: 1, height: 1)],
    );
    if (cropResult == null) {
      return;
    }

    final croppedFile = await _writeUiImageToTempFile(cropResult.uiImage);
    try {
      await ref
          .read(denpaMenIconStorageProvider)
          .saveIcon(denpaMenId, croppedFile);
      ref.invalidate(denpaMenIconProvider(denpaMenId));
    } finally {
      if (await croppedFile.exists()) {
        await croppedFile.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _pickAndSetIcon(context, ref),
      child: DenpaMenIcon(denpaMenId: denpaMenId, size: size),
    );
  }
}
