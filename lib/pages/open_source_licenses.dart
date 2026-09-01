import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/foundation.dart' show LicenseEntry, LicenseRegistry;
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';

typedef _PackageLicense = ({String packageName, List<LicenseEntry> entries});

Future<List<_PackageLicense>> _loadLicenses() async {
  final entriesByPackage = <String, List<LicenseEntry>>{};
  await for (final entry in LicenseRegistry.licenses) {
    for (final package in entry.packages) {
      entriesByPackage.putIfAbsent(package, () => []).add(entry);
    }
  }
  final packageNames = entriesByPackage.keys.toList()..sort();
  return [
    for (final packageName in packageNames)
      (packageName: packageName, entries: entriesByPackage[packageName]!),
  ];
}

/// Lists every third-party package's license, built directly from
/// [LicenseRegistry] instead of [showLicensePage]: that helper always
/// pushes its own `Scaffold`/`AppBar` (with a hardcoded title) on the
/// current navigator, so inside `AppShell`'s nested navigator it opens
/// underneath the bottom navigation bar instead of as its own page.
class OpenSourceLicensesPage extends StatelessWidget {
  const OpenSourceLicensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.openSourceLicenses),
      body: FutureBuilder<List<_PackageLicense>>(
        future: _loadLicenses(),
        builder: (context, snapshot) {
          final packages = snapshot.data;
          if (packages == null) {
            return const ProgressBar();
          }
          return SmoothScrollContainer(
            child: ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return ExpansionTile(
                  title: Text(package.packageName),
                  children: [
                    for (final entry in package.entries)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: SelectableText(
                          entry.paragraphs.map((p) => p.text).join('\n\n'),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
