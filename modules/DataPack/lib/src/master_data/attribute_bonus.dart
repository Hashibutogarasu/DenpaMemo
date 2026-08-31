import 'attribute.dart';

/// An attribute resistance bonus a body color or head shape grants, resolved
/// from a raw `{attributeId: bonus}` JSON map by
/// [JsonMasterDataRepository.load].
typedef AttributeBonus = ({Attribute attribute, int bonus});
