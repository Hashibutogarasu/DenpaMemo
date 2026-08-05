import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import 'status.dart';

class LevelLabel extends StatelessWidget {
  const LevelLabel({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return StatusLabel(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.t.denpaMenStatus.level),
          const SizedBox(width: 4),
          Text('$level'),
        ],
      ),
    );
  }
}
