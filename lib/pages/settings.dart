import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart' hide Translations;
import '../app_metadata.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/app_info_providers.dart';
import '../providers/release_channel_providers.dart';
import '../providers/scroll_position_providers.dart';
import '../routing/app_router.dart';
import '../widgets/list/list_tile_section.dart';
import '../widgets/settings/app_icon.dart';
import '../widgets/settings/copyable_list_tile.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  late final PersistedScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = PersistedScrollController(
      notifier: ref.read(settingsScrollOffsetProvider.notifier),
      initialOffset: ref.read(settingsScrollOffsetProvider),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final packageInfo = ref.watch(packageInfoProvider);
    final releaseChannel = ref.watch(releaseChannelProvider);
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.settings),
      body: SmoothScrollContainer(
        controller: _scrollController,
        child: ListView(
          children: [
            ListTileSection(title: Text(t.settings.section.general)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListItemContainer(
                children: [
                  ListItemTile(
                    icon: Icons.account_circle_outlined,
                    label: t.settings.account,
                    onTap: () => const AccountSettingsRoute().push(context),
                  ),
                  ListItemTile(
                    icon: Icons.cloud_sync_outlined,
                    label: t.settings.cloudBackup,
                    onTap: () => const CloudBackupRoute().push(context),
                    requiresSignIn: true,
                  ),
                  ListItemTile(
                    icon: Icons.crop_outlined,
                    label: t.settings.clipping,
                    onTap: () => const ClippingSettingsRoute().push(context),
                  ),
                ],
              ),
            ),
            ListTileSection(title: Text(t.settings.section.personal)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListItemContainer(
                children: [
                  ListItemTile(
                    icon: Icons.palette_outlined,
                    label: t.settings.theme,
                    onTap: () => const ThemeSettingsRoute().push(context),
                  ),
                  ListItemTile(
                    icon: Icons.tune_outlined,
                    label: t.settings.advanced,
                  ),
                  ListItemTile(
                    icon: Icons.notifications_outlined,
                    label: t.settings.notifications,
                  ),
                  ListItemTile(
                    icon: Icons.language_outlined,
                    label: t.settings.language,
                    onTap: () => const LanguageSettingsRoute().push(context),
                  ),
                ],
              ),
            ),
            ListTileSection(title: Text(t.settings.section.data)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListItemContainer(
                children: [
                  ListItemTile(
                    icon: Icons.bar_chart_outlined,
                    label: t.settings.statistics,
                  ),
                  ListItemTile(
                    icon: Icons.storage_outlined,
                    label: t.settings.dataManagement,
                    onTap: () => const DataManagementRoute().push(context),
                  ),
                ],
              ),
            ),
            if (kDebugMode)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTileSection(title: Text(t.settings.section.developer)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListItemContainer(
                      children: [
                        ListItemTile(
                          icon: Icons.table_chart_outlined,
                          label: t.settings.editPhysiqueTable,
                          onTap: () =>
                              const PhysiqueTableListRoute().push(context),
                        ),
                        ListItemTile(
                          icon: Icons.bug_report_outlined,
                          label: t.settings.debugLog,
                          onTap: () => const DebugLogRoute().push(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ListTileSection(title: Text(t.settings.section.other)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListItemContainer(
                children: [
                  ListItemTile(
                    icon: Icons.description_outlined,
                    label: t.settings.openSourceLicenses,
                    onTap: () => const OpenSourceLicensesRoute().push(context),
                  ),
                  CopyableListTile(
                    icon: Icons.numbers_outlined,
                    label: t.settings.buildNumber,
                    trailingText: packageInfo.value?.buildNumber,
                  ),
                  CopyableListTile(
                    icon: Icons.info_outline,
                    label: t.settings.appVersion,
                    trailingText: packageInfo.value?.version,
                  ),
                  CopyableListTile(
                    icon: Icons.rocket_launch_outlined,
                    label: t.settings.releaseChannel,
                    trailingText: releaseChannel.value,
                  ),
                ],
              ),
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
