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

 String get name; List<AbnormalityResistance> get abnormalityResistances; List<String> get bodyColors; List<AttributeResistance> get attributeResistance; Physique get physique; Personality get personality; Pattern get pattern; HeadShape get headShape; Anntena get anntena; bool get isSpColor; int get happiness; int get maxHappiness; int get level; int get maxLevel; int? get currentExp; int? get maxExp; int get hp; int get ap; int get attack; int get defense; int get speed; int get evasionRate; List<Correction> get corrections;
/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DenpaMenCopyWith<DenpaMen> get copyWith => _$DenpaMenCopyWithImpl<DenpaMen>(this as DenpaMen, _$identity);

  /// Serializes this DenpaMen to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DenpaMen&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.abnormalityResistances, abnormalityResistances)&&const DeepCollectionEquality().equals(other.bodyColors, bodyColors)&&const DeepCollectionEquality().equals(other.attributeResistance, attributeResistance)&&(identical(other.physique, physique) || other.physique == physique)&&(identical(other.personality, personality) || other.personality == personality)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.headShape, headShape) || other.headShape == headShape)&&(identical(other.anntena, anntena) || other.anntena == anntena)&&(identical(other.isSpColor, isSpColor) || other.isSpColor == isSpColor)&&(identical(other.happiness, happiness) || other.happiness == happiness)&&(identical(other.maxHappiness, maxHappiness) || other.maxHappiness == maxHappiness)&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.maxExp, maxExp) || other.maxExp == maxExp)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.ap, ap) || other.ap == ap)&&(identical(other.attack, attack) || other.attack == attack)&&(identical(other.defense, defense) || other.defense == defense)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.evasionRate, evasionRate) || other.evasionRate == evasionRate)&&const DeepCollectionEquality().equals(other.corrections, corrections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,const DeepCollectionEquality().hash(abnormalityResistances),const DeepCollectionEquality().hash(bodyColors),const DeepCollectionEquality().hash(attributeResistance),physique,personality,pattern,headShape,anntena,isSpColor,happiness,maxHappiness,level,maxLevel,currentExp,maxExp,hp,ap,attack,defense,speed,evasionRate,const DeepCollectionEquality().hash(corrections)]);

@override
String toString() {
  return 'DenpaMen(name: $name, abnormalityResistances: $abnormalityResistances, bodyColors: $bodyColors, attributeResistance: $attributeResistance, physique: $physique, personality: $personality, pattern: $pattern, headShape: $headShape, anntena: $anntena, isSpColor: $isSpColor, happiness: $happiness, maxHappiness: $maxHappiness, level: $level, maxLevel: $maxLevel, currentExp: $currentExp, maxExp: $maxExp, hp: $hp, ap: $ap, attack: $attack, defense: $defense, speed: $speed, evasionRate: $evasionRate, corrections: $corrections)';
}


}

