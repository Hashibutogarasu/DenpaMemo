import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_slot_storage.dart';

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
