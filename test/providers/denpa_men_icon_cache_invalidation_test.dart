import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/providers/account_scoped_paths_providers.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';

final _refProvider = Provider<Ref>((ref) => ref);

void main() {
  late Directory tempRoot;
  late ProviderContainer container;

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp(
      'denpa_men_icon_cache_invalidation_test',
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

  test('denpaMenIconProvider reflects an icon saved after being read as null '
      'beforehand (mirrors the .dm import duplicate-resolution flow: a '
      'preview read before the icon exists, followed by the save), when '
      'only the outer provider is invalidated', () async {
    const denpaMenId = 'individual-a';

    final before = await container.read(
      denpaMenIconProvider(denpaMenId).future,
    );
    expect(
      before,
      isNull,
      reason:
          'no icon has been saved yet, mirroring resolveDuplicates\' '
          'preview read before the merge happens',
    );

    final storage = container.read(denpaMenIconStorageProvider);
    final iconFile = File('${tempRoot.path}/source_icon.png');
    await iconFile.writeAsBytes([1, 2, 3, 4]);
    await storage.saveIcon(denpaMenId, iconFile, slot: 'icon');

    await invalidateDenpaMenIconCache(container.read(_refProvider), denpaMenId);

    final after = await container.read(denpaMenIconProvider(denpaMenId).future);
    expect(
      after,
      isNotNull,
      reason:
          'the icon was just saved to disk, so this must resolve to '
          'it — if this is still null, denpaMenIconProvider is serving '
          'a stale entityImageProvider result cached by the earlier '
          'preview read',
    );
  });
}
