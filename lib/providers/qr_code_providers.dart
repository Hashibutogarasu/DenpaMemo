import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/qr_code/objectbox_qr_code_repository.dart';
import '../domain/qr_code/qr_code_record.dart';
import '../domain/qr_code/qr_code_repository.dart';
import 'objectbox_providers.dart';

final qrCodeRepositoryProvider = Provider<QrCodeRepository>((ref) {
  return ObjectBoxQrCodeRepository(ref.watch(objectBoxProvider));
});

/// Streams every saved [QrCode].
final qrCodeListProvider = StreamProvider<List<QrCodeRecord>>((ref) {
  final repository = ref.watch(qrCodeRepositoryProvider);
  return repository.watchAll();
});
