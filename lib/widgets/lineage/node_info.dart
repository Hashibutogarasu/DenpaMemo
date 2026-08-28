import '../../domain/denpa_men/denpa_men_record.dart';

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
