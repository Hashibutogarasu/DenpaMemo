import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: OutlinedTitleText(text: context.t.page.settings),
      body: const SizedBox.shrink(),
    );
  }
}
