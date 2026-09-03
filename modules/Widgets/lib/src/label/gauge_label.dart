import 'package:flutter/material.dart';

import '../theme/denpa_men_label_theme.dart';
import 'gauge_value.dart';
import 'status.dart';

/// Read-only "label current/max" display (e.g. "レベル 1/10"), each part
/// its own [Text] rather than one interpolated string.
class GaugeLabel extends StatelessWidget {
  const GaugeLabel({super.key, required this.label, required this.value});

  final String label;
  final GaugeValue value;

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
          Text(
            '${value.current}',
            style: TextStyle(
              color: value.isMaxed ? theme.maxedValueColor : null,
            ),
          ),
          const Text('/'),
          Text('${value.max}'),
        ],
      ),
    );
  }
}
