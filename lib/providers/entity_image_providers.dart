import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_render.dart';
import '../data/icon/entity_icon_storage.dart';
import 'clipping_slot_providers.dart';

/// Reads the raw image saved for [category]/[entityId]/[slot] (see
/// [EntityIconStorage]) and applies whichever [ClippingSlot] the current
/// clipping profile has registered for [slot], in-memory — or null if
/// that slot has no image saved yet. Watches both the raw image and
/// [clippingSlotProvider], so switching clipping profiles or
/// re-registering a slot's crop rectangle is reflected immediately for
/// every already-picked image, without re-picking or re-saving anything.
/// Entity-agnostic: the same provider backs every category
/// [EntityIconStorage] knows about, not just one.
final entityImageProvider =
    FutureProvider.family<
      File?,
      (String category, String entityId, DenpaMenImageSlotType slot)
    >((ref, args) async {
      final (category, entityId, slot) = args;
      final rawFile = await EntityIconStorage(
        category,
        ref,
      ).loadIcon(entityId, slot: slot.name);
      final clippingSlot = await ref.watch(clippingSlotProvider(slot).future);
      return renderClippedImage(
        ref,
        rawFile: rawFile,
        clippingSlot: clippingSlot,
        cacheKey: '$category-$entityId-${slot.name}',
      );
    });
