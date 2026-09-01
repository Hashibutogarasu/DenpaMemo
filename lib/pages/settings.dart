import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations;
import 'package:flutter/foundation.dart' show kProfileMode, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_metadata.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/app_info_providers.dart';
import '../routing/app_router.dart';
import '../widgets/settings/app_icon.dart';
import '../widgets/settings/copyable_list_tile.dart';
import '../widgets/settings/list_tile_section.dart';
import '../widgets/settings/settings_list_container.dart';
import '../widgets/settings/settings_tile.dart';

String _releaseChannelLabel(Translations t) {
  if (kReleaseMode) return t.settings.releaseChannelStable;
  if (kProfileMode) return t.settings.releaseChannelProfile;
  return t.settings.releaseChannelDebug;
}

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
            ListTileSection(title: t.settings.section.general),
            SettingsListContainer(
              children: [
                SettingsTile(
                  icon: Icons.account_circle_outlined,
                  label: t.settings.account,
                  onTap: () => const AccountSettingsRoute().push(context),
                ),
                SettingsTile(
                  icon: Icons.bar_chart_outlined,
                  label: t.settings.statistics,
                ),
              ],
            ),
            ListTileSection(title: t.settings.section.personal),
            SettingsListContainer(
              children: [
                SettingsTile(
                  icon: Icons.palette_outlined,
                  label: t.settings.theme,
                  onTap: () => const ThemeSettingsRoute().push(context),
                ),
                SettingsTile(
                  icon: Icons.tune_outlined,
                  label: t.settings.advanced,
                ),
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  label: t.settings.notifications,
                ),
                SettingsTile(
                  icon: Icons.language_outlined,
                  label: t.settings.language,
                  onTap: () => const LanguageSettingsRoute().push(context),
                ),
              ],
            ),
            ListTileSection(title: t.settings.section.data),
            SettingsListContainer(
              children: [
                SettingsTile(
                  icon: Icons.bar_chart_outlined,
                  label: t.settings.statistics,
                ),
                SettingsTile(
                  icon: Icons.storage_outlined,
                  label: t.settings.dataManagement,
                  onTap: () => const DataManagementRoute().push(context),
                ),
              ],
            ),
            ListTileSection(title: t.settings.section.other),
            SettingsListContainer(
              children: [
                SettingsTile(
                  icon: Icons.description_outlined,
                  label: t.settings.openSourceLicenses,
                  onTap: () => const OpenSourceLicensesRoute().push(context),
                ),
                CopyableListTile(
                  icon: Icons.numbers_outlined,
                  label: t.settings.buildNumber,
                ),
                CopyableListTile(
                  icon: Icons.info_outline,
                  label: t.settings.appVersion,
                  trailingText: packageInfo.value?.version,
                ),
                CopyableListTile(
                  icon: Icons.rocket_launch_outlined,
                  label: t.settings.releaseChannel,
                  trailingText: _releaseChannelLabel(t),
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
