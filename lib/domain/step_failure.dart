import '../i18n/gen/strings.g.dart';
import 'app_error.dart';
import 'step.dart';

/// Wraps a [Step] that threw [error] while running against [context],
/// surfacing it through [ErrorDialog](../widgets/dialog/error_dialog.dart)
/// like any other [AppError]. Passes `onRetry: () => step.retry(context)`
/// up to [AppError] (only when [Step.retriable] is true), so the
/// dialog's retry button re-attempts exactly that step against exactly
/// that context — nothing else, which is what keeps two
/// concurrently-running step batches from affecting each other: each
/// batch's failure carries its own step and context, with no shared
/// state between them.
///
/// If [error] is itself an [AppError] (e.g. a feature-specific error type
/// a step's own work threw), [title]/[description] delegate to it so the
/// dialog still shows that error's proper message; otherwise a generic
/// message is shown.
class StepFailure<C> extends AppError {
  StepFailure({required this.step, required this.context, required this.error})
    : super(onRetry: step.retriable ? () => step.retry(context) : null);

  final Step<C> step;
  final C context;
  final Object error;

  @override
  String title(Translations t) {
    final wrapped = error;
    return wrapped is AppError ? wrapped.title(t) : t.step.failureTitle;
  }

  @override
  String description(Translations t) {
    final wrapped = error;
    return wrapped is AppError
        ? wrapped.description(t)
        : t.step.failureDescription(error: '$error');
  }
}
