import 'package:flutter/material.dart';

/// A settings row: an icon, a label, and (only when [onTap] is set) a
/// trailing chevron indicating it opens another page.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      enabled: onTap != null,
      onTap: onTap,
    );
  }
}
