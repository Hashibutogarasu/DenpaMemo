import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Displays the app's icon, name, license, package id, and author, plus a
/// static row of GitHub/X/Discord icons (decorative only, no tap handling).
/// Every value is supplied by the caller; this widget owns none of them.
class AppInfoContainer extends StatelessWidget {
  const AppInfoContainer({
    super.key,
    required this.icon,
    required this.appName,
    required this.license,
    required this.packageId,
    required this.author,
  });

  final Widget icon;
  final String appName;
  final String license;
  final String packageId;
  final String author;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 8),
          Text(appName, style: textTheme.titleMedium),
          Text(license, style: textTheme.bodySmall),
          const SizedBox(height: 16),
          Text(packageId, style: textTheme.bodySmall),
          Text(author, style: textTheme.bodySmall),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.github),
              SizedBox(width: 16),
              FaIcon(FontAwesomeIcons.xTwitter),
              SizedBox(width: 16),
              FaIcon(FontAwesomeIcons.discord),
            ],
          ),
        ],
      ),
    );
  }
}
