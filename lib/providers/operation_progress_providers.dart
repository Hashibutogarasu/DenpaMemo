import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// In-memory (never persisted) [OperationProgressDetail] per `kind`,
/// reported alongside [appNotificationsProvider](app_notification_providers.dart)
/// by the same long-running operations, for UI that wants finer-grained
/// live detail (current individual, transfer/processing speed) than the
/// fractional progress `AppNotification` carries.
class OperationProgressNotifier
    extends Notifier<Map<String, OperationProgressDetail>> {
  @override
  Map<String, OperationProgressDetail> build() => {};

  /// Merges [currentIndividualId]/[currentIndividualName]/[itemsPerSecond]/
  /// [bytesPerSecond] into the entry for [kind], preserving any field not
  /// passed here from the previous report (different call sites report
  /// different fields at different times — e.g. byte-transfer speed and
  /// per-individual identity come from separate points in the same
  /// operation).
  void report(
    String kind, {
    String? currentIndividualId,
    String? currentIndividualName,
    double? itemsPerSecond,
    double? bytesPerSecond,
  }) {
    final previous = state[kind];
    state = {
      ...state,
      kind: OperationProgressDetail(
        kind: kind,
        currentIndividualId:
            currentIndividualId ?? previous?.currentIndividualId,
        currentIndividualName:
            currentIndividualName ?? previous?.currentIndividualName,
        itemsPerSecond: itemsPerSecond ?? previous?.itemsPerSecond,
        bytesPerSecond: bytesPerSecond ?? previous?.bytesPerSecond,
        updatedAt: DateTime.now(),
      ),
    };
  }

  void clear(String kind) {
    if (!state.containsKey(kind)) return;
    state = {...state}..remove(kind);
  }
}

final operationProgressProvider =
    NotifierProvider<
      OperationProgressNotifier,
      Map<String, OperationProgressDetail>
    >(OperationProgressNotifier.new);
