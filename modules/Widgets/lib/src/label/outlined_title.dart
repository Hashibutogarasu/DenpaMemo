import 'package:flutter/material.dart';

import '../theme/denpa_men_label_theme.dart';

/// Renders [text] twice — once stroked in [outlineColor] behind a solid
/// [fillColor] pass — so the title reads as an outlined header title.
class OutlinedTitleText extends StatelessWidget {
  const OutlinedTitleText({
    super.key,
    required this.text,
    this.fillColor = Colors.white,
    this.outlineColor,
    this.fontSize = 26,
    this.outlineWidth = 3,
  });

  final String text;
  final Color fillColor;
  final Color? outlineColor;
  final double fontSize;
  final double outlineWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenLabelThemeData>()!;
    final baseStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    return Stack(
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: baseStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor ?? theme.headerTitleOutlineColor,
          ),
        ),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: baseStyle.copyWith(color: fillColor),
        ),
      ],
    );
  }
}
