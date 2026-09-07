import 'dart:io';

import 'package:flutter/material.dart';

import 'package:croppy/croppy.dart';
import 'package:data_pack/data_pack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_slot_storage.dart';
import '../data/clipping/denpa_men_clipping_profile_storage.dart';
import '../i18n/gen/strings.g.dart';
import '../routing/app_router.dart';
import 'profile_providers.dart';

final clippingSlotStorageProvider = Provider<ClippingSlotStorage>((ref) {
  return ClippingSlotStorage(ref);
});

final denpaMenClippingProfileStorageProvider =
    Provider<DenpaMenClippingProfileStorage>((ref) {
      return DenpaMenClippingProfileStorage(ref);
    });

/// The clipping profile id [denpaMenId] is assigned to, or null if
/// unassigned. Rendering must skip cropping for a null result rather
/// than fall back to any app-wide "current" profile.
final denpaMenClippingProfileIdProvider =
    FutureProvider.family<String?, String>((ref, denpaMenId) {
      return ref.watch(denpaMenClippingProfileStorageProvider).load(denpaMenId);
    });

/// [DenpaMenImageSlotType.values] ranked by
/// [DenpaMenImageSlotType.defaultPriority].
List<DenpaMenImageSlotType> _defaultSlotTypeOrder() {
  final types = List<DenpaMenImageSlotType>.from(DenpaMenImageSlotType.values);
  types.sort(
    (a, b) => DenpaMenImageSlotType.defaultPriority[a]!.compareTo(
      DenpaMenImageSlotType.defaultPriority[b]!,
    ),
  );
  return types;
}

/// Loads the [ClippingSlot] for [slotType] under [profileId], or null if
/// either [profileId] is null (no profile assigned) or nothing is
/// registered for [slotType] under it. Used by [entityImageProvider] to
/// render an individual's own assigned profile, as opposed to
/// [clippingSlotProvider] below, which the clipping settings screen uses
/// to edit whichever profile is currently open there.
final clippingSlotForProfileProvider =
    FutureProvider.family<ClippingSlot?, (String?, DenpaMenImageSlotType)>((
      ref,
      args,
    ) async {
      final (profileId, slotType) = args;
      if (profileId == null) {
        return null;
      }
      return ref.watch(clippingSlotStorageProvider).load(profileId, slotType);
    });

/// Loads the persisted [ClippingSlot] for [slotType] under the current
/// clipping profile, or null if unregistered. Reactively resolves the
/// current profile itself, so switching profiles always recomputes this.
final clippingSlotProvider =
    FutureProvider.family<ClippingSlot?, DenpaMenImageSlotType>((
      ref,
      slotType,
    ) async {
      final profile = await ref.watch(
        currentProfileProvider(ClippingSlotStorage.profileNamespace).future,
      );
      return ref.watch(clippingSlotStorageProvider).load(profile.id, slotType);
    });

/// Ordered by ascending `ClippingSlot.priority` under [profileId], or
/// [_defaultSlotTypeOrder] if [profileId] is null.
final slotTypesByPriorityForProfileProvider =
    FutureProvider.family<List<DenpaMenImageSlotType>, String?>((
      ref,
      profileId,
    ) async {
      if (profileId == null) {
        return _defaultSlotTypeOrder();
      }
      return ref
          .watch(clippingSlotStorageProvider)
          .loadSlotTypesByPriority(profileId);
    });

/// Ordered by ascending `ClippingSlot.priority` under the current
/// clipping profile. Watched by the clipping settings screen to render
/// slot tiles in priority order.
final clippingSlotTypesByPriorityProvider =
    FutureProvider<List<DenpaMenImageSlotType>>((ref) async {
      final profile = await ref.watch(
        currentProfileProvider(ClippingSlotStorage.profileNamespace).future,
      );
      return ref
          .watch(clippingSlotStorageProvider)
          .loadSlotTypesByPriority(profile.id);
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

/// Drives the clipping settings screen's data operations — picking an
/// example image and registering the crop rectangle drawn on it,
/// deleting/reordering [ClippingSlot]s, resetting them, and switching
/// the current clipping profile — so the page itself only builds UI and
/// reacts to results.
class ClippingSettingsController {
  const ClippingSettingsController(this._ref);

  final Ref _ref;

  Future<String> _currentProfileId() async {
    final profile = await _ref.read(
      currentProfileProvider(ClippingSlotStorage.profileNamespace).future,
    );
    return profile.id;
  }

  /// Picks an example image and, once the user draws a crop rectangle on
  /// it, registers that rectangle (as a relative fraction of the example
  /// image's size) as [slotType]'s [ClippingSlot], inheriting
  /// [existing]'s name/priority if it was already registered. Does
  /// nothing if the user cancels either step.
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
    final profileId = await _currentProfileId();
    await _ref.read(clippingSlotStorageProvider).save(profileId, slot);
    _ref.invalidate(clippingSlotProvider(slotType));
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> deleteSlot(DenpaMenImageSlotType slotType) async {
    final profileId = await _currentProfileId();
    await _ref.read(clippingSlotStorageProvider).delete(profileId, slotType);
    _ref.invalidate(clippingSlotProvider(slotType));
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> saveOrder(List<DenpaMenImageSlotType> order) async {
    final profileId = await _currentProfileId();
    await _ref.read(clippingSlotStorageProvider).saveOrder(profileId, order);
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> reset() async {
    final profileId = await _currentProfileId();
    await _ref.read(clippingSlotStorageProvider).reset(profileId);
    for (final slotType in DenpaMenImageSlotType.values) {
      _ref.invalidate(clippingSlotProvider(slotType));
    }
    _ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  /// Pushes the generic profile switcher for
  /// [ClippingSlotStorage.profileNamespace], for editing which profile's
  /// crop templates the settings screen currently shows.
  Future<void> switchProfile(BuildContext context) async {
    await const ProfileSwitchRoute(
      namespace: ClippingSlotStorage.profileNamespace,
    ).push<bool>(context);
    _ref.invalidate(
      currentProfileProvider(ClippingSlotStorage.profileNamespace),
    );
  }
}

final clippingSettingsControllerProvider = Provider<ClippingSettingsController>(
  (ref) => ClippingSettingsController(ref),
);
