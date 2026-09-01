import 'package:flutter/material.dart';
import 'package:step_dialog/step_dialog.dart' show ErrorDialog;

import '../../i18n/gen/strings.g.dart';

/// UI-only account creation dialog: manages the email/password fields and
/// a loading flag, and delegates the actual work to [onSignUpWithEmail],
/// supplied by the caller. See [AccountSignInDialog] for why this doesn't
/// import or call into the real auth provider directly.
class AccountSignUpDialog extends StatefulWidget {
  const AccountSignUpDialog({super.key, required this.onSignUpWithEmail});

  final Future<void> Function(String email, String password) onSignUpWithEmail;

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(String email, String password) onSignUpWithEmail,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AccountSignUpDialog(onSignUpWithEmail: onSignUpWithEmail),
    );
  }

  @override
  State<AccountSignUpDialog> createState() => _AccountSignUpDialogState();
}

class _AccountSignUpDialogState extends State<AccountSignUpDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() => _isLoading = true);
    try {
      await widget.onSignUpWithEmail(_emailController.text, _passwordController.text);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error, stackTrace) {
      if (!mounted) return;
      await ErrorDialog.show(
        context,
        title: t.common.errorTitle,
        description: '$error',
        stackTrace: stackTrace,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dialogT = t.dialog.accountSignUp;
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
              const SizedBox(height: 20),
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
                      onPressed: _isLoading ? null : _signUp,
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
