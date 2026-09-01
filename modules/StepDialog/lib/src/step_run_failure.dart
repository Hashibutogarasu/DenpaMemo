import 'step.dart';

/// Wraps a [Step] that threw [error] while running against [context].
/// Carries no title/description — translating [error] into user-facing
/// text is up to whoever catches this.
class StepRunFailure<C> implements Exception {
  const StepRunFailure({
    required this.step,
    required this.context,
    required this.error,
    this.stackTrace,
  });

  final Step<C> step;
  final C context;
  final Object error;
  final StackTrace? stackTrace;

  bool get retriable => step.retriable;

  Future<void> retry() => step.retry(context);
}
