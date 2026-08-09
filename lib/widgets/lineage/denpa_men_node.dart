import 'package:flutter/material.dart';

/// A `DenpaMen` node in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart): an empty square
/// where an icon will eventually go (no icon field exists on `DenpaMen`
/// yet), with its name shown below. When [catchIndex] is set (an
/// individual caught directly under a QR code), it's overlaid in the
/// square's bottom-right corner; bred descendants pass null since they
/// have no catch order of their own.
class DenpaMenNode extends StatelessWidget {
  const DenpaMenNode({
    super.key,
    required this.name,
    required this.size,
    this.catchIndex,
  });

  final String name;
  final double size;
  final int? catchIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
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
            if (catchIndex != null)
              Positioned(
                right: 4,
                bottom: 4,
                child: Text(
                  '$catchIndex',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
          ],
        ),
        SizedBox(
          width: size,
          child: Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
