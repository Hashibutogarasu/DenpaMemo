import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A settings row showing [trailingText]; tapping copies it to the
/// clipboard. With no [trailingText], the tile has nothing to copy and is
/// disabled (no `onTap`), matching [SettingsTile]'s disabled-tile
/// convention.
class CopyableListTile extends StatelessWidget {
  const CopyableListTile({
    super.key,
    required this.icon,
    required this.label,
    this.trailingText,
  });

  final IconData icon;
  final String label;
  final String? trailingText;

  Future<void> _copy() async {
    final text = trailingText;
    if (text == null) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    final value = trailingText;
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: value != null ? Text(value) : null,
      enabled: value != null,
      onTap: value != null ? _copy : null,
    );
  }
}
