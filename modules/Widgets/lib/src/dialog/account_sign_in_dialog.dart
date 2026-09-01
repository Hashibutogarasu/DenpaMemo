import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../../i18n/gen/strings.g.dart';

/// UI-only cloud sign-in dialog: manages the email/password fields and a
/// loading flag, and delegates the actual sign-in work to [onSignInWithEmail]/
/// [onSignInWithGoogle], supplied by the caller (which owns the real
/// `firebase_auth`/`google_sign_in`-backed provider) — this widget never
/// imports or calls into that provider itself. Any exception thrown by
/// those callbacks is caught here and shown via the shared [ErrorDialog].
class AccountSignInDialog extends StatefulWidget {
  const AccountSignInDialog({
    super.key,
    required this.onSignInWithEmail,
    required this.onSignInWithGoogle,
    required this.onCreateAccount,
  });

  final Future<void> Function(String email, String password) onSignInWithEmail;
  final Future<void> Function() onSignInWithGoogle;
  final VoidCallback onCreateAccount;

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(String email, String password) onSignInWithEmail,
    required Future<void> Function() onSignInWithGoogle,
    required VoidCallback onCreateAccount,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AccountSignInDialog(
        onSignInWithEmail: onSignInWithEmail,
        onSignInWithGoogle: onSignInWithGoogle,
        onCreateAccount: onCreateAccount,
      ),
    );
  }

  @override
  State<AccountSignInDialog> createState() => _AccountSignInDialogState();
}

class _AccountSignInDialogState extends State<AccountSignInDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _isLoading = true);
    try {
      await action();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (!mounted) return;
      await ErrorDialog.show(context, title: t.common.errorTitle, description: '$error');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithEmail() =>
      _run(() => widget.onSignInWithEmail(_emailController.text, _passwordController.text));

  Future<void> _signInWithGoogle() => _run(widget.onSignInWithGoogle);

  @override
  Widget build(BuildContext context) {
    final dialogT = t.dialog.accountSignIn;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                label: Text(dialogT.googleButton),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading
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
                      onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                      child: Text(t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _isLoading ? null : _signInWithEmail,
                      child: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(dialogT.confirmButton),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
