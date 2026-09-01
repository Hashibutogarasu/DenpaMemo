import 'package:flutter/material.dart';

/// A settings row: an icon, a label, and either a trailing chevron (when
/// [onTap] is set) or [trailingText] (when it isn't).
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.trailingText,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right)
          : (trailingText != null ? Text(trailingText!) : null),
      enabled: onTap != null,
      onTap: onTap,
    );
  }
}
