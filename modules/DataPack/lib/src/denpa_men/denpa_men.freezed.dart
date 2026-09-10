// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denpa_men.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DenpaMen {

 String get id; String get name; List<AbnormalityResistance> get abnormalityResistances; List<AbnormalityResistance> get userAddedAbnormalityResistances; String get userAddedAbnormalityResistanceName; List<String> get bodyColors; List<int> get bodyColorShades; List<AttributeResistance> get attributeResistance; List<AttributeResistance> get userAddedAttributeResistances; String get userAddedAttributeResistanceName; Physique get physique; int? get physiqueColumnIndex; Personality get personality; Pattern get pattern; HeadShape get headShape; Anntena get anntena; int get antennaLevel; bool get isSpColor; int get happiness; int get maxHappiness; int get level; int get maxLevel; int? get currentExp; int? get maxExp; int get hp; int get ap; int get attack; int get defense; int get speed; int get evasionRate; List<Correction> get corrections; bool get considerCorrections; List<String> get parentIds;@Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.') int? get catchOrder; String? get qrCodeId; String? get memo; DateTime? get moveInDate; String get hash; MonsterExp? get monsterExp;
/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DenpaMenCopyWith<DenpaMen> get copyWith => _$DenpaMenCopyWithImpl<DenpaMen>(this as DenpaMen, _$identity);

  /// Serializes this DenpaMen to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DenpaMen&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.abnormalityResistances, abnormalityResistances)&&const DeepCollectionEquality().equals(other.userAddedAbnormalityResistances, userAddedAbnormalityResistances)&&(identical(other.userAddedAbnormalityResistanceName, userAddedAbnormalityResistanceName) || other.userAddedAbnormalityResistanceName == userAddedAbnormalityResistanceName)&&const DeepCollectionEquality().equals(other.bodyColors, bodyColors)&&const DeepCollectionEquality().equals(other.bodyColorShades, bodyColorShades)&&const DeepCollectionEquality().equals(other.attributeResistance, attributeResistance)&&const DeepCollectionEquality().equals(other.userAddedAttributeResistances, userAddedAttributeResistances)&&(identical(other.userAddedAttributeResistanceName, userAddedAttributeResistanceName) || other.userAddedAttributeResistanceName == userAddedAttributeResistanceName)&&(identical(other.physique, physique) || other.physique == physique)&&(identical(other.physiqueColumnIndex, physiqueColumnIndex) || other.physiqueColumnIndex == physiqueColumnIndex)&&(identical(other.personality, personality) || other.personality == personality)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.headShape, headShape) || other.headShape == headShape)&&(identical(other.anntena, anntena) || other.anntena == anntena)&&(identical(other.antennaLevel, antennaLevel) || other.antennaLevel == antennaLevel)&&(identical(other.isSpColor, isSpColor) || other.isSpColor == isSpColor)&&(identical(other.happiness, happiness) || other.happiness == happiness)&&(identical(other.maxHappiness, maxHappiness) || other.maxHappiness == maxHappiness)&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.maxExp, maxExp) || other.maxExp == maxExp)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.ap, ap) || other.ap == ap)&&(identical(other.attack, attack) || other.attack == attack)&&(identical(other.defense, defense) || other.defense == defense)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.evasionRate, evasionRate) || other.evasionRate == evasionRate)&&const DeepCollectionEquality().equals(other.corrections, corrections)&&(identical(other.considerCorrections, considerCorrections) || other.considerCorrections == considerCorrections)&&const DeepCollectionEquality().equals(other.parentIds, parentIds)&&(identical(other.catchOrder, catchOrder) || other.catchOrder == catchOrder)&&(identical(other.qrCodeId, qrCodeId) || other.qrCodeId == qrCodeId)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.moveInDate, moveInDate) || other.moveInDate == moveInDate)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.monsterExp, monsterExp) || other.monsterExp == monsterExp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,const DeepCollectionEquality().hash(abnormalityResistances),const DeepCollectionEquality().hash(userAddedAbnormalityResistances),userAddedAbnormalityResistanceName,const DeepCollectionEquality().hash(bodyColors),const DeepCollectionEquality().hash(bodyColorShades),const DeepCollectionEquality().hash(attributeResistance),const DeepCollectionEquality().hash(userAddedAttributeResistances),userAddedAttributeResistanceName,physique,physiqueColumnIndex,personality,pattern,headShape,anntena,antennaLevel,isSpColor,happiness,maxHappiness,level,maxLevel,currentExp,maxExp,hp,ap,attack,defense,speed,evasionRate,const DeepCollectionEquality().hash(corrections),considerCorrections,const DeepCollectionEquality().hash(parentIds),catchOrder,qrCodeId,memo,moveInDate,hash,monsterExp]);

