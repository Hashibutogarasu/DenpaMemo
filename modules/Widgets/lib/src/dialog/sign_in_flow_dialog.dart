import 'package:flutter/material.dart' hide Step;

import 'package:step_dialog/step_dialog.dart' show Step;

import 'app_dialog.dart';
import 'sign_in_flow_container.dart';

/// Shows a [SignInFlowContainer] as a non-dismissible dialog — the only
/// way out is its Cancel button, or its OK button once every step has
/// completed. Follows the same static `.show()` convention as
/// `AccountSignInDialog`/`AccountSignUpDialog`.
class SignInFlowDialog {
  const SignInFlowDialog._();

  static Future<void> show<C>(
    BuildContext context, {
    required List<Step<C>> steps,
    required C stepContext,
    required List<String> stepLabels,
    String? title,
    VoidCallback? onCancel,
    void Function(C stepContext)? onComplete,
    GlobalKey<ScaffoldMessengerState>? messengerKey,
  }) {
    return AppDialog.show<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SignInFlowContainer<C>(
        steps: steps,
        stepContext: stepContext,
        stepLabels: stepLabels,
        title: title,
        onCancel: onCancel,
        onComplete: onComplete,
        messengerKey: messengerKey,
      ),
    );
  }
}
