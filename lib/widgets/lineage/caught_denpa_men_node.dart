import 'package:flutter/material.dart';

/// An individual caught directly under a QR code in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart): an empty square
/// where an icon will eventually go (no icon field exists on `DenpaMen`
/// yet), with its catch order shown in the bottom-right corner.
class CaughtDenpaMenNode extends StatelessWidget {
  const CaughtDenpaMenNode({
    super.key,
    required this.catchIndex,
    required this.size,
  });

  final int catchIndex;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned(
          right: 4,
          bottom: 4,
          child: Text(
            '$catchIndex',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