/// @nodoc
abstract mixin class $DenpaMenCopyWith<$Res>  {
  factory $DenpaMenCopyWith(DenpaMen value, $Res Function(DenpaMen) _then) = _$DenpaMenCopyWithImpl;
@useResult
$Res call({
 String name, List<AbnormalityResistance> abnormalityResistances, List<String> bodyColors, List<AttributeResistance> attributeResistance, Physique physique, Personality personality, Pattern pattern, HeadShape headShape, Anntena anntena, bool isSpColor, int happiness, int maxHappiness, int level, int maxLevel, int? currentExp, int? maxExp, int hp, int ap, int attack, int defense, int speed, int evasionRate, List<Correction> corrections
});


$PhysiqueCopyWith<$Res> get physique;$PersonalityCopyWith<$Res> get personality;$PatternCopyWith<$Res> get pattern;$HeadShapeCopyWith<$Res> get headShape;$AnntenaCopyWith<$Res> get anntena;

}
/// @nodoc
class _$DenpaMenCopyWithImpl<$Res>
    implements $DenpaMenCopyWith<$Res> {
  _$DenpaMenCopyWithImpl(this._self, this._then);

  final DenpaMen _self;
  final $Res Function(DenpaMen) _then;

/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? abnormalityResistances = null,Object? bodyColors = null,Object? attributeResistance = null,Object? physique = null,Object? personality = null,Object? pattern = null,Object? headShape = null,Object? anntena = null,Object? isSpColor = null,Object? happiness = null,Object? maxHappiness = null,Object? level = null,Object? maxLevel = null,Object? currentExp = freezed,Object? maxExp = freezed,Object? hp = null,Object? ap = null,Object? attack = null,Object? defense = null,Object? speed = null,Object? evasionRate = null,Object? corrections = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistances: null == abnormalityResistances ? _self.abnormalityResistances : abnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,bodyColors: null == bodyColors ? _self.bodyColors : bodyColors // ignore: cast_nullable_to_non_nullable
as List<String>,attributeResistance: null == attributeResistance ? _self.attributeResistance : attributeResistance // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,physique: null == physique ? _self.physique : physique // ignore: cast_nullable_to_non_nullable
as Physique,personality: null == personality ? _self.personality : personality // ignore: cast_nullable_to_non_nullable
as Personality,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as Pattern,headShape: null == headShape ? _self.headShape : headShape // ignore: cast_nullable_to_non_nullable
as HeadShape,anntena: null == anntena ? _self.anntena : anntena // ignore: cast_nullable_to_non_nullable
as Anntena,isSpColor: null == isSpColor ? _self.isSpColor : isSpColor // ignore: cast_nullable_to_non_nullable
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
as List<Correction>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<AbnormalityResistance> abnormalityResistances,  List<String> bodyColors,  List<AttributeResistance> attributeResistance,  Physique physique,  Personality personality,  Pattern pattern,  HeadShape headShape,  Anntena anntena,  bool isSpColor,  int happiness,  int maxHappiness,  int level,  int maxLevel,  int? currentExp,  int? maxExp,  int hp,  int ap,  int attack,  int defense,  int speed,  int evasionRate,  List<Correction> corrections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DenpaMen() when $default != null:
return $default(_that.name,_that.abnormalityResistances,_that.bodyColors,_that.attributeResistance,_that.physique,_that.personality,_that.pattern,_that.headShape,_that.anntena,_that.isSpColor,_that.happiness,_that.maxHappiness,_that.level,_that.maxLevel,_that.currentExp,_that.maxExp,_that.hp,_that.ap,_that.attack,_that.defense,_that.speed,_that.evasionRate,_that.corrections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<AbnormalityResistance> abnormalityResistances,  List<String> bodyColors,  List<AttributeResistance> attributeResistance,  Physique physique,  Personality personality,  Pattern pattern,  HeadShape headShape,  Anntena anntena,  bool isSpColor,  int happiness,  int maxHappiness,  int level,  int maxLevel,  int? currentExp,  int? maxExp,  int hp,  int ap,  int attack,  int defense,  int speed,  int evasionRate,  List<Correction> corrections)  $default,) {final _that = this;
switch (_that) {
case _DenpaMen():
return $default(_that.name,_that.abnormalityResistances,_that.bodyColors,_that.attributeResistance,_that.physique,_that.personality,_that.pattern,_that.headShape,_that.anntena,_that.isSpColor,_that.happiness,_that.maxHappiness,_that.level,_that.maxLevel,_that.currentExp,_that.maxExp,_that.hp,_that.ap,_that.attack,_that.defense,_that.speed,_that.evasionRate,_that.corrections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<AbnormalityResistance> abnormalityResistances,  List<String> bodyColors,  List<AttributeResistance> attributeResistance,  Physique physique,  Personality personality,  Pattern pattern,  HeadShape headShape,  Anntena anntena,  bool isSpColor,  int happiness,  int maxHappiness,  int level,  int maxLevel,  int? currentExp,  int? maxExp,  int hp,  int ap,  int attack,  int defense,  int speed,  int evasionRate,  List<Correction> corrections)?  $default,) {final _that = this;
switch (_that) {
case _DenpaMen() when $default != null:
return $default(_that.name,_that.abnormalityResistances,_that.bodyColors,_that.attributeResistance,_that.physique,_that.personality,_that.pattern,_that.headShape,_that.anntena,_that.isSpColor,_that.happiness,_that.maxHappiness,_that.level,_that.maxLevel,_that.currentExp,_that.maxExp,_that.hp,_that.ap,_that.attack,_that.defense,_that.speed,_that.evasionRate,_that.corrections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DenpaMen implements DenpaMen {
  const _DenpaMen({required this.name, required final  List<AbnormalityResistance> abnormalityResistances, required final  List<String> bodyColors, required final  List<AttributeResistance> attributeResistance, required this.physique, required this.personality, required this.pattern, required this.headShape, required this.anntena, required this.isSpColor, required this.happiness, required this.maxHappiness, required this.level, required this.maxLevel, required this.currentExp, required this.maxExp, required this.hp, required this.ap, required this.attack, required this.defense, required this.speed, required this.evasionRate, required final  List<Correction> corrections}): _abnormalityResistances = abnormalityResistances,_bodyColors = bodyColors,_attributeResistance = attributeResistance,_corrections = corrections;
  factory _DenpaMen.fromJson(Map<String, dynamic> json) => _$DenpaMenFromJson(json);

@override final  String name;
 final  List<AbnormalityResistance> _abnormalityResistances;
@override List<AbnormalityResistance> get abnormalityResistances {
  if (_abnormalityResistances is EqualUnmodifiableListView) return _abnormalityResistances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abnormalityResistances);
}

 final  List<String> _bodyColors;
@override List<String> get bodyColors {
  if (_bodyColors is EqualUnmodifiableListView) return _bodyColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyColors);
}

 final  List<AttributeResistance> _attributeResistance;
@override List<AttributeResistance> get attributeResistance {
  if (_attributeResistance is EqualUnmodifiableListView) return _attributeResistance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributeResistance);
}

@override final  Physique physique;
@override final  Personality personality;
@override final  Pattern pattern;
@override final  HeadShape headShape;
@override final  Anntena anntena;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DenpaMen&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._abnormalityResistances, _abnormalityResistances)&&const DeepCollectionEquality().equals(other._bodyColors, _bodyColors)&&const DeepCollectionEquality().equals(other._attributeResistance, _attributeResistance)&&(identical(other.physique, physique) || other.physique == physique)&&(identical(other.personality, personality) || other.personality == personality)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.headShape, headShape) || other.headShape == headShape)&&(identical(other.anntena, anntena) || other.anntena == anntena)&&(identical(other.isSpColor, isSpColor) || other.isSpColor == isSpColor)&&(identical(other.happiness, happiness) || other.happiness == happiness)&&(identical(other.maxHappiness, maxHappiness) || other.maxHappiness == maxHappiness)&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.currentExp, currentExp) || other.currentExp == currentExp)&&(identical(other.maxExp, maxExp) || other.maxExp == maxExp)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.ap, ap) || other.ap == ap)&&(identical(other.attack, attack) || other.attack == attack)&&(identical(other.defense, defense) || other.defense == defense)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.evasionRate, evasionRate) || other.evasionRate == evasionRate)&&const DeepCollectionEquality().equals(other._corrections, _corrections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,const DeepCollectionEquality().hash(_abnormalityResistances),const DeepCollectionEquality().hash(_bodyColors),const DeepCollectionEquality().hash(_attributeResistance),physique,personality,pattern,headShape,anntena,isSpColor,happiness,maxHappiness,level,maxLevel,currentExp,maxExp,hp,ap,attack,defense,speed,evasionRate,const DeepCollectionEquality().hash(_corrections)]);

