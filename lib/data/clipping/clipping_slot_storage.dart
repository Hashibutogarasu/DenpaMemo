import 'dart:convert';
import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import '../../providers/account_scoped_paths_providers.dart';
import '../../providers/profile_providers.dart';

/// Reads and writes each [DenpaMenImageSlotType]'s [ClippingSlot], stored
/// alongside the ObjectBox database directory (under the current
/// account's [accountScopedAppDirectoryProvider]) as one JSON file per
/// slot type under `<profileNamespace>/<profileId>/<slotType.name>.json`.
/// Scoped per [Profile](../profile/profile.dart) — via [profileNamespace]
/// and `currentProfileProvider` — so switching profiles (see
/// `ProfileSwitchPage`) switches out the whole set of registered crops.
class ClippingSlotStorage {
  const ClippingSlotStorage(this._ref);

  final Ref _ref;

  static const String profileNamespace = 'clipping-slots';

  Future<String> _currentProfileId() async {
    final profile = await _ref.read(
      currentProfileProvider(profileNamespace).future,
    );
    return profile.id;
  }

  Future<File> _slotFile(DenpaMenImageSlotType slotType) async {
    final appDirectory = await _ref.read(
      accountScopedAppDirectoryProvider.future,
    );
    final profileId = await _currentProfileId();
    return File(
      path.join(
        appDirectory.path,
        profileNamespace,
        profileId,
        '${slotType.name}.json',
      ),
    );
  }

  Future<ClippingSlot?> load(DenpaMenImageSlotType slotType) async {
    final file = await _slotFile(slotType);
    if (!await file.exists()) {
      return null;
    }
    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return ClippingSlot.fromJson(json);
  }

  Future<void> save(ClippingSlot slot) async {
    final file = await _slotFile(slot.slotType);
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(slot.toJson()));
  }

  Future<void> delete(DenpaMenImageSlotType slotType) async {
    final file = await _slotFile(slotType);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Returns every [DenpaMenImageSlotType], ordered by ascending
  /// `ClippingSlot.priority` (falling back to [DenpaMenImageSlotType.defaultPriority] for
  /// types with no persisted [ClippingSlot] yet). Used to pick which
  /// slot's image should stand in as an individual's representative
  /// thumbnail without prompting the user for one.
  Future<List<DenpaMenImageSlotType>> loadSlotTypesByPriority() async {
    final slots = await Future.wait(DenpaMenImageSlotType.values.map(load));
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
