import 'package:flutter/material.dart';

/// One labeled, selectable line in [NetworkLogTile]'s expanded detail panel.
class NetworkLogDetailRow extends StatelessWidget {
  const NetworkLogDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          SelectableText(value),
        ],
      ),
    );
  }
}
