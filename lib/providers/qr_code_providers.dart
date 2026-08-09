import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/qr_code/objectbox_qr_code_repository.dart';
import '../domain/qr_code/qr_code_repository.dart';
import 'objectbox_providers.dart';

final qrCodeRepositoryProvider = Provider<QrCodeRepository>((ref) {
  return ObjectBoxQrCodeRepository(ref.watch(objectBoxProvider));
});
