import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/clipping/clipping_slot_storage.dart';
import 'package:denpa_memo/providers/account_scoped_paths_providers.dart';
import 'package:denpa_memo/providers/clipping_slot_providers.dart';
import 'package:denpa_memo/providers/profile_providers.dart';

void main() {
  late Directory tempRoot;
  late ProviderContainer container;

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp(
      'clipping_slot_profile_reactivity_test',
    );
    container = ProviderContainer(
      overrides: [
        accountScopedAppDirectoryProvider.overrideWith((ref) async => tempRoot),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    if (await tempRoot.exists()) {
      await tempRoot.delete(recursive: true);
    }
  });

  test(
    'clippingSlotProvider reflects a profile switch made without going '
    'through ClippingSettingsController.switchProfile\'s manual invalidation',
    () async {
      final profileStorage = container.read(
        profileStorageProvider(ClippingSlotStorage.profileNamespace),
      );
      final clippingStorage = container.read(clippingSlotStorageProvider);

      final profileA = await profileStorage.create('profile-a');
      await profileStorage.saveCurrentId(profileA.id);

      await clippingStorage.save(
        profileA.id,
        createClippingSlot(
          slotType: DenpaMenImageSlotType.icon,
          name: 'A icon',
          priority: 0,
          left: 0.1,
          top: 0.1,
          right: 0.9,
          bottom: 0.9,
        ),
      );

      final slotForA = await container.read(
        clippingSlotProvider(DenpaMenImageSlotType.icon).future,
      );
      expect(slotForA?.name, 'A icon');

      final profileB = await profileStorage.create('profile-b');
      await container
          .read(profileControllerProvider(ClippingSlotStorage.profileNamespace))
          .select(profileB);

      final slotForB = await container.read(
        clippingSlotProvider(DenpaMenImageSlotType.icon).future,
      );
      expect(
        slotForB,
        isNull,
        reason:
            'profile B has no icon ClippingSlot registered, so this must '
            'be null — if it still equals "A icon", clippingSlotProvider '
            'is not reacting to the profile switch and is serving stale '
            'cached data from profile A',
      );
    },
  );
}
