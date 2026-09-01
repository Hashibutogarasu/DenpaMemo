import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/account_providers.dart';
import '../providers/cloud_account_providers.dart';
import '../widgets/settings/copyable_list_tile.dart';
import '../widgets/settings/list_tile_section.dart';
import '../widgets/settings/settings_list_container.dart';
import '../widgets/settings/settings_tile.dart';

/// Wires [AccountSignInDialog]'s callbacks to [cloudAccountProvider], and
/// opens [AccountSignUpDialog] the same way when the sign-in dialog's
/// "create account" link is tapped.
void _showSignInDialog(BuildContext context, WidgetRef ref) {
  final notifier = ref.read(cloudAccountProvider.notifier);
  AccountSignInDialog.show(
    context,
    onSignInWithEmail: notifier.signInWithEmail,
    onSignInWithGoogle: notifier.signInWithGoogle,
    onCreateAccount: () => AccountSignUpDialog.show(
      context,
      onSignUpWithEmail: notifier.signUpWithEmail,
    ),
  );
}

/// Settings → Account: cloud (Firebase) account sign-in state and local
/// (ObjectBox) account, following the same sectioned-list pattern as
/// `settings.dart`.
class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final account = ref.watch(currentAccountProvider).account;
    final cloudAccount = ref.watch(cloudAccountProvider);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.accountSettings),
      body: SmoothScrollContainer(
        child: ListView(
          children: [
            ListTileSection(title: t.settings.accountSettings.sectionCloud),
            SettingsListContainer(
              children: [
                SettingsTile(
                  icon: Icons.cloud_outlined,
                  label: cloudAccount.isSignedIn
                      ? (cloudAccount.email ?? t.settings.accountSettings.signIn)
                      : t.settings.accountSettings.signIn,
                  onTap: cloudAccount.isSignedIn
                      ? null
                      : () => _showSignInDialog(context, ref),
                ),
                CopyableListTile(
                  icon: Icons.badge_outlined,
                  label: t.settings.accountSettings.cloudUidLabel,
                  trailingText: cloudAccount.uid,
                ),
                SettingsTile(
                  icon: Icons.delete_outline,
                  label: t.settings.accountSettings.deleteCloudAccount,
                  onTap: cloudAccount.isSignedIn
                      ? () => ref.read(cloudAccountProvider.notifier).deleteCloudAccount()
                      : null,
                ),
              ],
            ),
            ListTileSection(title: t.settings.accountSettings.sectionLocal),
            SettingsListContainer(
              children: [
                CopyableListTile(
                  icon: Icons.badge_outlined,
                  label: t.settings.accountCuidLabel,
                  trailingText: account.cuid,
                ),
                SettingsTile(
                  icon: Icons.add_circle_outline,
                  label: t.settings.accountSettings.addLocalAccount,
                ),
                SettingsTile(
                  icon: Icons.delete_outline,
                  label: t.settings.accountSettings.deleteLocalAccount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
