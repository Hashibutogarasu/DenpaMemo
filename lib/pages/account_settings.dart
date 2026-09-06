import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:firebase_sign_in/firebase_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../i18n/gen/strings.g.dart';
import '../providers/account_providers.dart';
import '../providers/cloud_account_providers.dart';
import '../widgets/dialog/confirm_dialog.dart';
import '../widgets/list/list_tile_section.dart';
import '../widgets/settings/copyable_list_tile.dart';

/// Wires [AccountSignInDialog]'s callbacks to [cloudAccountProvider], and
/// opens [AccountSignUpDialog] the same way when the sign-in dialog's
/// "create account" link is tapped. The dialog hosts its own
/// [ScaffoldMessenger] (via [messengerKey]) so a manual-auth-URL SnackBar
/// shows above the still-open dialog rather than behind it. On the REST
/// backend, Google sign-in goes through [_showGoogleSignInFlow] instead of
/// the notifier's own `signInWithGoogle`, so failures surface visibly
/// through [SignInFlowDialog] rather than being swallowed by
/// `AsyncValue.guard`.
void _showSignInDialog(BuildContext context, WidgetRef ref) {
  final notifier = ref.read(cloudAccountProvider.notifier);
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final restBackend = notifier.firebaseSignIn.restBackendOrNull;
  AccountSignInDialog.show(
    context,
    messengerKey: messengerKey,
    onSignInWithEmail: notifier.signInWithEmail,
    onSignInWithGoogle: restBackend != null
        ? () async {
            Navigator.of(context).pop();
            await _showGoogleSignInFlow(context, ref, restBackend);
          }
        : notifier.signInWithGoogle,
    onCreateAccount: () => AccountSignUpDialog.show(
      context,
      onSignUpWithEmail: notifier.signUpWithEmail,
    ),
  );
}

/// Runs the REST backend's 5-step Google sign-in flow through
/// [SignInFlowDialog], then commits the result via
/// [FirebaseSignInNotifier.applySignedInState].
Future<void> _showGoogleSignInFlow(
  BuildContext context,
  WidgetRef ref,
  RestFirebaseSignInBackend restBackend,
) {
  final t = context.t;
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final stepContext = restBackend.createGoogleSignInStepContext(
    onManualAuthUrl: (url) =>
        _showManualGoogleAuthUrl(context, messengerKey, url),
  );
  return SignInFlowDialog.show<GoogleSignInStepContext>(
    context,
    messengerKey: messengerKey,
    steps: buildGoogleSignInSteps(),
    stepContext: stepContext,
    title: t.settings.accountSettings.signInFlowTitle,
    stepLabels: [
      t.settings.accountSettings.signInFlowStepReceiveAuthorization,
      t.settings.accountSettings.signInFlowStepExchangeCode,
      t.settings.accountSettings.signInFlowStepIssueSession,
      t.settings.accountSettings.signInFlowStepRefreshSession,
      t.settings.accountSettings.signInFlowStepExtractUid,
    ],
    onComplete: (stepContext) => ref
        .read(cloudAccountProvider.notifier)
        .firebaseSignIn
        .applySignedInState(stepContext.refreshedSession!.toState()),
  );
}

Future<void> _signOut(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final confirmed = await ConfirmDialog.show(
    context,
    title: t.settings.accountSettings.signOutConfirmTitle,
    message: t.settings.accountSettings.signOutConfirmMessage,
  );
  if (!confirmed) {
    return;
  }
  try {
    await ref.read(cloudAccountProvider.notifier).signOut();
  } catch (error, stackTrace) {
    if (!context.mounted) return;
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: '$error',
      stackTrace: stackTrace,
    );
  }
}

Future<void> _deleteCloudAccount(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final confirmed = await ConfirmDialog.show(
    context,
    title: t.settings.accountSettings.deleteCloudAccountConfirmTitle,
    message: t.settings.accountSettings.deleteCloudAccountConfirmMessage,
  );
  if (!confirmed) {
    return;
  }
  try {
    await ref.read(cloudAccountProvider.notifier).deleteCloudAccount();
  } catch (error, stackTrace) {
    if (!context.mounted) return;
    await ErrorDialog.show(
      context,
      title: t.common.errorTitle,
      description: '$error',
      stackTrace: stackTrace,
    );
  }
}

/// Shown instead of launching a browser when the REST sign-in backend's
/// Google OAuth loopback flow has no display server to open one on (e.g.
/// Linux without `DISPLAY`/`WAYLAND_DISPLAY`). Passing null hides it once
/// the flow ends.
void _showManualGoogleAuthUrl(
  BuildContext context,
  GlobalKey<ScaffoldMessengerState> messengerKey,
  Uri? url,
) {
  if (url == null) {
    CopyableSnackBar.hide(context, messengerKey: messengerKey);
    return;
  }
  CopyableSnackBar.show(
    context,
    message: '${context.t.settings.accountSettings.manualAuthUrlMessage}\n$url',
    copyText: url.toString(),
    duration: const Duration(minutes: 5),
    messengerKey: messengerKey,
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
            ListTileSection(
              title: Text(t.settings.accountSettings.sectionCloud),
            ),
            ListItemContainer(
              children: [
                ListItemTile(
                  icon: Icons.cloud_outlined,
                  label: cloudAccount.isSignedIn
                      ? (cloudAccount.email ??
                            t.settings.accountSettings.signIn)
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
                ListItemTile(
                  icon: Icons.logout,
                  label: t.settings.accountSettings.signOut,
                  onTap: cloudAccount.isSignedIn
                      ? () => _signOut(context, ref)
                      : null,
                ),
              ],
            ),
            ListTileSection(
              title: Text(t.settings.accountSettings.sectionLocal),
            ),
            ListItemContainer(
              children: [
                CopyableListTile(
                  icon: Icons.badge_outlined,
                  label: t.settings.accountCuidLabel,
                  trailingText: account.cuid,
                ),
                ListItemTile(
                  icon: Icons.add_circle_outline,
                  label: t.settings.accountSettings.addLocalAccount,
                ),
              ],
            ),
            ListTileSection(
              title: Text(t.settings.accountSettings.sectionDangerZone),
            ),
            ListItemContainer(
              children: [
                ListItemTile(
                  icon: Icons.delete_outline,
                  label: t.settings.accountSettings.deleteCloudAccount,
                  color: Theme.of(context).colorScheme.error,
                  onTap: cloudAccount.isSignedIn
                      ? () => _deleteCloudAccount(context, ref)
                      : null,
                ),
                ListItemTile(
                  icon: Icons.delete_outline,
                  label: t.settings.accountSettings.deleteLocalAccount,
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
