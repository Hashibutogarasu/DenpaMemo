import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/icon/entity_icon_storage.dart';
import 'clipping_slot_providers.dart';
import 'entity_image_providers.dart';

const denpaMenIconCategory = 'denpamens';

final denpaMenIconStorageProvider = Provider<EntityIconStorage>((ref) {
  return EntityIconStorage(denpaMenIconCategory, ref);
});

/// Resolves the `DenpaMen` with the given id's representative thumbnail:
/// among `face`/`wholeBody`/`icon`, the highest-priority slot (see
/// `ClippingSlot.priority`/`DenpaMenImageSlotType.defaultPriority`) that
/// actually has an image saved (see [entityImageProvider]), or null if
/// none do. Callers don't need to know which slot this ends up being —
/// the priority ordering decides automatically.
final denpaMenIconProvider = FutureProvider.family<File?, String>((
  ref,
  denpaMenId,
) async {
  final profileId = await ref.watch(
    denpaMenClippingProfileIdProvider(denpaMenId).future,
  );
  final orderedTypes = await ref.watch(
    slotTypesByPriorityForProfileProvider(profileId).future,
  );
  for (final type in orderedTypes) {
    final file = await ref.watch(
      entityImageProvider((
        denpaMenIconCategory,
        denpaMenId,
        type,
        profileId,
      )).future,
    );
    if (file != null) {
      return file;
    }
  }
  return null;
});

/// Invalidates [denpaMenIconProvider] and, for every [DenpaMenImageSlotType],
/// the [entityImageProvider] instances it watches — invalidating only the
/// outer provider leaves those stale (e.g. cached `null` from an earlier
/// preview read), since `ref.watch` doesn't recompute what it's watching.
Future<void> invalidateDenpaMenIconCache(Ref ref, String denpaMenId) async {
  final profileId = await ref.read(
    denpaMenClippingProfileIdProvider(denpaMenId).future,
  );
  for (final type in DenpaMenImageSlotType.values) {
    ref.invalidate(
      entityImageProvider((denpaMenIconCategory, denpaMenId, type, profileId)),
    );
  }
  ref.invalidate(denpaMenIconProvider(denpaMenId));
}

/// Resolves every id in [denpaMenIds] to its icon file via [loadIcon], for
/// callers (e.g. `ExportCompleteDialog.show`, `ImportCompleteDialog.show`,
/// `resolveDuplicates` callbacks) that need a `Map<String, File?>` up
/// front rather than resolving each icon reactively. [loadIcon] is a
/// plain callback rather than a `Ref`/`WidgetRef` parameter, since callers
/// reach this from both widget code (`WidgetRef`) and plain controllers
/// (`Ref`) — pass `(id) => ref.read(denpaMenIconProvider(id).future)` from
/// either.
Future<Map<String, File?>> resolveDenpaMenIcons(
  Future<File?> Function(String id) loadIcon,
  Iterable<String> denpaMenIds,
) async {
  final ids = denpaMenIds.toSet();
  final files = await Future.wait(ids.map(loadIcon));
  return Map.fromIterables(ids, files);
}

/// Builds the `loadIcons` callback `DMFile.writeExport`/`readImport`
/// expect: every [DenpaMenImageSlotType] this individual has a raw
/// (uncropped) image for, keyed by `DenpaMenImageSlotType.name`. Backups
/// intentionally carry the raw source rather than a cropped rendering,
/// so restoring one still re-applies whatever `ClippingSlot`s exist on
/// the restoring device. DMFile itself never imports
/// [DenpaMenImageSlotType] — this is where the app layer, which does
/// know the slot types, adapts [EntityIconStorage] to DMFile's
/// opaque-slot-key shape.
Future<Map<String, File>> loadAllDenpaMenImageSlots(
  EntityIconStorage storage,
  String denpaMenId,
) async {
  final result = <String, File>{};
  for (final type in DenpaMenImageSlotType.values) {
    final file = await storage.loadIcon(denpaMenId, slot: type.name);
    if (file != null) {
      result[type.name] = file;
    }
  }
  return result;
}

/// Builds the `saveIcons` callback `DMFile.readImport` expects: writes
/// every entry of [icons] (an opaque slot key from DMFile) to
/// [EntityIconStorage] directly as its `slot` argument.
Future<void> saveAllDenpaMenImageSlots(
  EntityIconStorage storage,
  String denpaMenId,
  Map<String, File> icons,
) async {
  for (final entry in icons.entries) {
    await storage.saveIcon(denpaMenId, entry.value, slot: entry.key);
  }
}
