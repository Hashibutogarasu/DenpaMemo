import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'gauge_value.dart';
import 'status.dart';

/// Read-only "label current/max" display (e.g. "レベル 1/10"), each part
/// its own [Text] rather than one interpolated string. The current value
/// switches to [AppColors.maxedValue] once [GaugeValue.isMaxed].
class GaugeLabel extends StatelessWidget {
  const GaugeLabel({super.key, required this.label, required this.value});

  final String label;
  final GaugeValue value;

  @override
  Widget build(BuildContext context) {
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
              color: value.isMaxed ? AppColors.maxedValue : null,
            ),
          ),
          const Text('/'),
          Text('${value.max}'),
        ],
      ),
    );
  }
}
