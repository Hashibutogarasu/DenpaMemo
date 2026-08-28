import '../denpa_men/denpa_men.dart';
import '../master_data/master_data.dart';
import 'qr_code.dart';
import 'qr_code_record.dart';

/// Persists a [QrCode] together with the [DenpaMen] individuals registered
/// under it, linking every saved individual back to the saved QR code.
abstract class QrCodeRepository {
  List<QrCodeRecord> getAll();

  /// Emits the current list immediately, then again on every change.
  Stream<List<QrCodeRecord>> watchAll();

  /// Persists [qrCode] and every entry in [denpaMens] in a single
  /// transaction, linking each saved individual to the saved [QrCode].
  /// Inserts a new [QrCode] when [id] is 0 (the default), otherwise updates
  /// the existing record with that id so more individuals can be added
  /// under an already-shared QR code.
  void saveWithDenpaMens(
    QrCode qrCode,
    List<DenpaMen> denpaMens,
    MasterData masterData, {
    int id = 0,
  });

  /// Finds the persisted [QrCode] whose [QrCode.hash] matches [hash], or null.
  QrCodeRecord? findByHash(String hash);
}
