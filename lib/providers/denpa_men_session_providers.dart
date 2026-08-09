import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men.dart';

/// In-memory snapshot of an in-progress QR-code add session: the QR code's
/// raw value plus every [DenpaMen] confirmed into it so far via "next".
/// Nothing here is persisted until "complete" is pressed.
class DenpaMenSession {
  const DenpaMenSession({
    required this.cuid,
    this.completedDenpaMens = const [],
  });

  final String cuid;
  final List<DenpaMen> completedDenpaMens;

  DenpaMenSession copyWith({
    String? cuid,
    List<DenpaMen>? completedDenpaMens,
  }) {
    return DenpaMenSession(
      cuid: cuid ?? this.cuid,
      completedDenpaMens: completedDenpaMens ?? this.completedDenpaMens,
    );
  }
}

/// Holds the active [DenpaMenSession], or null when no QR add session is in
/// progress.
class DenpaMenSessionNotifier extends Notifier<DenpaMenSession?> {
  @override
  DenpaMenSession? build() => null;

  void start(String cuid) => state = DenpaMenSession(cuid: cuid);

  void regenerateCuid(String cuid) {
    final current = state;
    if (current != null) {
      state = current.copyWith(cuid: cuid);
    }
  }

  void addDraft(DenpaMen denpaMen) {
    final current = state;
    if (current == null) {
      return;
    }
    state = current.copyWith(
      completedDenpaMens: [...current.completedDenpaMens, denpaMen],
    );
  }

  void clear() => state = null;
}

final denpaMenSessionProvider =
    NotifierProvider<DenpaMenSessionNotifier, DenpaMenSession?>(
      DenpaMenSessionNotifier.new,
    );
