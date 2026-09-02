import 'package:flutter/material.dart';

/// Wraps a list of items (typically [ListItemTile]s) with a transparent,
/// rounded-corner, outer-padded container.
class ListItemContainer extends StatelessWidget {
  const ListItemContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(children: children),
        ),
      ),
    );
  }
}
