import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../providers/denpa_men_icon_providers.dart';
import 'denpa_men_icon.dart';

/// [DenpaMenIcon] that, when tapped, lets the user pick an image via
/// `file_picker`, crop it via `image_cropper`, and save the result as the
/// `DenpaMen`'s icon.
class EditableDenpaMenIcon extends ConsumerWidget {
  const EditableDenpaMenIcon({
    super.key,
    required this.denpaMenId,
    required this.size,
  });

  final String denpaMenId;
  final double size;

  Future<void> _pickAndSetIcon(WidgetRef ref) async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null) {
      return;
    }

    final cropped = await ImageCropper().cropImage(
      sourcePath: pickedPath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (cropped == null) {
      return;
    }

    await ref
        .read(denpaMenIconStorageProvider)
        .saveIcon(denpaMenId, File(cropped.path));
    ref.invalidate(denpaMenIconProvider(denpaMenId));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _pickAndSetIcon(ref),
      child: DenpaMenIcon(denpaMenId: denpaMenId, size: size),
    );
  }
}
