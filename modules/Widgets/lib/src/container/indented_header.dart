import 'package:flutter/material.dart';

/// Wraps a `DenpaMenStatus` / `EditableDenpaMenStatus` header block (icon,
/// name, divider) with one shared left inset, so new items added inside
/// [child] stay aligned automatically instead of each hardcoding a
/// matching offset independently.
class IndentedHeader extends StatelessWidget {
  const IndentedHeader({super.key, required this.child, this.indent = 14});

  final Widget child;
  final double indent;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: indent), child: child);
  }
}
