import 'package:flutter/material.dart';

/// Semi-transparent black overlay with a centered checkmark, shown over an
/// icon-sized area to indicate it's selected. Shared by
/// [DenpaMenContainer](denpa_men_container.dart) and
/// [DenpaMenNode](lineage/denpa_men_node.dart) so the two selection UIs
/// look identical.
class DenpaMenSelectedOverlay extends StatelessWidget {
  const DenpaMenSelectedOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        alignment: Alignment.center,
        child: const Checkbox(value: true, onChanged: null),
      ),
    );
  }
}
