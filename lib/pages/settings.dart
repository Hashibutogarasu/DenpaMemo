import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';
import '../widgets/header/slanted_app_bar.dart';
import '../widgets/label/outlined_title.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SlantedAppBar(
        title: OutlinedTitleText(text: context.t.page.settings),
      ),
      body: const SizedBox.shrink(),
    );
  }
}
