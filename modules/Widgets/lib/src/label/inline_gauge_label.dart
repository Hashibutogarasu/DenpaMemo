import 'package:flutter/material.dart';

import '../field/inline_number_field.dart';
import '../icon/slash_icon.dart';
import '../theme/denpa_men_label_theme.dart';
import 'gauge_value.dart';
import 'status.dart';

/// Editable "label current/max" display: both [GaugeValue.current] and
/// [GaugeValue.max] are inline-editable numbers.
class InlineGaugeLabel extends StatelessWidget {
  const InlineGaugeLabel({
    super.key,
    required this.label,
    required this.value,
    required this.onCurrentChanged,
    required this.onMaxChanged,
  });

  final String label;
  final GaugeValue value;
  final ValueChanged<int> onCurrentChanged;
  final ValueChanged<int> onMaxChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenLabelThemeData>()!;
    return StatusLabel(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        clipBehavior: Clip.hardEdge,
        children: [
          Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 4),
          SizedBox(
            width: 32,
            child: InlineNumberField(
              value: value.current,
              style: TextStyle(
                color: value.isMaxed ? theme.maxedValueColor : null,
              ),
              onChanged: onCurrentChanged,
            ),
          ),
          const SlashIcon(size: 16),
          SizedBox(
            width: 32,
            child: InlineNumberField(value: value.max, onChanged: onMaxChanged),
          ),
        ],
      ),
    );
  }
}
