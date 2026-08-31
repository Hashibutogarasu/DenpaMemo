import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/app_settings_providers.dart';

/// Lets the user pick [AppThemeMode], persisted app-wide (not per account).
class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  void _select(WidgetRef ref, AppThemeMode themeMode) {
    final settings = ref.read(appSettingsProvider);
    ref
        .read(appSettingsRepositoryProvider)
        .save(settings.copyWith(themeMode: themeMode));
    ref.invalidate(appSettingsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final current = ref.watch(appSettingsProvider).themeMode;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.themeSettings),
      body: RadioGroup<AppThemeMode>(
        groupValue: current,
        onChanged: (value) => _select(ref, value!),
        child: ListView(
          children: [
            RadioListTile<AppThemeMode>(
              title: Text(t.settings.themeSystem),
              value: AppThemeMode.system,
            ),
            RadioListTile<AppThemeMode>(
              title: Text(t.settings.themeLight),
              value: AppThemeMode.light,
            ),
            RadioListTile<AppThemeMode>(
              title: Text(t.settings.themeDark),
              value: AppThemeMode.dark,
            ),
          ],
        ),
      ),
    );
  }
}
