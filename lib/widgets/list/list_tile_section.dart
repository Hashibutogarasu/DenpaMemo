import 'package:flutter/material.dart';

/// A section heading above a group of list tiles (typically an
/// immediately-following [ListItemContainer]). Renders only the heading
/// text — it holds no tiles itself.
class ListTileSection extends StatelessWidget {
  const ListTileSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, top: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
