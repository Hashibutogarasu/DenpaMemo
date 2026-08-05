import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import 'status.dart';

class HappinessLabel extends StatelessWidget {
  const HappinessLabel({super.key, required this.happiness});

  final int happiness;

  @override
  Widget build(BuildContext context) {
    return StatusLabel(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.t.denpaMenStatus.happiness),
          const SizedBox(width: 4),
          Text('$happiness'),
        ],
      ),
    );
  }
}
