import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';

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
