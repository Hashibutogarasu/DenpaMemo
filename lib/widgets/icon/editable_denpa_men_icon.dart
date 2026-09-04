import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/clipping/clipping_slot_storage.dart';
import '../../providers/clipping_slot_providers.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/entity_image_providers.dart';
import '../profile/profile_selection_dialog.dart';

/// A single [DenpaMenImageSlotType]'s icon (`face`/`wholeBody`/`icon`)
/// that, when tapped, lets the user pick an image via `file_picker` and
/// saves it — unmodified — as that slot's raw source image. What's
/// shown here is [entityImageProvider]'s in-memory-cropped rendering of
/// that raw image, using [denpaMenId]'s own assigned clipping profile
/// (see [denpaMenClippingProfileIdProvider]) — null means unassigned,
/// so the raw image renders as-is. Assigning/reassigning a profile only
/// ever affects this one individual, never any other.
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

  Future<void> _pickAndSetIcon(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null || !context.mounted) {
      return;
    }

    final profile = await ProfileSelectionDialog.show(
      context,
      namespace: ClippingSlotStorage.profileNamespace,
    );
    if (profile != null) {
      await ref
          .read(denpaMenClippingProfileStorageProvider)
          .save(denpaMenId, profile.id);
      ref.invalidate(denpaMenClippingProfileIdProvider(denpaMenId));
    }

    await ref
        .read(denpaMenIconStorageProvider)
        .saveIcon(denpaMenId, File(pickedPath), slot: slot.name);
    ref.invalidate(
      entityImageProvider((
        denpaMenIconCategory,
        denpaMenId,
        slot,
        ref.read(denpaMenClippingProfileIdProvider(denpaMenId)).value,
      )),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileId = ref
        .watch(denpaMenClippingProfileIdProvider(denpaMenId))
        .value;
    final file = ref
        .watch(
          entityImageProvider((
            denpaMenIconCategory,
            denpaMenId,
            slot,
            profileId,
          )),
        )
        .value;
    return GestureDetector(
      onTap: () => _pickAndSetIcon(context, ref),
      child: ResolvedEntityIcon(file: file, size: size),
    );
  }
}