@override
String toString() {
  return 'DenpaMen(id: $id, name: $name, abnormalityResistances: $abnormalityResistances, userAddedAbnormalityResistances: $userAddedAbnormalityResistances, userAddedAbnormalityResistanceName: $userAddedAbnormalityResistanceName, bodyColors: $bodyColors, bodyColorShades: $bodyColorShades, attributeResistance: $attributeResistance, userAddedAttributeResistances: $userAddedAttributeResistances, userAddedAttributeResistanceName: $userAddedAttributeResistanceName, physique: $physique, physiqueColumnIndex: $physiqueColumnIndex, personality: $personality, pattern: $pattern, headShape: $headShape, anntena: $anntena, antennaLevel: $antennaLevel, isSpColor: $isSpColor, happiness: $happiness, maxHappiness: $maxHappiness, level: $level, maxLevel: $maxLevel, currentExp: $currentExp, maxExp: $maxExp, hp: $hp, ap: $ap, attack: $attack, defense: $defense, speed: $speed, evasionRate: $evasionRate, corrections: $corrections, considerCorrections: $considerCorrections, parentIds: $parentIds, catchOrder: $catchOrder, qrCodeId: $qrCodeId, memo: $memo, moveInDate: $moveInDate, hash: $hash, monsterExp: $monsterExp)';
}


}

/// @nodoc
abstract mixin class $DenpaMenCopyWith<$Res>  {
  factory $DenpaMenCopyWith(DenpaMen value, $Res Function(DenpaMen) _then) = _$DenpaMenCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<AbnormalityResistance> abnormalityResistances, List<AbnormalityResistance> userAddedAbnormalityResistances, String userAddedAbnormalityResistanceName, List<String> bodyColors, List<int> bodyColorShades, List<AttributeResistance> attributeResistance, List<AttributeResistance> userAddedAttributeResistances, String userAddedAttributeResistanceName, Physique physique, int? physiqueColumnIndex, Personality personality, Pattern pattern, HeadShape headShape, Anntena anntena, int antennaLevel, bool isSpColor, int happiness, int maxHappiness, int level, int maxLevel, int? currentExp, int? maxExp, int hp, int ap, int attack, int defense, int speed, int evasionRate, List<Correction> corrections, bool considerCorrections, List<String> parentIds,@Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.') int? catchOrder, String? qrCodeId, String? memo, DateTime? moveInDate, String hash, MonsterExp? monsterExp
});


