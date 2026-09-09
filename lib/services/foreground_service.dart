import 'background_task_context.dart';
import 'notification_service.dart';

/// Runs [task] with an OS notification shown for its duration — started
/// before [task] runs, updated whenever [task] reports progress/the
/// current individual through its [BackgroundTaskContext], and removed
/// once [task] finishes (whether it succeeds or throws). Independent of
/// [BackgroundService] (neither wraps nor references the other); both
/// extend the shared [NotificationService] base. Callers pick this over
/// [BackgroundService] by simply calling `foregroundService.runAsync(...)`
/// instead of `backgroundService.runAsync(...)` — there is no boolean
/// flag to thread through.
class ForegroundService extends NotificationService {
  Future<T> runAsync<T>({
    required Future<T> Function(BackgroundTaskContext context) task,
    String? notificationId,
    String? notificationTitle,
  }) async {
    final id = notificationId ?? 'operation_progress';
    final title = notificationTitle ?? 'Operation in progress';
    await show(id: id, title: title, indeterminate: true);

    // Progress and the current individual arrive from separate calls at
    // separate times; keep the latest of each so one doesn't blow away the
    // other's content in the notification.
    double? lastProgress;
    String? lastIndividualName;
    void refresh() => update(
      id: id,
      title: title,
      body: lastIndividualName,
      progress: lastProgress,
      indeterminate: lastProgress == null,
    );

    final context = BackgroundTaskContext(
      onProgress: (progress) {
        lastProgress = progress;
        refresh();
      },
      onIndividual: (individualName) {
        lastIndividualName = individualName;
        refresh();
      },
    );
    try {
      return await task(context);
    } finally {
      await cancel(id);
    }
  }
}
