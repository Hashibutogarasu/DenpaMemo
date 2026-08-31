import 'package:app_launcher_icon_widget/app_launcher_icon_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Thin wrapper around [AppLauncherIcon], which only supports Android and
/// iOS; on any other platform this falls back to a plain placeholder icon.
class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  static const _placeholder = Icon(Icons.apps, size: 64);

  @override
  Widget build(BuildContext context) {
    final isSupportedPlatform =
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
    if (!isSupportedPlatform) {
      return _placeholder;
    }
    return const AppLauncherIcon(
      width: 64,
      height: 64,
      placeholder: _placeholder,
    );
  }
}
