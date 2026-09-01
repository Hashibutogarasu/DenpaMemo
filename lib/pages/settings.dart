import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_metadata.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/app_info_providers.dart';
import '../routing/app_router.dart';
import '../widgets/settings/app_icon.dart';
import '../widgets/settings/settings_list_container.dart';
import '../widgets/settings/settings_tile.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final packageInfo = ref.watch(packageInfoProvider);
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.settings),
      body: SmoothScrollContainer(
        child: ListView(
          children: [
            SettingsListContainer(
              children: [
                SettingsTile(
                  icon: Icons.account_circle_outlined,
                  label: t.settings.account,
                  onTap: () => const AccountSettingsRoute().push(context),
                ),
                SettingsTile(
                  icon: Icons.palette_outlined,
                  label: t.settings.theme,
                  onTap: () => const ThemeSettingsRoute().push(context),
                ),
                SettingsTile(
                  icon: Icons.language_outlined,
                  label: t.settings.language,
                  onTap: () => const LanguageSettingsRoute().push(context),
                ),
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  label: t.settings.notifications,
                ),
                SettingsTile(
                  icon: Icons.tune_outlined,
                  label: t.settings.advanced,
                ),
                SettingsTile(
                  icon: Icons.bar_chart_outlined,
                  label: t.settings.statistics,
                ),
                SettingsTile(
                  icon: Icons.description_outlined,
                  label: t.settings.openSourceLicenses,
                  onTap: () => const OpenSourceLicensesRoute().push(context),
                ),
                SettingsTile(
                  icon: Icons.storage_outlined,
                  label: t.settings.dataManagement,
                  onTap: () => const DataManagementRoute().push(context),
                ),
              ],
            ),
            packageInfo.when(
              data: (info) => AppInfoContainer(
                icon: const AppIcon(),
                appName: info.appName,
                license: appMetadataConfig.license,
                packageId: info.packageName,
                author: appMetadataConfig.author,
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stackTrace) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
