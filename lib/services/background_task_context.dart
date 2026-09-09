/// Handed to the `task` closure passed to [BackgroundService.runAsync]/
/// [ForegroundService.runAsync], letting it optionally report progress and
/// the individual currently being processed. This is purely a hook into
/// the OS-notification layer — it does not replace `AppNotification`/
/// `OperationProgressDetail` (already the source of truth for in-app
/// progress UI), and calling these methods is entirely optional. Takes the
/// individual's name directly (rather than a full `DenpaMen`) since that's
/// the only part ever shown in a notification body.
class BackgroundTaskContext {
  BackgroundTaskContext({this.onProgress, this.onIndividual});

  final void Function(double? progress)? onProgress;
  final void Function(String individualName)? onIndividual;

  void reportProgress(double? progress) => onProgress?.call(progress);

  void reportIndividual(String individualName) =>
      onIndividual?.call(individualName);
}
