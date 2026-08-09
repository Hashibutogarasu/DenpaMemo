import 'package:flutter/material.dart';

/// A bred descendant in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart), reached by
/// following `DenpaMen.parentIds`, with no catch order of its own.
class BredDenpaMenNode extends StatelessWidget {
  const BredDenpaMenNode({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
