import 'dart:io';

import 'package:flutter/material.dart';

/// Renders an already-resolved icon [file] (or a placeholder if it's
/// null). Entity-agnostic: shared by [DenpaMenIcon](denpa_men_icon.dart)
/// and [MonsterIcon](monster_icon.dart), and used wherever an icon has
/// already been loaded ahead of time — e.g. lineage tree nodes, where
/// every node's icon is resolved up front so the tree doesn't reflow
/// node-by-node as each icon provider finishes loading.
class ResolvedEntityIcon extends StatelessWidget {
  const ResolvedEntityIcon({super.key, required this.file, required this.size});

  final File? file;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: file == null
          ? _placeholder()
          : Image.file(file!, width: size, height: size, fit: BoxFit.cover),
    );
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      color: Colors.white,
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, size: size * 0.6, color: Colors.grey),
    );
  }
}
