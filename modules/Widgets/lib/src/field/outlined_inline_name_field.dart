import 'package:flutter/material.dart';

import '../label/outlined_title.dart';
import '../theme/denpa_men_container_theme.dart';
import 'inline_text_field.dart';

/// Inline-editable name field styled like [OutlinedTitleText]: white fill
/// over an outline stroked in the level label's color. Achieved by
/// layering a non-interactive stroked [Text] behind an [InlineTextField]
/// whose own fill is white, since a single [TextStyle] can't paint both a
/// fill and a stroke pass at once.
class OutlinedInlineNameField extends StatelessWidget {
  const OutlinedInlineNameField({
    super.key,
    required this.value,
    required this.onChanged,
    this.outlineWidth = 3,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final double outlineWidth;

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        Theme.of(context).textTheme.titleLarge ?? const TextStyle();
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;

    return Stack(
      children: [
        IgnorePointer(
          child: Text(
            value,
            style: baseStyle.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = outlineWidth
                ..color = theme.accentColor,
            ),
          ),
        ),
        InlineTextField(
          value: value,
          style: baseStyle.copyWith(color: Colors.white),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
