import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_notification_providers.dart';
import '../providers/operation_progress_providers.dart';
import 'background_task_context.dart';

/// Subscribes [taskContext] to the live [operationProgressProvider]/
/// [appNotificationsProvider] state already reported for [kind] by
/// whichever controller `task` calls, forwarding it into the OS
/// notification a `ForegroundService.runAsync` call is showing. Returns the
/// subscriptions so the caller can close them (in a `finally`) once `task`
/// finishes — this is purely an additional listener on top of the existing
/// state, not a replacement for it.
List<ProviderSubscription<Object?>> forwardLiveProgressToNotification(
  WidgetRef ref,
  String kind,
  BackgroundTaskContext taskContext,
) {
  final individualSubscription = ref.listenManual(
    operationProgressProvider.select(
      (detail) => detail[kind]?.currentIndividualName,
    ),
    (previous, next) {
      if (next != null) taskContext.reportIndividual(next);
    },
  );
  final progressSubscription = ref.listenManual(
    appNotificationsProvider.select(
      (notifications) =>
          notifications.firstWhereOrNull((n) => n.kind == kind)?.progress,
    ),
    (previous, next) => taskContext.reportProgress(next),
  );
  return [individualSubscription, progressSubscription];
}
