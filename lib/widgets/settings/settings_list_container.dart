import 'package:flutter/material.dart';

/// Wraps a settings page's list of [SettingsTile]s with a transparent,
/// rounded-corner, outer-padded container.
class SettingsListContainer extends StatelessWidget {
  const SettingsListContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(children: children),
        ),
      ),
    );
  }
}
