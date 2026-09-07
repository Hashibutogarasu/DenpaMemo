import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../../i18n/gen/strings.g.dart';
import 'app_dialog.dart';

/// UI-only cloud sign-in dialog: manages the email/password fields and the
/// in-flight sign-in [Future], and delegates the actual sign-in work to
/// [onSignInWithEmail]/[onSignInWithGoogle], supplied by the caller (which
/// owns the real `firebase_auth`/`google_sign_in`-backed provider) — this
/// widget never imports or calls into that provider itself. Any exception
/// thrown by those callbacks is caught here and shown via the shared
/// [ErrorDialog].
class AccountSignInDialog extends StatefulWidget {
  const AccountSignInDialog({
    super.key,
    required this.onSignInWithEmail,
    required this.onSignInWithGoogle,
    required this.onCreateAccount,
    this.messengerKey,
  });

  final Future<void> Function(String email, String password) onSignInWithEmail;
  final Future<void> Function() onSignInWithGoogle;
  final VoidCallback onCreateAccount;

  /// When set, hosts a [ScaffoldMessenger] within this dialog's own overlay
  /// entry so callers can target it (e.g. via [CopyableSnackBar]'s
  /// `messengerKey`) to show a SnackBar above this still-open dialog,
  /// rather than behind it.
  final GlobalKey<ScaffoldMessengerState>? messengerKey;

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(String email, String password)
    onSignInWithEmail,
    required Future<void> Function() onSignInWithGoogle,
    required VoidCallback onCreateAccount,
    GlobalKey<ScaffoldMessengerState>? messengerKey,
  }) {
    return AppDialog.show<void>(
      context: context,
      builder: (context) => AccountSignInDialog(
        onSignInWithEmail: onSignInWithEmail,
        onSignInWithGoogle: onSignInWithGoogle,
        onCreateAccount: onCreateAccount,
        messengerKey: messengerKey,
      ),
    );
  }

  @override
  State<AccountSignInDialog> createState() => _AccountSignInDialogState();
}

class _AccountSignInDialogState extends State<AccountSignInDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future<void>? _signInFuture;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _run(Future<void> Function() action) {
    setState(() {
      _signInFuture = action()
          .then((_) {
            if (mounted) {
              Navigator.of(context).pop();
            }
          })
          .catchError((Object error, StackTrace stackTrace) async {
            if (!mounted) return;
            await ErrorDialog.show(
              context,
              title: t.common.errorTitle,
              description: '$error',
              stackTrace: stackTrace,
            );
          });
    });
  }

  void _signInWithEmail() => _run(
    () => widget.onSignInWithEmail(
      _emailController.text,
      _passwordController.text,
    ),
  );

  void _signInWithGoogle() => _run(widget.onSignInWithGoogle);

  @override
  Widget build(BuildContext context) {
    final dialog = _buildDialog(context);
    final messengerKey = widget.messengerKey;
    if (messengerKey == null) {
      return dialog;
    }
    return ScaffoldMessenger(
      key: messengerKey,
      child: Scaffold(backgroundColor: Colors.transparent, body: dialog),
    );
  }

  Widget _buildDialog(BuildContext context) {
    final dialogT = t.dialog.accountSignIn;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<void>(
            future: _signInFuture,
            builder: (context, snapshot) {
              final running =
                  snapshot.connectionState == ConnectionState.waiting;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    dialogT.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: dialogT.emailLabel,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: dialogT.passwordLabel,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(dialogT.orDivider),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: running ? null : _signInWithGoogle,
                    icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                    label: Text(dialogT.googleButton),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: running
                          ? null
                          : () {
                              Navigator.of(context).pop();
                              widget.onCreateAccount();
                            },
                      child: Text(dialogT.createAccountLink),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: running
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: Text(t.common.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: running ? null : _signInWithEmail,
                          child: Visibility(
                            visible: !running,
                            replacement: const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            child: Text(dialogT.confirmButton),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