@override
String toString() {
  return 'DenpaMen(name: $name, abnormalityResistances: $abnormalityResistances, bodyColors: $bodyColors, attributeResistance: $attributeResistance, physique: $physique, personality: $personality, pattern: $pattern, headShape: $headShape, anntena: $anntena, isSpColor: $isSpColor, happiness: $happiness, maxHappiness: $maxHappiness, level: $level, maxLevel: $maxLevel, currentExp: $currentExp, maxExp: $maxExp, hp: $hp, ap: $ap, attack: $attack, defense: $defense, speed: $speed, evasionRate: $evasionRate, corrections: $corrections)';
}


}

/// @nodoc
abstract mixin class _$DenpaMenCopyWith<$Res> implements $DenpaMenCopyWith<$Res> {
  factory _$DenpaMenCopyWith(_DenpaMen value, $Res Function(_DenpaMen) _then) = __$DenpaMenCopyWithImpl;
@override @useResult
$Res call({
 String name, List<AbnormalityResistance> abnormalityResistances, List<String> bodyColors, List<AttributeResistance> attributeResistance, Physique physique, Personality personality, Pattern pattern, HeadShape headShape, Anntena anntena, bool isSpColor, int happiness, int maxHappiness, int level, int maxLevel, int? currentExp, int? maxExp, int hp, int ap, int attack, int defense, int speed, int evasionRate, List<Correction> corrections
});


@override $PhysiqueCopyWith<$Res> get physique;@override $PersonalityCopyWith<$Res> get personality;@override $PatternCopyWith<$Res> get pattern;@override $HeadShapeCopyWith<$Res> get headShape;@override $AnntenaCopyWith<$Res> get anntena;

}
/// @nodoc
class __$DenpaMenCopyWithImpl<$Res>
    implements _$DenpaMenCopyWith<$Res> {
  __$DenpaMenCopyWithImpl(this._self, this._then);

  final _DenpaMen _self;
  final $Res Function(_DenpaMen) _then;

/// Create a copy of DenpaMen
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? abnormalityResistances = null,Object? bodyColors = null,Object? attributeResistance = null,Object? physique = null,Object? personality = null,Object? pattern = null,Object? headShape = null,Object? anntena = null,Object? isSpColor = null,Object? happiness = null,Object? maxHappiness = null,Object? level = null,Object? maxLevel = null,Object? currentExp = freezed,Object? maxExp = freezed,Object? hp = null,Object? ap = null,Object? attack = null,Object? defense = null,Object? speed = null,Object? evasionRate = null,Object? corrections = null,}) {
  return _then(_DenpaMen(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistances: null == abnormalityResistances ? _self._abnormalityResistances : abnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,bodyColors: null == bodyColors ? _self._bodyColors : bodyColors // ignore: cast_nullable_to_non_nullable
as List<String>,attributeResistance: null == attributeResistance ? _self._attributeResistance : attributeResistance // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,physique: null == physique ? _self.physique : physique // ignore: cast_nullable_to_non_nullable
as Physique,personality: null == personality ? _self.personality : personality // ignore: cast_nullable_to_non_nullable
as Personality,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as Pattern,headShape: null == headShape ? _self.headShape : headShape // ignore: cast_nullable_to_non_nullable
as HeadShape,anntena: null == anntena ? _self.anntena : anntena // ignore: cast_nullable_to_non_nullable
as Anntena,isSpColor: null == isSpColor ? _self.isSpColor : isSpColor // ignore: cast_nullable_to_non_nullable
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
as List<Correction>,
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
}
}

// dart format on
