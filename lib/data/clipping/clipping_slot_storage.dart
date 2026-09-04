import 'dart:convert';
import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';

/// Reads and writes each [DenpaMenImageSlotType]'s [ClippingSlot], stored
/// alongside the ObjectBox database directory (under the current
/// account's [accountScopedAppDirectoryProvider]) as one JSON file per
/// slot type under `<profileNamespace>/<profileId>/<slotType.name>.json`.
/// [profileId] is passed in explicitly by every method rather than
/// resolved internally: reactively watching which profile is current is
/// the caller's job (see `clippingSlotProvider` in
/// `clipping_slot_providers.dart`), so this class stays a plain,
/// synchronous-per-call file-I/O helper with nothing of its own to go
/// stale.
class ClippingSlotStorage {
  const ClippingSlotStorage(this._ref);

  final Ref _ref;

  static const String profileNamespace = 'clipping-slots';

  Future<File> _slotFile(
    String profileId,
    DenpaMenImageSlotType slotType,
  ) async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    return File(
      path.join(
        appDirectory.path,
        profileNamespace,
        profileId,
        '${slotType.name}.json',
      ),
    );
  }

  Future<ClippingSlot?> load(
    String profileId,
    DenpaMenImageSlotType slotType,
  ) async {
    final file = await _slotFile(profileId, slotType);
    if (!await file.exists()) {
      return null;
    }
    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return ClippingSlot.fromJson(json);
  }

  Future<void> save(String profileId, ClippingSlot slot) async {
    final file = await _slotFile(profileId, slot.slotType);
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(slot.toJson()));
  }

  Future<void> delete(String profileId, DenpaMenImageSlotType slotType) async {
    final file = await _slotFile(profileId, slotType);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Removes every [ClippingSlot] and the saved display/priority order
  /// for [profileId], so every slot type goes back to being
  /// unconfigured (see [DenpaMenImageSlotType.defaultPriority]).
  Future<void> reset(String profileId) async {
    await Future.wait(
      DenpaMenImageSlotType.values.map(
        (slotType) => delete(profileId, slotType),
      ),
    );
    final orderFile = await _orderFile(profileId);
    if (await orderFile.exists()) {
      await orderFile.delete();
    }
  }

  Future<File> _orderFile(String profileId) async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    return File(
      path.join(appDirectory.path, profileNamespace, profileId, 'order.json'),
    );
  }

  /// Persists the slot display/priority order shown on the clipping
  /// settings screen, independently of whether each slot type has a
  /// registered [ClippingSlot] yet — reordering must never invent crop
  /// data for a slot the user hasn't configured.
  Future<void> saveOrder(
    String profileId,
    List<DenpaMenImageSlotType> order,
  ) async {
    final file = await _orderFile(profileId);
    await file.parent.create(recursive: true);
    await file.writeAsString(
      jsonEncode([for (final slotType in order) slotType.name]),
    );
  }

  Future<List<DenpaMenImageSlotType>?> _loadOrder(String profileId) async {
    final file = await _orderFile(profileId);
    if (!await file.exists()) {
      return null;
    }
    final names = (jsonDecode(await file.readAsString()) as List<dynamic>)
        .cast<String>();
    final byName = {
      for (final slotType in DenpaMenImageSlotType.values)
        slotType.name: slotType,
    };
    final order = <DenpaMenImageSlotType>[
      for (final name in names) ?byName[name],
    ];
    for (final slotType in DenpaMenImageSlotType.values) {
      if (!order.contains(slotType)) {
        order.add(slotType);
      }
    }
    return order;
  }

  /// Returns every [DenpaMenImageSlotType] in priority order: the saved
  /// [saveOrder] result if there is one, otherwise ranked by ascending
  /// `ClippingSlot.priority` (falling back to
  /// [DenpaMenImageSlotType.defaultPriority] for types with no persisted
  /// [ClippingSlot] yet). Used both to display the clipping settings
  /// screen's slot list and to pick which slot's image should stand in
  /// as an individual's representative thumbnail without prompting the
  /// user for one.
  Future<List<DenpaMenImageSlotType>> loadSlotTypesByPriority(
    String profileId,
  ) async {
    final savedOrder = await _loadOrder(profileId);
    if (savedOrder != null) {
      return savedOrder;
    }
    final slots = await Future.wait(
      DenpaMenImageSlotType.values.map((slotType) => load(profileId, slotType)),
    );
    final priorities = <DenpaMenImageSlotType, int>{
      for (var i = 0; i < DenpaMenImageSlotType.values.length; i++)
        DenpaMenImageSlotType.values[i]:
            slots[i]?.priority ??
            DenpaMenImageSlotType.defaultPriority[DenpaMenImageSlotType
                .values[i]]!,
    };
    final types = List<DenpaMenImageSlotType>.from(
      DenpaMenImageSlotType.values,
    );
    types.sort((a, b) => priorities[a]!.compareTo(priorities[b]!));
    return types;
  }
}
