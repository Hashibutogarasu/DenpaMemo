import 'background_task_context.dart';
import 'notification_service.dart';

/// Runs [task] silently — no OS notification is ever shown, regardless of
/// what [task] reports through its [BackgroundTaskContext]. Independent of
/// [ForegroundService] (neither wraps nor references the other); both
/// extend the shared [NotificationService] base. Use this for short,
/// behind-the-scenes work that isn't worth surfacing as a system
/// notification — the four long-running cloud/`.dm` operations in this app
/// all use [ForegroundService] instead.
class BackgroundService extends NotificationService {
  Future<T> runAsync<T>({
    required Future<T> Function(BackgroundTaskContext context) task,
  }) {
    return task(BackgroundTaskContext());
  }
}
