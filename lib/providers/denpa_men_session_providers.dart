import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// In-memory snapshot of an in-progress QR-code add session: the QR code's
/// raw value plus every [DenpaMen] confirmed into it so far via "next".
/// Nothing here is persisted until "complete" is pressed.
///
/// When resuming an already-saved QR code (see `qr_code_selection.dart`),
/// [existingQrCode] holds the QR code being added to, [qrCodeEntityId] its
/// storage id, and [existingDenpaMenCount] how many individuals were already
/// saved under it, so newly caught individuals continue that catch order
/// instead of restarting at 0. For a brand-new QR code these stay
/// null/0/0 and [name] holds the user-edited name instead.
class DenpaMenSession {
  const DenpaMenSession({
    required this.cuid,
    this.completedDenpaMens = const [],
    this.name,
    this.existingQrCode,
    this.qrCodeEntityId = 0,
    this.existingDenpaMenCount = 0,
  });

  final String cuid;
  final List<DenpaMen> completedDenpaMens;
  final String? name;
  final QrCode? existingQrCode;
  final int qrCodeEntityId;
  final int existingDenpaMenCount;

  DenpaMenSession copyWith({
    String? cuid,
    List<DenpaMen>? completedDenpaMens,
    String? name,
  }) {
    return DenpaMenSession(
      cuid: cuid ?? this.cuid,
      completedDenpaMens: completedDenpaMens ?? this.completedDenpaMens,
      name: name ?? this.name,
      existingQrCode: existingQrCode,
      qrCodeEntityId: qrCodeEntityId,
      existingDenpaMenCount: existingDenpaMenCount,
    );
  }
}

/// Holds the active [DenpaMenSession], or null when no QR add session is in
/// progress.
class DenpaMenSessionNotifier extends Notifier<DenpaMenSession?> {
  @override
  DenpaMenSession? build() => null;

  void start(
    String cuid, {
    QrCode? existingQrCode,
    int qrCodeEntityId = 0,
    int existingDenpaMenCount = 0,
  }) => state = DenpaMenSession(
    cuid: cuid,
    existingQrCode: existingQrCode,
    qrCodeEntityId: qrCodeEntityId,
    existingDenpaMenCount: existingDenpaMenCount,
  );

  void regenerateCuid(String cuid) {
    final current = state;
    if (current != null) {
      state = current.copyWith(cuid: cuid);
    }
  }

  void setName(String? name) {
    final current = state;
    if (current != null) {
      state = DenpaMenSession(
        cuid: current.cuid,
        completedDenpaMens: current.completedDenpaMens,
        name: name,
        existingQrCode: current.existingQrCode,
        qrCodeEntityId: current.qrCodeEntityId,
        existingDenpaMenCount: current.existingDenpaMenCount,
      );
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
