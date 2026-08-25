import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_providers.dart';
import '../../widgetbook/denpa_men/denpa_men_data.dart';
import '../add_denpa_men_fab.dart';
import 'denpa_men_home_screen.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenHomeScreen, path: 'home')
Widget denpaMenHomeScreenUseCase(BuildContext context) {
  final selectionMode = context.knobs.boolean(
    label: '選択モード（SelectionFloatingMenu表示）',
    initialValue: false,
  );

  return ProviderScope(
    overrides: [selectionModeProvider.overrideWith((ref) => selectionMode)],
    child: DenpaMenHomeScreen(
      title: Text(context.t.app.name),
      masterData: DenpaMenData.masterData,
      floatingActionButton: AddDenpaMenFab(masterData: DenpaMenData.masterData),
    ),
  );
}
