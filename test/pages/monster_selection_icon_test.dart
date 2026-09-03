import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/pages/monster_selection.dart';
import 'package:denpa_memo/providers/monster_providers.dart';
import 'package:denpa_memo/providers/objectbox_providers.dart';
import 'package:denpa_memo/theme/app_theme.dart';

import '../support/fake_path_provider_platform.dart';

void main() {
  testWidgets('a monster whose translateKey matches a bundled '
      'assets/data/icons/monster/<translateKey>.png shows that icon in the '
      'selection list', (WidgetTester tester) async {
    late Directory tempRoot;
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);

    await tester.runAsync(() async {
      tempRoot = await Directory.systemTemp.createTemp(
        'monster_selection_icon_test',
      );
      PathProviderPlatform.instance = FakePathProviderPlatform(tempRoot.path);
    });
    addTearDown(() async {
      if (await tempRoot.exists()) {
        await tempRoot.delete(recursive: true);
      }
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          objectBoxProvider.overrideWithValue(objectBox),
          monsterListProvider.overrideWith(
            (ref) async => const [Monster(id: 'swordmouse')],
          ),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            theme: AppLightTheme.theme,
            home: MonsterSelectionPage(),
          ),
        ),
      ),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MonsterSelectionPage)),
    );
    await tester.runAsync(
      () => container.read(monsterIconProvider('swordmouse').future),
    );
    await tester.pump();

    final imageFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is FileImage &&
          (widget.image as FileImage).file.path.contains(
            '${Platform.pathSeparator}monsters${Platform.pathSeparator}swordmouse${Platform.pathSeparator}',
          ),
    );
    expect(imageFinder, findsOneWidget);
    expect(find.byIcon(Icons.image_outlined), findsNothing);
  });
}
