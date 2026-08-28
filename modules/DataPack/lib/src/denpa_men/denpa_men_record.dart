import 'denpa_men.dart';

/// A saved [DenpaMen] paired with its storage id, as returned by
/// [DenpaMenRepository]. The domain [DenpaMen] itself carries no id since it
/// is only meaningful once persisted.
class DenpaMenRecord {
  const DenpaMenRecord({required this.id, required this.denpaMen});

  final int id;
  final DenpaMen denpaMen;
}
