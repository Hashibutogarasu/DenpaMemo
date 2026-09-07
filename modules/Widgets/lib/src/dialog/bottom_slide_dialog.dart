import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../theme/app_dialog_theme.dart';

/// Shows a modal dialog that slides up from the bottom of the screen and
/// slides back down on dismissal, sharing one curve for both directions.
Future<T?> showBottomSlideDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  final theme = Theme.of(context).extension<AppDialogThemeData>()!;
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: theme.barrierColor,
    transitionDuration: theme.transitionDuration,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: theme.transitionCurve,
        reverseCurve: theme.reverseTransitionCurve,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      );
    },
  );
}

/// Shared dialog shell: a title, scrollable [content], and a cancel/confirm
/// button row. Rendered centered on screen; [showBottomSlideDialog] is what
/// makes it slide in from the bottom rather than fade in place.
class BottomSlideDialog extends StatelessWidget {
  const BottomSlideDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmEnabled = true,
  });

  final String title;
  final Widget content;
  final VoidCallback onConfirm;
  final bool confirmEnabled;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final dialogTheme = Theme.of(context).dialogTheme;
    final appDialogTheme = Theme.of(context).extension<AppDialogThemeData>()!;

    return Center(
      child: Padding(
        padding: appDialogTheme.insetPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 420,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Material(
            color:
                dialogTheme.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            shape: dialogTheme.shape,
            elevation: dialogTheme.elevation ?? 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Flexible(child: content),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(t.common.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: confirmEnabled ? onConfirm : null,
                          child: Text(t.common.confirm),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
