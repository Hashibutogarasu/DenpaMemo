import 'dart:io';

import 'package:croppy/croppy.dart';
import 'package:data_pack/data_pack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_slot_storage.dart';
import '../i18n/gen/strings.g.dart';
import '../routing/app_router.dart';
import 'profile_providers.dart';

final clippingSlotStorageProvider = Provider<ClippingSlotStorage>((ref) {
  return ClippingSlotStorage(ref);
});

/// Loads the persisted [ClippingSlot] for [slotType], or null if the user
/// hasn't registered one yet.
final clippingSlotProvider =
    FutureProvider.family<ClippingSlot?, DenpaMenImageSlotType>((
      ref,
      slotType,
    ) {
      return ref.watch(clippingSlotStorageProvider).load(slotType);
    });

/// Ordered by ascending `ClippingSlot.priority` (see
/// `ClippingSlotStorage.loadSlotTypesByPriority`). Watched by the
/// clipping settings screen to render slot tiles in priority order, and
/// by `denpaMenIconProvider` to pick a representative thumbnail.
final clippingSlotTypesByPriorityProvider =
    FutureProvider<List<DenpaMenImageSlotType>>((ref) {
      return ref.watch(clippingSlotStorageProvider).loadSlotTypesByPriority();
    });

/// The default display label for [slotType] until the user registers a
/// [ClippingSlot] with a name of their own (see `_ClippingSlotTile` on
/// the clipping settings page).
String defaultClippingSlotLabel(DenpaMenImageSlotType slotType) {
  switch (slotType) {
    case DenpaMenImageSlotType.face:
      return t.settings.clippingFace;
    case DenpaMenImageSlotType.wholeBody:
      return t.settings.clippingWholeBody;
    case DenpaMenImageSlotType.icon:
      return t.settings.clippingIcon;
  }
}

/// Drives the clipping settings screen's data operations — picking and
/// cropping an example image, persisting/deleting/reordering
/// [ClippingSlot]s, resetting them, and switching the current clipping
/// profile — so the page itself only builds UI and reacts to results.
class ClippingSettingsController {
  const ClippingSettingsController(this._ref);

  final Ref _ref;

  /// Picks an example image, crops it (applying [slotType]'s aspect
  /// ratio lock for `icon`), and saves the result as [slotType]'s
  /// [ClippingSlot], inheriting [existing]'s name/priority if it was
  /// already registered. Does nothing if the user cancels either step.
  Future<void> configureSlot(
    BuildContext context, {
    required DenpaMenImageSlotType slotType,
    required ClippingSlot? existing,
  }) async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null || !context.mounted) {
      return;
    }

    final cropResult = await showMaterialImageCropper(
      context,
      imageProvider: FileImage(File(pickedPath)),
      allowedAspectRatios: slotType == DenpaMenImageSlotType.icon
          ? const [CropAspectRatio(width: 1, height: 1)]
          : null,
    );
    if (cropResult == null) {
      return;
    }

    final data = cropResult.transformationsData;
    final rect = data.cropRect;
    final size = data.imageSize;

    final slot = createClippingSlot(
      slotType: slotType,
      name: existing?.name ?? defaultClippingSlotLabel(slotType),
      priority:
          existing?.priority ??
          DenpaMenImageSlotType.defaultPriority[slotType]!,
      left: rect.left / size.width,
      top: rect.top / size.height,
      right: rect.right / size.width,
      bottom: rect.bottom / size.height,
    );
    await _ref.read(clippingSlotStorageProvider).save(slot);
    _ref.invalidate(clippingSlotProvider(slotType));
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> deleteSlot(DenpaMenImageSlotType slotType) async {
    await _ref.read(clippingSlotStorageProvider).delete(slotType);
    _ref.invalidate(clippingSlotProvider(slotType));
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> saveOrder(List<DenpaMenImageSlotType> order) async {
    await _ref.read(clippingSlotStorageProvider).saveOrder(order);
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> reset() async {
    await _ref.read(clippingSlotStorageProvider).reset();
    for (final slotType in DenpaMenImageSlotType.values) {
      _ref.invalidate(clippingSlotProvider(slotType));
    }
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  /// Pushes the generic profile switcher for
  /// [ClippingSlotStorage.profileNamespace], then refreshes every
  /// provider whose value depends on the current clipping profile.
  Future<void> switchProfile(BuildContext context) async {
    await const ProfileSwitchRoute(
      namespace: ClippingSlotStorage.profileNamespace,
    ).push<bool>(context);
    _ref.invalidate(
      currentProfileProvider(ClippingSlotStorage.profileNamespace),
    );
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
    for (final slotType in DenpaMenImageSlotType.values) {
      _ref.invalidate(clippingSlotProvider(slotType));
    }
  }
}

final clippingSettingsControllerProvider = Provider<ClippingSettingsController>(
  (ref) => ClippingSettingsController(ref),
);
