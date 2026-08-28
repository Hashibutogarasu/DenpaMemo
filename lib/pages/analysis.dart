import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: OutlinedTitleText(text: context.t.page.analysis),
      body: const SizedBox.shrink(),
    );
  }
}
