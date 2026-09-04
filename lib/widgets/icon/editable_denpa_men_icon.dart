import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/clipping/clipping_slot_storage.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/entity_image_providers.dart';
import '../../providers/profile_providers.dart';
import '../profile/profile_selection_dialog.dart';

/// A single [DenpaMenImageSlotType]'s icon (`face`/`wholeBody`/`icon`)
/// that, when tapped, lets the user pick an image via `file_picker`,
/// then asks which clipping profile to view/crop it through (see
/// [ProfileSelectionDialog]) before saving it — unmodified — as that
/// slot's raw source image. What's actually shown here is
/// [entityImageProvider]'s in-memory-cropped rendering of that raw
/// image, using whichever `ClippingSlot` is currently registered for
/// [slot]; since that provider reacts to both the raw image and the
/// current clipping profile, registering or changing a crop template —
/// or switching profiles — is reflected immediately, for every
/// individual, without re-picking anything.
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
          .read(profileControllerProvider(ClippingSlotStorage.profileNamespace))
          .select(profile);
    }

    await ref
        .read(denpaMenIconStorageProvider)
        .saveIcon(denpaMenId, File(pickedPath), slot: slot.name);
    ref.invalidate(
      entityImageProvider((denpaMenIconCategory, denpaMenId, slot)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref
        .watch(entityImageProvider((denpaMenIconCategory, denpaMenId, slot)))
        .value;
    return GestureDetector(
      onTap: () => _pickAndSetIcon(context, ref),
      child: ResolvedEntityIcon(file: file, size: size),
    );
  }
}
