import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_render.dart';
import '../data/icon/entity_icon_storage.dart';
import 'clipping_slot_providers.dart';

/// [slot]'s own raw image (see [EntityIconStorage]), or — if [entityId]
/// never had one saved for [slot] specifically — whichever other
/// [DenpaMenImageSlotType] raw image it does have, so every slot always
/// has some source to crop once at least one photo has been picked.
Future<File?> _rawImageForSlot(
  EntityIconStorage storage,
  String entityId,
  DenpaMenImageSlotType slot,
) async {
  final ownFile = await storage.loadIcon(entityId, slot: slot.name);
  if (ownFile != null) {
    return ownFile;
  }
  for (final fallbackSlot in DenpaMenImageSlotType.values) {
    if (fallbackSlot == slot) {
      continue;
    }
    final file = await storage.loadIcon(entityId, slot: fallbackSlot.name);
    if (file != null) {
      return file;
    }
  }
  return null;
}

/// Resolves [slot]'s raw image for [category]/[entityId] (see
/// [_rawImageForSlot]) and applies whichever [ClippingSlot]
/// [clippingProfileId] has registered for [slot], in-memory — or null if
/// [entityId] has no image saved for any slot yet, and unmodified if
/// [clippingProfileId] is null (no profile assigned). Watches both the
/// raw image and [clippingSlotForProfileProvider], so re-registering a
/// slot's crop rectangle is reflected immediately for every
/// already-picked image, without re-picking or re-saving anything.
final entityImageProvider =
    FutureProvider.family<
      File?,
      (
        String category,
        String entityId,
        DenpaMenImageSlotType slot,
        String? clippingProfileId,
      )
    >((ref, args) async {
      final (category, entityId, slot, clippingProfileId) = args;
      final rawFile = await _rawImageForSlot(
        EntityIconStorage(category, ref),
        entityId,
        slot,
      );
      final clippingSlot = await ref.watch(
        clippingSlotForProfileProvider((clippingProfileId, slot)).future,
      );
      return renderClippedImage(
        ref,
        rawFile: rawFile,
        clippingSlot: clippingSlot,
        cacheKey: '$category-$entityId-${slot.name}',
      );
    });
