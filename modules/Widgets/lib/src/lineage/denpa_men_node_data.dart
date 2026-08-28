import 'package:data_pack/data_pack.dart';

/// A [TreeNodeSpec] payload for one caught or bred individual.
class DenpaMenNodeData {
  const DenpaMenNodeData({required this.record, required this.isBred});

  final DenpaMenRecord record;
  final bool isBred;
}

/// A [TreeGroupSpec] payload for the QR code a set of individuals were
/// caught under.
class QrCodeGroupData {
  const QrCodeGroupData({required this.rawValue});

  final String rawValue;
}
