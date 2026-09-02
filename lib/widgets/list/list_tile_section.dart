import 'package:flutter/material.dart';

/// A section heading above a group of list tiles (typically an
/// immediately-following [ListItemContainer]). Renders only the heading
/// text — it holds no tiles itself. [title] is a [Widget] rather than a
/// plain [String] so a formatted-date widget can stand in for it
/// directly; a bare [Text] (no explicit style) still inherits the
/// heading style via [DefaultTextStyle], same as before.
class ListTileSection extends StatelessWidget {
  const ListTileSection({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, top: 8),
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.titleSmall,
        child: title,
      ),
    );
  }
}
