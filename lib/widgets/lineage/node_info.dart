import 'package:data_pack/data_pack.dart';

enum NodeKind { invisible, qrCode, caughtDenpaMen, bredDenpaMen }

class NodeInfo {
  const NodeInfo({
    required this.kind,
    this.rawValue,
    this.name,
    this.record,
  });

  final NodeKind kind;
  final String? rawValue;
  final String? name;
  final DenpaMenRecord? record;
}
