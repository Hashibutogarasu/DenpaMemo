// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'head_shape.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeadShape {

 String get id; Map<String, int> get abnormalityResistanceBonuses;@JsonKey(includeFromJson: false, includeToJson: false) List<AttributeBonus> get attributeResistanceBonuses; int get hpBonus; int get apBonus; int get attackBonus; int get defenseBonus; int get speedBonus; int get evasionRateBonus;
/// Create a copy of HeadShape
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadShapeCopyWith<HeadShape> get copyWith => _$HeadShapeCopyWithImpl<HeadShape>(this as HeadShape, _$identity);

  /// Serializes this HeadShape to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadShape&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.abnormalityResistanceBonuses, abnormalityResistanceBonuses)&&const DeepCollectionEquality().equals(other.attributeResistanceBonuses, attributeResistanceBonuses)&&(identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus)&&(identical(other.apBonus, apBonus) || other.apBonus == apBonus)&&(identical(other.attackBonus, attackBonus) || other.attackBonus == attackBonus)&&(identical(other.defenseBonus, defenseBonus) || other.defenseBonus == defenseBonus)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.evasionRateBonus, evasionRateBonus) || other.evasionRateBonus == evasionRateBonus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(abnormalityResistanceBonuses),const DeepCollectionEquality().hash(attributeResistanceBonuses),hpBonus,apBonus,attackBonus,defenseBonus,speedBonus,evasionRateBonus);

@override
String toString() {
  return 'HeadShape(id: $id, abnormalityResistanceBonuses: $abnormalityResistanceBonuses, attributeResistanceBonuses: $attributeResistanceBonuses, hpBonus: $hpBonus, apBonus: $apBonus, attackBonus: $attackBonus, defenseBonus: $defenseBonus, speedBonus: $speedBonus, evasionRateBonus: $evasionRateBonus)';
}


}

/// @nodoc
abstract mixin class $HeadShapeCopyWith<$Res>  {
  factory $HeadShapeCopyWith(HeadShape value, $Res Function(HeadShape) _then) = _$HeadShapeCopyWithImpl;
@useResult
$Res call({
 String id, Map<String, int> abnormalityResistanceBonuses,@JsonKey(includeFromJson: false, includeToJson: false) List<AttributeBonus> attributeResistanceBonuses, int hpBonus, int apBonus, int attackBonus, int defenseBonus, int speedBonus, int evasionRateBonus
});




}
/// @nodoc
class _$HeadShapeCopyWithImpl<$Res>
    implements $HeadShapeCopyWith<$Res> {
  _$HeadShapeCopyWithImpl(this._self, this._then);

  final HeadShape _self;
  final $Res Function(HeadShape) _then;

/// Create a copy of HeadShape
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? abnormalityResistanceBonuses = null,Object? attributeResistanceBonuses = null,Object? hpBonus = null,Object? apBonus = null,Object? attackBonus = null,Object? defenseBonus = null,Object? speedBonus = null,Object? evasionRateBonus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self.abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,attributeResistanceBonuses: null == attributeResistanceBonuses ? _self.attributeResistanceBonuses : attributeResistanceBonuses // ignore: cast_nullable_to_non_nullable
as List<AttributeBonus>,hpBonus: null == hpBonus ? _self.hpBonus : hpBonus // ignore: cast_nullable_to_non_nullable
as int,apBonus: null == apBonus ? _self.apBonus : apBonus // ignore: cast_nullable_to_non_nullable
as int,attackBonus: null == attackBonus ? _self.attackBonus : attackBonus // ignore: cast_nullable_to_non_nullable
as int,defenseBonus: null == defenseBonus ? _self.defenseBonus : defenseBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,evasionRateBonus: null == evasionRateBonus ? _self.evasionRateBonus : evasionRateBonus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadShape].
extension HeadShapePatterns on HeadShape {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadShape value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadShape() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadShape value)  $default,){
final _that = this;
switch (_that) {
case _HeadShape():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadShape value)?  $default,){
final _that = this;
switch (_that) {
case _HeadShape() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Map<String, int> abnormalityResistanceBonuses, @JsonKey(includeFromJson: false, includeToJson: false)  List<AttributeBonus> attributeResistanceBonuses,  int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadShape() when $default != null:
return $default(_that.id,_that.abnormalityResistanceBonuses,_that.attributeResistanceBonuses,_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Map<String, int> abnormalityResistanceBonuses, @JsonKey(includeFromJson: false, includeToJson: false)  List<AttributeBonus> attributeResistanceBonuses,  int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus)  $default,) {final _that = this;
switch (_that) {
case _HeadShape():
return $default(_that.id,_that.abnormalityResistanceBonuses,_that.attributeResistanceBonuses,_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Map<String, int> abnormalityResistanceBonuses, @JsonKey(includeFromJson: false, includeToJson: false)  List<AttributeBonus> attributeResistanceBonuses,  int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus)?  $default,) {final _that = this;
switch (_that) {
case _HeadShape() when $default != null:
return $default(_that.id,_that.abnormalityResistanceBonuses,_that.attributeResistanceBonuses,_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadShape implements HeadShape {
  const _HeadShape({required this.id, final  Map<String, int> abnormalityResistanceBonuses = const {}, @JsonKey(includeFromJson: false, includeToJson: false) final  List<AttributeBonus> attributeResistanceBonuses = const <AttributeBonus>[], this.hpBonus = 0, this.apBonus = 0, this.attackBonus = 0, this.defenseBonus = 0, this.speedBonus = 0, this.evasionRateBonus = 0}): _abnormalityResistanceBonuses = abnormalityResistanceBonuses,_attributeResistanceBonuses = attributeResistanceBonuses;
  factory _HeadShape.fromJson(Map<String, dynamic> json) => _$HeadShapeFromJson(json);

@override final  String id;
 final  Map<String, int> _abnormalityResistanceBonuses;
@override@JsonKey() Map<String, int> get abnormalityResistanceBonuses {
  if (_abnormalityResistanceBonuses is EqualUnmodifiableMapView) return _abnormalityResistanceBonuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_abnormalityResistanceBonuses);
}

 final  List<AttributeBonus> _attributeResistanceBonuses;
@override@JsonKey(includeFromJson: false, includeToJson: false) List<AttributeBonus> get attributeResistanceBonuses {
  if (_attributeResistanceBonuses is EqualUnmodifiableListView) return _attributeResistanceBonuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributeResistanceBonuses);
}

@override@JsonKey() final  int hpBonus;
@override@JsonKey() final  int apBonus;
@override@JsonKey() final  int attackBonus;
@override@JsonKey() final  int defenseBonus;
@override@JsonKey() final  int speedBonus;
@override@JsonKey() final  int evasionRateBonus;

/// Create a copy of HeadShape
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadShapeCopyWith<_HeadShape> get copyWith => __$HeadShapeCopyWithImpl<_HeadShape>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadShapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadShape&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._abnormalityResistanceBonuses, _abnormalityResistanceBonuses)&&const DeepCollectionEquality().equals(other._attributeResistanceBonuses, _attributeResistanceBonuses)&&(identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus)&&(identical(other.apBonus, apBonus) || other.apBonus == apBonus)&&(identical(other.attackBonus, attackBonus) || other.attackBonus == attackBonus)&&(identical(other.defenseBonus, defenseBonus) || other.defenseBonus == defenseBonus)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.evasionRateBonus, evasionRateBonus) || other.evasionRateBonus == evasionRateBonus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_abnormalityResistanceBonuses),const DeepCollectionEquality().hash(_attributeResistanceBonuses),hpBonus,apBonus,attackBonus,defenseBonus,speedBonus,evasionRateBonus);

