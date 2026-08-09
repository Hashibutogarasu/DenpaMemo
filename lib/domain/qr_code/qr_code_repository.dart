import '../denpa_men/denpa_men.dart';
import '../master_data/master_data.dart';
import 'qr_code.dart';

/// Persists a [QrCode] together with the [DenpaMen] individuals registered
/// under it, linking every saved individual back to the saved QR code.
abstract class QrCodeRepository {
  /// Persists [qrCode] and every entry in [denpaMens] in a single new
  /// transaction, linking each saved individual to the saved [QrCode].
  void saveWithDenpaMens(
    QrCode qrCode,
    List<DenpaMen> denpaMens,
    MasterData masterData,
  );
}
