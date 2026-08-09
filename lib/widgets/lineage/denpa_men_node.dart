import 'dart:io';

import 'package:flutter/material.dart';

import '../icon/denpa_men_icon.dart';

/// A `DenpaMen` node in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart): [iconFile]'s
/// image (or a placeholder if it's null), with its name shown below. The
/// icon is resolved by the caller ahead of time — rather than watched
/// here — so the graph lays out once and doesn't reflow node-by-node as
/// each icon finishes loading. When [catchIndex] is set (an individual
/// caught directly under a QR code), it's overlaid in the icon's
/// bottom-right corner; bred descendants pass null since they have no
/// catch order of their own.
class DenpaMenNode extends StatelessWidget {
  const DenpaMenNode({
    super.key,
    required this.iconFile,
    required this.name,
    required this.size,
    this.catchIndex,
  });

  final File? iconFile;
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
            ResolvedDenpaMenIcon(file: iconFile, size: size),
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
