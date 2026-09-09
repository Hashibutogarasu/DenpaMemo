import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_progress_detail.freezed.dart';

/// A non-persisted, live snapshot of one long-running operation's
/// fine-grained progress — which individual is currently being processed
/// and at what rate — reported alongside (never inside) its
/// [AppNotification](app_notification.dart), which only carries a
/// fractional [AppNotification.progress]. [kind] matches the
/// [AppNotification.kind] it accompanies.
@freezed
abstract class OperationProgressDetail with _$OperationProgressDetail {
  const factory OperationProgressDetail({
    required String kind,
    String? currentIndividualId,
    String? currentIndividualName,
    double? itemsPerSecond,
    double? bytesPerSecond,
    required DateTime updatedAt,
  }) = _OperationProgressDetail;
}
