import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Base class for showing OS-level notifications (Android via
/// `flutter_local_notifications`, Linux via its official federated
/// `flutter_local_notifications_linux` implementation — the same plugin
/// API routes to whichever platform implementation is registered, so no
/// separate per-platform Dart classes are needed here). Any other platform
/// this app doesn't ship for is a silent no-op.
///
/// [BackgroundService] and [ForegroundService] each independently extend
/// this class rather than one wrapping the other, so a caller's choice of
/// which service to use is visible directly in the call site rather than
/// hidden behind a boolean flag.
abstract class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const _channelId = 'operation_progress';
  static const _channelName = 'Operation progress';
  static const _channelDescription =
      'Shows the progress of cloud backup/restore and .dm export/import.';

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    _initialized = true;
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        linux: LinuxInitializationSettings(defaultActionName: 'Open'),
      ),
    );
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  /// Shows (or, if [id] already has a visible notification, updates) a
  /// notification. [progress] is a 0.0-1.0 fraction shown as a native
  /// progress bar on Android; [indeterminate] shows a spinner-style bar
  /// with no fixed endpoint (e.g. while [progress] isn't known yet).
  Future<void> show({
    required String id,
    required String title,
    String? body,
    double? progress,
    bool indeterminate = false,
  }) => _showOrUpdate(
    id: id,
    title: title,
    body: body,
    progress: progress,
    indeterminate: indeterminate,
  );

  /// Alias for [show] — `flutter_local_notifications` treats a repeated
  /// `show()` call with the same [id] as an in-place update, so both
  /// methods share one implementation.
  Future<void> update({
    required String id,
    required String title,
    String? body,
    double? progress,
    bool indeterminate = false,
  }) => _showOrUpdate(
    id: id,
    title: title,
    body: body,
    progress: progress,
    indeterminate: indeterminate,
  );

  Future<void> _showOrUpdate({
    required String id,
    required String title,
    String? body,
    double? progress,
    bool indeterminate = false,
  }) async {
    await _ensureInitialized();
    final showProgress = indeterminate || progress != null;
    final percent = progress == null ? 0 : (progress * 100).round();
    await _plugin.show(
      id: id.hashCode,
      title: title,
      body: body ?? (progress != null ? '$percent%' : null),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          onlyAlertOnce: true,
          showProgress: showProgress,
          maxProgress: 100,
          progress: percent,
          indeterminate: indeterminate,
        ),
        linux: const LinuxNotificationDetails(),
      ),
    );
  }

  /// Removes the notification at [id], if any.
  Future<void> cancel(String id) async {
    await _ensureInitialized();
    await _plugin.cancel(id: id.hashCode);
  }
}
