import 'package:flutter/material.dart';

import 'package:denpa_memo/widgets.dart';
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
