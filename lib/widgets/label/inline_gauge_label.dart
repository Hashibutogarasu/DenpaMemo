import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../field/inline_number_field.dart';
import 'gauge_value.dart';
import 'status.dart';

/// Editable "label current/max" display: [GaugeValue.current] is an
/// inline-editable number, [GaugeValue.max] is read-only text. Switches to
/// [AppColors.maxedValue] once [GaugeValue.isMaxed].
class InlineGaugeLabel extends StatelessWidget {
  const InlineGaugeLabel({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final GaugeValue value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return StatusLabel(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          SizedBox(
            width: 32,
            child: InlineNumberField(
              value: value.current,
              style: TextStyle(
                color: value.isMaxed ? AppColors.maxedValue : null,
              ),
              onChanged: onChanged,
            ),
          ),
          const Text('/'),
          Text('${value.max}'),
        ],
      ),
    );
  }
}
