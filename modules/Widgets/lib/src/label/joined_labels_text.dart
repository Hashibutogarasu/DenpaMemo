import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Shows [labels] joined by "、", or [Translations.common.unset] if empty.
/// Used by selection fields (parents, corrections, ...) that summarize a
/// list of chosen items as a single line of text.
class JoinedLabelsText extends StatelessWidget {
  const JoinedLabelsText({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Text(
      labels.isEmpty ? t.common.unset : labels.join('、'),
      overflow: TextOverflow.ellipsis,
    );
  }
}