@override
String toString() {
  return 'HeadShape(id: $id, abnormalityResistanceBonuses: $abnormalityResistanceBonuses, attributeResistanceBonuses: $attributeResistanceBonuses, hpBonus: $hpBonus, apBonus: $apBonus, attackBonus: $attackBonus, defenseBonus: $defenseBonus, speedBonus: $speedBonus, evasionRateBonus: $evasionRateBonus)';
}


}

/// @nodoc
abstract mixin class _$HeadShapeCopyWith<$Res> implements $HeadShapeCopyWith<$Res> {
  factory _$HeadShapeCopyWith(_HeadShape value, $Res Function(_HeadShape) _then) = __$HeadShapeCopyWithImpl;
@override @useResult
$Res call({
 String id, Map<String, int> abnormalityResistanceBonuses,@JsonKey(includeFromJson: false, includeToJson: false) List<AttributeBonus> attributeResistanceBonuses, int hpBonus, int apBonus, int attackBonus, int defenseBonus, int speedBonus, int evasionRateBonus
});




}
/// @nodoc
class __$HeadShapeCopyWithImpl<$Res>
    implements _$HeadShapeCopyWith<$Res> {
  __$HeadShapeCopyWithImpl(this._self, this._then);

  final _HeadShape _self;
  final $Res Function(_HeadShape) _then;

/// Create a copy of HeadShape
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? abnormalityResistanceBonuses = null,Object? attributeResistanceBonuses = null,Object? hpBonus = null,Object? apBonus = null,Object? attackBonus = null,Object? defenseBonus = null,Object? speedBonus = null,Object? evasionRateBonus = null,}) {
  return _then(_HeadShape(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self._abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,attributeResistanceBonuses: null == attributeResistanceBonuses ? _self._attributeResistanceBonuses : attributeResistanceBonuses // ignore: cast_nullable_to_non_nullable
as List<AttributeBonus>,hpBonus: null == hpBonus ? _self.hpBonus : hpBonus // ignore: cast_nullable_to_non_nullable
as int,apBonus: null == apBonus ? _self.apBonus : apBonus // ignore: cast_nullable_to_non_nullable
as int,attackBonus: null == attackBonus ? _self.attackBonus : attackBonus // ignore: cast_nullable_to_non_nullable
as int,defenseBonus: null == defenseBonus ? _self.defenseBonus : defenseBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,evasionRateBonus: null == evasionRateBonus ? _self.evasionRateBonus : evasionRateBonus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
