import 'package:flutter/material.dart';
import 'package:flutter_date_formatter/flutter_date_formatter.dart';

import '../../i18n/gen/strings.g.dart';

/// Renders [dateTime] per [pattern] in the app's current language
/// ([TranslationProvider]'s locale), rebuilding whenever that changes.
class FormattedDateText extends StatelessWidget {
  const FormattedDateText({super.key, required this.dateTime, required this.pattern, this.style});

  final DateTime dateTime;
  final String pattern;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final locale = TranslationProvider.of(context).locale.languageCode;
    return Text(dateTime.format(pattern: pattern, locale: locale), style: style);
  }
}
