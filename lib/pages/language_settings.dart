import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, LocaleSettings;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/language_providers.dart';

/// Lists every locale the app is translated into ([availableLocalesProvider]),
/// with its display name looked up via `t.languages`. Switching locales has
/// no effect yet beyond marking the selection, since only one is bundled
/// today.
class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final locales = ref.watch(availableLocalesProvider);
    final currentLocale = LocaleSettings.currentLocale;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.languageSettings),
      body: ListView(
        children: [
          for (final locale in locales)
            ListTile(
              title: Text(t.languages[locale.languageCode] ?? locale.languageCode),
              trailing: locale == currentLocale ? const Icon(Icons.check) : null,
              onTap: () => LocaleSettings.setLocale(locale),
            ),
        ],
      ),
    );
  }
}
