import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/denpa_men_icon_providers.dart';

/// Shows the icon image set for the `DenpaMen` with [denpaMenId], or a
/// placeholder box if it has none set yet.
class DenpaMenIcon extends ConsumerWidget {
  const DenpaMenIcon({super.key, required this.denpaMenId, required this.size});

  final String denpaMenId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconAsync = ref.watch(denpaMenIconProvider(denpaMenId));
    return ResolvedDenpaMenIcon(file: iconAsync.value, size: size);
  }
}

/// Renders an already-resolved icon [file] (or a placeholder if it's
/// null), without watching [denpaMenIconProvider] itself. Used wherever
/// the icon has already been loaded ahead of time — e.g. lineage tree
/// nodes, where every node's icon is resolved up front so the tree
/// doesn't reflow node-by-node as each icon provider finishes loading.
class ResolvedDenpaMenIcon extends StatelessWidget {
  const ResolvedDenpaMenIcon({super.key, required this.file, required this.size});

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
