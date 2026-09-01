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
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? trailingText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final effectiveColor = enabled ? color : null;
    return ListTile(
      leading: Icon(icon, color: effectiveColor),
      title: Text(label, style: effectiveColor != null ? TextStyle(color: effectiveColor) : null),
      trailing: enabled
          ? const Icon(Icons.chevron_right)
          : (trailingText != null ? Text(trailingText!) : null),
      enabled: enabled,
      onTap: onTap,
    );
  }
}
