import '../i18n/gen/strings.g.dart';

/// Base type for every error the app surfaces via
/// [ErrorDialog](../widgets/dialog/error_dialog.dart). Each subtype maps
/// itself to display text via [title]/[description], taking the generated
/// [Translations] type (not [BuildContext]) so error classes stay plain
/// domain objects with no widget-tree dependency.
///
/// [retriable]/[retry] are driven entirely by [onRetry]: an error
/// constructed without one (the vast majority, since most errors can't be
/// recovered from by re-attempting whatever failed) is simply not
/// retriable, which hides [ErrorDialog]'s retry button. Subclasses that
/// want a retry button just need to accept an `onRetry` and forward it to
/// `super` — [retriable]/[retry] themselves never need overriding.
abstract class AppError implements Exception {
  const AppError({this.onRetry});

  final Future<void> Function()? onRetry;

  String title(Translations t);
  String description(Translations t);

  bool get retriable => onRetry != null;

  Future<void> retry() async {
    final callback = onRetry;
    if (callback != null) {
      await callback();
    }
  }
}
