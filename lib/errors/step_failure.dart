import 'package:step_dialog/step_dialog.dart' hide Translations;

import '../i18n/gen/strings.g.dart';
import 'app_error.dart';

/// Wraps a [StepRunFailure] as an [AppError], so it can be shown the same
/// way as any other app error. Delegates to the wrapped error's own
/// title/description when it's itself an [AppError]; otherwise falls back
/// to a generic message.
class StepFailure<C> extends AppError {
  StepFailure(this.failure)
    : super(onRetry: failure.retriable ? failure.retry : null);

  final StepRunFailure<C> failure;

  @override
  String title(Translations t) {
    final wrapped = failure.error;
    return wrapped is AppError ? wrapped.title(t) : t.step.failureTitle;
  }

  @override
  String description(Translations t) {
    final wrapped = failure.error;
    return wrapped is AppError
        ? wrapped.description(t)
        : t.step.failureDescription(error: '${failure.error}');
  }
}
