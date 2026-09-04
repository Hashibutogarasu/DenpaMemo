// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipping_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClippingSlot _$ClippingSlotFromJson(Map<String, dynamic> json) =>
    _ClippingSlot(
      slotType: $enumDecode(_$DenpaMenImageSlotTypeEnumMap, json['slotType']),
      name: json['name'] as String,
      priority: (json['priority'] as num).toInt(),
      left: (json['left'] as num).toDouble(),
      top: (json['top'] as num).toDouble(),
      right: (json['right'] as num).toDouble(),
      bottom: (json['bottom'] as num).toDouble(),
    );

Map<String, dynamic> _$ClippingSlotToJson(_ClippingSlot instance) =>
    <String, dynamic>{
      'slotType': _$DenpaMenImageSlotTypeEnumMap[instance.slotType]!,
      'name': instance.name,
      'priority': instance.priority,
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
    };

const _$DenpaMenImageSlotTypeEnumMap = {
  DenpaMenImageSlotType.face: 'face',
  DenpaMenImageSlotType.wholeBody: 'wholeBody',
  DenpaMenImageSlotType.icon: 'icon',
};
