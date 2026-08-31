import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';

/// Only Japanese is bundled today, so this shows it as the single, already
/// selected option rather than offering a real switch.
class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.languageSettings),
      body: ListView(
        children: [
          ListTile(
            title: Text(t.settings.languageJapanese),
            trailing: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