$PhysiqueCopyWith<$Res> get physique;$PersonalityCopyWith<$Res> get personality;$PatternCopyWith<$Res> get pattern;$HeadShapeCopyWith<$Res> get headShape;$AnntenaCopyWith<$Res> get anntena;$MonsterExpCopyWith<$Res>? get monsterExp;

}
/// @nodoc
class _$DenpaMenCopyWithImpl<$Res>
    implements $DenpaMenCopyWith<$Res> {
  _$DenpaMenCopyWithImpl(this._self, this._then);

  final DenpaMen _self;
  final $Res Function(DenpaMen) _then;

/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? abnormalityResistances = null,Object? userAddedAbnormalityResistances = null,Object? userAddedAbnormalityResistanceName = null,Object? bodyColors = null,Object? bodyColorShades = null,Object? attributeResistance = null,Object? userAddedAttributeResistances = null,Object? userAddedAttributeResistanceName = null,Object? physique = null,Object? physiqueColumnIndex = freezed,Object? personality = null,Object? pattern = null,Object? headShape = null,Object? anntena = null,Object? antennaLevel = null,Object? isSpColor = null,Object? happiness = null,Object? maxHappiness = null,Object? level = null,Object? maxLevel = null,Object? currentExp = freezed,Object? maxExp = freezed,Object? hp = null,Object? ap = null,Object? attack = null,Object? defense = null,Object? speed = null,Object? evasionRate = null,Object? corrections = null,Object? considerCorrections = null,Object? parentIds = null,Object? catchOrder = freezed,Object? qrCodeId = freezed,Object? memo = freezed,Object? moveInDate = freezed,Object? hash = null,Object? monsterExp = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistances: null == abnormalityResistances ? _self.abnormalityResistances : abnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,userAddedAbnormalityResistances: null == userAddedAbnormalityResistances ? _self.userAddedAbnormalityResistances : userAddedAbnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,userAddedAbnormalityResistanceName: null == userAddedAbnormalityResistanceName ? _self.userAddedAbnormalityResistanceName : userAddedAbnormalityResistanceName // ignore: cast_nullable_to_non_nullable
as String,bodyColors: null == bodyColors ? _self.bodyColors : bodyColors // ignore: cast_nullable_to_non_nullable
as List<String>,bodyColorShades: null == bodyColorShades ? _self.bodyColorShades : bodyColorShades // ignore: cast_nullable_to_non_nullable
as List<int>,attributeResistance: null == attributeResistance ? _self.attributeResistance : attributeResistance // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,userAddedAttributeResistances: null == userAddedAttributeResistances ? _self.userAddedAttributeResistances : userAddedAttributeResistances // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,userAddedAttributeResistanceName: null == userAddedAttributeResistanceName ? _self.userAddedAttributeResistanceName : userAddedAttributeResistanceName // ignore: cast_nullable_to_non_nullable
as String,physique: null == physique ? _self.physique : physique // ignore: cast_nullable_to_non_nullable
as Physique,physiqueColumnIndex: freezed == physiqueColumnIndex ? _self.physiqueColumnIndex : physiqueColumnIndex // ignore: cast_nullable_to_non_nullable
as int?,personality: null == personality ? _self.personality : personality // ignore: cast_nullable_to_non_nullable
as Personality,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as Pattern,headShape: null == headShape ? _self.headShape : headShape // ignore: cast_nullable_to_non_nullable
as HeadShape,anntena: null == anntena ? _self.anntena : anntena // ignore: cast_nullable_to_non_nullable
as Anntena,antennaLevel: null == antennaLevel ? _self.antennaLevel : antennaLevel // ignore: cast_nullable_to_non_nullable
as int,isSpColor: null == isSpColor ? _self.isSpColor : isSpColor // ignore: cast_nullable_to_non_nullable
as bool,happiness: null == happiness ? _self.happiness : happiness // ignore: cast_nullable_to_non_nullable
as int,maxHappiness: null == maxHappiness ? _self.maxHappiness : maxHappiness // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,maxLevel: null == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int,currentExp: freezed == currentExp ? _self.currentExp : currentExp // ignore: cast_nullable_to_non_nullable
as int?,maxExp: freezed == maxExp ? _self.maxExp : maxExp // ignore: cast_nullable_to_non_nullable
as int?,hp: null == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int,ap: null == ap ? _self.ap : ap // ignore: cast_nullable_to_non_nullable
as int,attack: null == attack ? _self.attack : attack // ignore: cast_nullable_to_non_nullable
as int,defense: null == defense ? _self.defense : defense // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as int,evasionRate: null == evasionRate ? _self.evasionRate : evasionRate // ignore: cast_nullable_to_non_nullable
as int,corrections: null == corrections ? _self.corrections : corrections // ignore: cast_nullable_to_non_nullable
as List<Correction>,considerCorrections: null == considerCorrections ? _self.considerCorrections : considerCorrections // ignore: cast_nullable_to_non_nullable
as bool,parentIds: null == parentIds ? _self.parentIds : parentIds // ignore: cast_nullable_to_non_nullable
as List<String>,catchOrder: freezed == catchOrder ? _self.catchOrder : catchOrder // ignore: cast_nullable_to_non_nullable
as int?,qrCodeId: freezed == qrCodeId ? _self.qrCodeId : qrCodeId // ignore: cast_nullable_to_non_nullable
as String?,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,moveInDate: freezed == moveInDate ? _self.moveInDate : moveInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,monsterExp: freezed == monsterExp ? _self.monsterExp : monsterExp // ignore: cast_nullable_to_non_nullable
as MonsterExp?,
  ));
}
/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhysiqueCopyWith<$Res> get physique {
  
  return $PhysiqueCopyWith<$Res>(_self.physique, (value) {
    return _then(_self.copyWith(physique: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalityCopyWith<$Res> get personality {
  
  return $PersonalityCopyWith<$Res>(_self.personality, (value) {
    return _then(_self.copyWith(personality: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternCopyWith<$Res> get pattern {
  
  return $PatternCopyWith<$Res>(_self.pattern, (value) {
    return _then(_self.copyWith(pattern: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadShapeCopyWith<$Res> get headShape {
  
  return $HeadShapeCopyWith<$Res>(_self.headShape, (value) {
    return _then(_self.copyWith(headShape: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnntenaCopyWith<$Res> get anntena {
  
  return $AnntenaCopyWith<$Res>(_self.anntena, (value) {
    return _then(_self.copyWith(anntena: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonsterExpCopyWith<$Res>? get monsterExp {
    if (_self.monsterExp == null) {
    return null;
  }

  return $MonsterExpCopyWith<$Res>(_self.monsterExp!, (value) {
    return _then(_self.copyWith(monsterExp: value));
  });
}
}


/// Adds pattern-matching-related methods to [DenpaMen].
extension DenpaMenPatterns on DenpaMen {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DenpaMen value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DenpaMen() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DenpaMen value)  $default,){
final _that = this;
switch (_that) {
case _DenpaMen():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DenpaMen value)?  $default,){
final _that = this;
switch (_that) {
case _DenpaMen() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<AbnormalityResistance> abnormalityResistances,  List<AbnormalityResistance> userAddedAbnormalityResistances,  String userAddedAbnormalityResistanceName,  List<String> bodyColors,  List<int> bodyColorShades,  List<AttributeResistance> attributeResistance,  List<AttributeResistance> userAddedAttributeResistances,  String userAddedAttributeResistanceName,  Physique physique,  int? physiqueColumnIndex,  Personality personality,  Pattern pattern,  HeadShape headShape,  Anntena anntena,  int antennaLevel,  bool isSpColor,  int happiness,  int maxHappiness,  int level,  int maxLevel,  int? currentExp,  int? maxExp,  int hp,  int ap,  int attack,  int defense,  int speed,  int evasionRate,  List<Correction> corrections,  bool considerCorrections,  List<String> parentIds, @Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.')  int? catchOrder,  String? qrCodeId,  String? memo,  DateTime? moveInDate,  String hash,  MonsterExp? monsterExp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DenpaMen() when $default != null:
return $default(_that.id,_that.name,_that.abnormalityResistances,_that.userAddedAbnormalityResistances,_that.userAddedAbnormalityResistanceName,_that.bodyColors,_that.bodyColorShades,_that.attributeResistance,_that.userAddedAttributeResistances,_that.userAddedAttributeResistanceName,_that.physique,_that.physiqueColumnIndex,_that.personality,_that.pattern,_that.headShape,_that.anntena,_that.antennaLevel,_that.isSpColor,_that.happiness,_that.maxHappiness,_that.level,_that.maxLevel,_that.currentExp,_that.maxExp,_that.hp,_that.ap,_that.attack,_that.defense,_that.speed,_that.evasionRate,_that.corrections,_that.considerCorrections,_that.parentIds,_that.catchOrder,_that.qrCodeId,_that.memo,_that.moveInDate,_that.hash,_that.monsterExp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<AbnormalityResistance> abnormalityResistances,  List<AbnormalityResistance> userAddedAbnormalityResistances,  String userAddedAbnormalityResistanceName,  List<String> bodyColors,  List<int> bodyColorShades,  List<AttributeResistance> attributeResistance,  List<AttributeResistance> userAddedAttributeResistances,  String userAddedAttributeResistanceName,  Physique physique,  int? physiqueColumnIndex,  Personality personality,  Pattern pattern,  HeadShape headShape,  Anntena anntena,  int antennaLevel,  bool isSpColor,  int happiness,  int maxHappiness,  int level,  int maxLevel,  int? currentExp,  int? maxExp,  int hp,  int ap,  int attack,  int defense,  int speed,  int evasionRate,  List<Correction> corrections,  bool considerCorrections,  List<String> parentIds, @Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.')  int? catchOrder,  String? qrCodeId,  String? memo,  DateTime? moveInDate,  String hash,  MonsterExp? monsterExp)  $default,) {final _that = this;
switch (_that) {
case _DenpaMen():
return $default(_that.id,_that.name,_that.abnormalityResistances,_that.userAddedAbnormalityResistances,_that.userAddedAbnormalityResistanceName,_that.bodyColors,_that.bodyColorShades,_that.attributeResistance,_that.userAddedAttributeResistances,_that.userAddedAttributeResistanceName,_that.physique,_that.physiqueColumnIndex,_that.personality,_that.pattern,_that.headShape,_that.anntena,_that.antennaLevel,_that.isSpColor,_that.happiness,_that.maxHappiness,_that.level,_that.maxLevel,_that.currentExp,_that.maxExp,_that.hp,_that.ap,_that.attack,_that.defense,_that.speed,_that.evasionRate,_that.corrections,_that.considerCorrections,_that.parentIds,_that.catchOrder,_that.qrCodeId,_that.memo,_that.moveInDate,_that.hash,_that.monsterExp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<AbnormalityResistance> abnormalityResistances,  List<AbnormalityResistance> userAddedAbnormalityResistances,  String userAddedAbnormalityResistanceName,  List<String> bodyColors,  List<int> bodyColorShades,  List<AttributeResistance> attributeResistance,  List<AttributeResistance> userAddedAttributeResistances,  String userAddedAttributeResistanceName,  Physique physique,  int? physiqueColumnIndex,  Personality personality,  Pattern pattern,  HeadShape headShape,  Anntena anntena,  int antennaLevel,  bool isSpColor,  int happiness,  int maxHappiness,  int level,  int maxLevel,  int? currentExp,  int? maxExp,  int hp,  int ap,  int attack,  int defense,  int speed,  int evasionRate,  List<Correction> corrections,  bool considerCorrections,  List<String> parentIds, @Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.')  int? catchOrder,  String? qrCodeId,  String? memo,  DateTime? moveInDate,  String hash,  MonsterExp? monsterExp)?  $default,) {final _that = this;
switch (_that) {
case _DenpaMen() when $default != null:
return $default(_that.id,_that.name,_that.abnormalityResistances,_that.userAddedAbnormalityResistances,_that.userAddedAbnormalityResistanceName,_that.bodyColors,_that.bodyColorShades,_that.attributeResistance,_that.userAddedAttributeResistances,_that.userAddedAttributeResistanceName,_that.physique,_that.physiqueColumnIndex,_that.personality,_that.pattern,_that.headShape,_that.anntena,_that.antennaLevel,_that.isSpColor,_that.happiness,_that.maxHappiness,_that.level,_that.maxLevel,_that.currentExp,_that.maxExp,_that.hp,_that.ap,_that.attack,_that.defense,_that.speed,_that.evasionRate,_that.corrections,_that.considerCorrections,_that.parentIds,_that.catchOrder,_that.qrCodeId,_that.memo,_that.moveInDate,_that.hash,_that.monsterExp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DenpaMen implements DenpaMen {
  const _DenpaMen({required this.id, required this.name, required final  List<AbnormalityResistance> abnormalityResistances, final  List<AbnormalityResistance> userAddedAbnormalityResistances = const <AbnormalityResistance>[], this.userAddedAbnormalityResistanceName = '', required final  List<String> bodyColors, final  List<int> bodyColorShades = const <int>[], required final  List<AttributeResistance> attributeResistance, final  List<AttributeResistance> userAddedAttributeResistances = const <AttributeResistance>[], this.userAddedAttributeResistanceName = '', required this.physique, this.physiqueColumnIndex, required this.personality, required this.pattern, required this.headShape, required this.anntena, this.antennaLevel = 0, required this.isSpColor, required this.happiness, required this.maxHappiness, required this.level, required this.maxLevel, required this.currentExp, required this.maxExp, required this.hp, required this.ap, required this.attack, required this.defense, required this.speed, required this.evasionRate, required final  List<Correction> corrections, required this.considerCorrections, required final  List<String> parentIds, @Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.') this.catchOrder, this.qrCodeId, this.memo, this.moveInDate, this.hash = '', this.monsterExp}): _abnormalityResistances = abnormalityResistances,_userAddedAbnormalityResistances = userAddedAbnormalityResistances,_bodyColors = bodyColors,_bodyColorShades = bodyColorShades,_attributeResistance = attributeResistance,_userAddedAttributeResistances = userAddedAttributeResistances,_corrections = corrections,_parentIds = parentIds;
  factory _DenpaMen.fromJson(Map<String, dynamic> json) => _$DenpaMenFromJson(json);

@override final  String id;
@override final  String name;
 final  List<AbnormalityResistance> _abnormalityResistances;
@override List<AbnormalityResistance> get abnormalityResistances {
  if (_abnormalityResistances is EqualUnmodifiableListView) return _abnormalityResistances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abnormalityResistances);
}

 final  List<AbnormalityResistance> _userAddedAbnormalityResistances;
@override@JsonKey() List<AbnormalityResistance> get userAddedAbnormalityResistances {
  if (_userAddedAbnormalityResistances is EqualUnmodifiableListView) return _userAddedAbnormalityResistances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userAddedAbnormalityResistances);
}

@override@JsonKey() final  String userAddedAbnormalityResistanceName;
 final  List<String> _bodyColors;
@override List<String> get bodyColors {
  if (_bodyColors is EqualUnmodifiableListView) return _bodyColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyColors);
}

 final  List<int> _bodyColorShades;
@override@JsonKey() List<int> get bodyColorShades {
  if (_bodyColorShades is EqualUnmodifiableListView) return _bodyColorShades;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyColorShades);
}

 final  List<AttributeResistance> _attributeResistance;
@override List<AttributeResistance> get attributeResistance {
  if (_attributeResistance is EqualUnmodifiableListView) return _attributeResistance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributeResistance);
}

 final  List<AttributeResistance> _userAddedAttributeResistances;
@override@JsonKey() List<AttributeResistance> get userAddedAttributeResistances {
  if (_userAddedAttributeResistances is EqualUnmodifiableListView) return _userAddedAttributeResistances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userAddedAttributeResistances);
}

@override@JsonKey() final  String userAddedAttributeResistanceName;
@override final  Physique physique;
@override final  int? physiqueColumnIndex;
@override final  Personality personality;
@override final  Pattern pattern;
@override final  HeadShape headShape;
@override final  Anntena anntena;
@override@JsonKey() final  int antennaLevel;
@override final  bool isSpColor;
@override final  int happiness;
@override final  int maxHappiness;
@override final  int level;
@override final  int maxLevel;
@override final  int? currentExp;
@override final  int? maxExp;
@override final  int hp;
@override final  int ap;
@override final  int attack;
@override final  int defense;
@override final  int speed;
@override final  int evasionRate;
 final  List<Correction> _corrections;
@override List<Correction> get corrections {
  if (_corrections is EqualUnmodifiableListView) return _corrections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_corrections);
}

@override final  bool considerCorrections;
 final  List<String> _parentIds;
@override List<String> get parentIds {
  if (_parentIds is EqualUnmodifiableListView) return _parentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parentIds);
}

@override@Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.') final  int? catchOrder;
@override final  String? qrCodeId;
@override final  String? memo;
@override final  DateTime? moveInDate;
@override@JsonKey() final  String hash;
@override final  MonsterExp? monsterExp;

/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DenpaMenCopyWith<_DenpaMen> get copyWith => __$DenpaMenCopyWithImpl<_DenpaMen>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DenpaMenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DenpaMen&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._abnormalityResistances, _abnormalityResistances)&&const DeepCollectionEquality().equals(other._userAddedAbnormalityResistances, _userAddedAbnormalityResistances)&&(identical(other.userAddedAbnormalityResistanceName, userAddedAbnormalityResistanceName) || other.userAddedAbnormalityResistanceName == userAddedAbnormalityResistanceName)&&const DeepCollectionEquality().equals(other._bodyColors, _bodyColors)&&const DeepCollectionEquality().equals(other._bodyColorShades, _bodyColorShades)&&const DeepCollectionEquality().equals(other._attributeResistance, _attributeResistance)&&const DeepCollectionEquality().equals(other._userAddedAttributeResistances, _userAddedAttributeResistances)&&(identical(other.userAddedAttributeResistanceName, userAddedAttributeResistanceName) || other.userAddedAttributeResistanceName == userAddedAttributeResistanceName)&&(identical(other.physique, physique) || other.physique == physique)&&(identical(other.physiqueColumnIndex, physiqueColumnIndex) || other.physiqueColumnIndex == physiqueColumnIndex)&&(identical(other.personality, personality) || other.personality == personality)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.headShape, headShape) || other.headShape == headShape)&&(identical(other.anntena, anntena) || other.anntena == anntena)&&(identical(other.antennaLevel, antennaLevel) || other.antennaLevel == antennaLevel)&&(identical(other.isSpColor, isSpColor) || other.isSpColor == isSpColor)&&(identical(other.happiness, happiness) || other.happiness == happiness)&&(identical(other.maxHappiness, maxHappiness) || other.maxHappiness == maxHappiness)&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.maxExp, maxExp) || other.maxExp == maxExp)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.ap, ap) || other.ap == ap)&&(identical(other.attack, attack) || other.attack == attack)&&(identical(other.defense, defense) || other.defense == defense)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.evasionRate, evasionRate) || other.evasionRate == evasionRate)&&const DeepCollectionEquality().equals(other._corrections, _corrections)&&(identical(other.considerCorrections, considerCorrections) || other.considerCorrections == considerCorrections)&&const DeepCollectionEquality().equals(other._parentIds, _parentIds)&&(identical(other.catchOrder, catchOrder) || other.catchOrder == catchOrder)&&(identical(other.qrCodeId, qrCodeId) || other.qrCodeId == qrCodeId)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.moveInDate, moveInDate) || other.moveInDate == moveInDate)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.monsterExp, monsterExp) || other.monsterExp == monsterExp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,const DeepCollectionEquality().hash(_abnormalityResistances),const DeepCollectionEquality().hash(_userAddedAbnormalityResistances),userAddedAbnormalityResistanceName,const DeepCollectionEquality().hash(_bodyColors),const DeepCollectionEquality().hash(_bodyColorShades),const DeepCollectionEquality().hash(_attributeResistance),const DeepCollectionEquality().hash(_userAddedAttributeResistances),userAddedAttributeResistanceName,physique,physiqueColumnIndex,personality,pattern,headShape,anntena,antennaLevel,isSpColor,happiness,maxHappiness,level,maxLevel,currentExp,maxExp,hp,ap,attack,defense,speed,evasionRate,const DeepCollectionEquality().hash(_corrections),considerCorrections,const DeepCollectionEquality().hash(_parentIds),catchOrder,qrCodeId,memo,moveInDate,hash,monsterExp]);

@override
String toString() {
  return 'DenpaMen(id: $id, name: $name, abnormalityResistances: $abnormalityResistances, userAddedAbnormalityResistances: $userAddedAbnormalityResistances, userAddedAbnormalityResistanceName: $userAddedAbnormalityResistanceName, bodyColors: $bodyColors, bodyColorShades: $bodyColorShades, attributeResistance: $attributeResistance, userAddedAttributeResistances: $userAddedAttributeResistances, userAddedAttributeResistanceName: $userAddedAttributeResistanceName, physique: $physique, physiqueColumnIndex: $physiqueColumnIndex, personality: $personality, pattern: $pattern, headShape: $headShape, anntena: $anntena, antennaLevel: $antennaLevel, isSpColor: $isSpColor, happiness: $happiness, maxHappiness: $maxHappiness, level: $level, maxLevel: $maxLevel, currentExp: $currentExp, maxExp: $maxExp, hp: $hp, ap: $ap, attack: $attack, defense: $defense, speed: $speed, evasionRate: $evasionRate, corrections: $corrections, considerCorrections: $considerCorrections, parentIds: $parentIds, catchOrder: $catchOrder, qrCodeId: $qrCodeId, memo: $memo, moveInDate: $moveInDate, hash: $hash, monsterExp: $monsterExp)';
}


}

/// @nodoc
abstract mixin class _$DenpaMenCopyWith<$Res> implements $DenpaMenCopyWith<$Res> {
  factory _$DenpaMenCopyWith(_DenpaMen value, $Res Function(_DenpaMen) _then) = __$DenpaMenCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<AbnormalityResistance> abnormalityResistances, List<AbnormalityResistance> userAddedAbnormalityResistances, String userAddedAbnormalityResistanceName, List<String> bodyColors, List<int> bodyColorShades, List<AttributeResistance> attributeResistance, List<AttributeResistance> userAddedAttributeResistances, String userAddedAttributeResistanceName, Physique physique, int? physiqueColumnIndex, Personality personality, Pattern pattern, HeadShape headShape, Anntena anntena, int antennaLevel, bool isSpColor, int happiness, int maxHappiness, int level, int maxLevel, int? currentExp, int? maxExp, int hp, int ap, int attack, int defense, int speed, int evasionRate, List<Correction> corrections, bool considerCorrections, List<String> parentIds,@Deprecated('Use DenpaMenCatchOrderResolution.newCatchOrder instead.') int? catchOrder, String? qrCodeId, String? memo, DateTime? moveInDate, String hash, MonsterExp? monsterExp
});


@override $PhysiqueCopyWith<$Res> get physique;@override $PersonalityCopyWith<$Res> get personality;@override $PatternCopyWith<$Res> get pattern;@override $HeadShapeCopyWith<$Res> get headShape;@override $AnntenaCopyWith<$Res> get anntena;@override $MonsterExpCopyWith<$Res>? get monsterExp;

}
/// @nodoc
class __$DenpaMenCopyWithImpl<$Res>
    implements _$DenpaMenCopyWith<$Res> {
  __$DenpaMenCopyWithImpl(this._self, this._then);

  final _DenpaMen _self;
  final $Res Function(_DenpaMen) _then;

/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? abnormalityResistances = null,Object? userAddedAbnormalityResistances = null,Object? userAddedAbnormalityResistanceName = null,Object? bodyColors = null,Object? bodyColorShades = null,Object? attributeResistance = null,Object? userAddedAttributeResistances = null,Object? userAddedAttributeResistanceName = null,Object? physique = null,Object? physiqueColumnIndex = freezed,Object? personality = null,Object? pattern = null,Object? headShape = null,Object? anntena = null,Object? antennaLevel = null,Object? isSpColor = null,Object? happiness = null,Object? maxHappiness = null,Object? level = null,Object? maxLevel = null,Object? currentExp = freezed,Object? maxExp = freezed,Object? hp = null,Object? ap = null,Object? attack = null,Object? defense = null,Object? speed = null,Object? evasionRate = null,Object? corrections = null,Object? considerCorrections = null,Object? parentIds = null,Object? catchOrder = freezed,Object? qrCodeId = freezed,Object? memo = freezed,Object? moveInDate = freezed,Object? hash = null,Object? monsterExp = freezed,}) {
  return _then(_DenpaMen(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistances: null == abnormalityResistances ? _self._abnormalityResistances : abnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,userAddedAbnormalityResistances: null == userAddedAbnormalityResistances ? _self._userAddedAbnormalityResistances : userAddedAbnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,userAddedAbnormalityResistanceName: null == userAddedAbnormalityResistanceName ? _self.userAddedAbnormalityResistanceName : userAddedAbnormalityResistanceName // ignore: cast_nullable_to_non_nullable
as String,bodyColors: null == bodyColors ? _self._bodyColors : bodyColors // ignore: cast_nullable_to_non_nullable
as List<String>,bodyColorShades: null == bodyColorShades ? _self._bodyColorShades : bodyColorShades // ignore: cast_nullable_to_non_nullable
as List<int>,attributeResistance: null == attributeResistance ? _self._attributeResistance : attributeResistance // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,userAddedAttributeResistances: null == userAddedAttributeResistances ? _self._userAddedAttributeResistances : userAddedAttributeResistances // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,userAddedAttributeResistanceName: null == userAddedAttributeResistanceName ? _self.userAddedAttributeResistanceName : userAddedAttributeResistanceName // ignore: cast_nullable_to_non_nullable
as String,physique: null == physique ? _self.physique : physique // ignore: cast_nullable_to_non_nullable
as Physique,physiqueColumnIndex: freezed == physiqueColumnIndex ? _self.physiqueColumnIndex : physiqueColumnIndex // ignore: cast_nullable_to_non_nullable
as int?,personality: null == personality ? _self.personality : personality // ignore: cast_nullable_to_non_nullable
as Personality,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as Pattern,headShape: null == headShape ? _self.headShape : headShape // ignore: cast_nullable_to_non_nullable
as HeadShape,anntena: null == anntena ? _self.anntena : anntena // ignore: cast_nullable_to_non_nullable
as Anntena,antennaLevel: null == antennaLevel ? _self.antennaLevel : antennaLevel // ignore: cast_nullable_to_non_nullable
as int,isSpColor: null == isSpColor ? _self.isSpColor : isSpColor // ignore: cast_nullable_to_non_nullable
as bool,happiness: null == happiness ? _self.happiness : happiness // ignore: cast_nullable_to_non_nullable
as int,maxHappiness: null == maxHappiness ? _self.maxHappiness : maxHappiness // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,maxLevel: null == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int,currentExp: freezed == currentExp ? _self.currentExp : currentExp // ignore: cast_nullable_to_non_nullable
as int?,maxExp: freezed == maxExp ? _self.maxExp : maxExp // ignore: cast_nullable_to_non_nullable
as int?,hp: null == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int,ap: null == ap ? _self.ap : ap // ignore: cast_nullable_to_non_nullable
as int,attack: null == attack ? _self.attack : attack // ignore: cast_nullable_to_non_nullable
as int,defense: null == defense ? _self.defense : defense // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as int,evasionRate: null == evasionRate ? _self.evasionRate : evasionRate // ignore: cast_nullable_to_non_nullable
as int,corrections: null == corrections ? _self._corrections : corrections // ignore: cast_nullable_to_non_nullable
as List<Correction>,considerCorrections: null == considerCorrections ? _self.considerCorrections : considerCorrections // ignore: cast_nullable_to_non_nullable
as bool,parentIds: null == parentIds ? _self._parentIds : parentIds // ignore: cast_nullable_to_non_nullable
as List<String>,catchOrder: freezed == catchOrder ? _self.catchOrder : catchOrder // ignore: cast_nullable_to_non_nullable
as int?,qrCodeId: freezed == qrCodeId ? _self.qrCodeId : qrCodeId // ignore: cast_nullable_to_non_nullable
as String?,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,moveInDate: freezed == moveInDate ? _self.moveInDate : moveInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,monsterExp: freezed == monsterExp ? _self.monsterExp : monsterExp // ignore: cast_nullable_to_non_nullable
as MonsterExp?,
  ));
}

/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhysiqueCopyWith<$Res> get physique {
  
  return $PhysiqueCopyWith<$Res>(_self.physique, (value) {
    return _then(_self.copyWith(physique: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalityCopyWith<$Res> get personality {
  
  return $PersonalityCopyWith<$Res>(_self.personality, (value) {
    return _then(_self.copyWith(personality: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatternCopyWith<$Res> get pattern {
  
  return $PatternCopyWith<$Res>(_self.pattern, (value) {
    return _then(_self.copyWith(pattern: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadShapeCopyWith<$Res> get headShape {
  
  return $HeadShapeCopyWith<$Res>(_self.headShape, (value) {
    return _then(_self.copyWith(headShape: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnntenaCopyWith<$Res> get anntena {
  
  return $AnntenaCopyWith<$Res>(_self.anntena, (value) {
    return _then(_self.copyWith(anntena: value));
  });
}/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonsterExpCopyWith<$Res>? get monsterExp {
    if (_self.monsterExp == null) {
    return null;
  }

  return $MonsterExpCopyWith<$Res>(_self.monsterExp!, (value) {
    return _then(_self.copyWith(monsterExp: value));
  });
}
}

// dart format on
