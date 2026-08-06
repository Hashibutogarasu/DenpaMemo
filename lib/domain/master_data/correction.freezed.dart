// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'correction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Correction {

 String get id; int get hpBonus; int get apBonus; int get attackBonus; int get defenseBonus; int get speedBonus; int get evasionRateBonus; Map<String, int> get abnormalityResistanceBonuses;
/// Create a copy of Correction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CorrectionCopyWith<Correction> get copyWith => _$CorrectionCopyWithImpl<Correction>(this as Correction, _$identity);

  /// Serializes this Correction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Correction&&(identical(other.id, id) || other.id == id)&&(identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus)&&(identical(other.apBonus, apBonus) || other.apBonus == apBonus)&&(identical(other.attackBonus, attackBonus) || other.attackBonus == attackBonus)&&(identical(other.defenseBonus, defenseBonus) || other.defenseBonus == defenseBonus)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.evasionRateBonus, evasionRateBonus) || other.evasionRateBonus == evasionRateBonus)&&const DeepCollectionEquality().equals(other.abnormalityResistanceBonuses, abnormalityResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hpBonus,apBonus,attackBonus,defenseBonus,speedBonus,evasionRateBonus,const DeepCollectionEquality().hash(abnormalityResistanceBonuses));

@override
String toString() {
  return 'Correction(id: $id, hpBonus: $hpBonus, apBonus: $apBonus, attackBonus: $attackBonus, defenseBonus: $defenseBonus, speedBonus: $speedBonus, evasionRateBonus: $evasionRateBonus, abnormalityResistanceBonuses: $abnormalityResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class $CorrectionCopyWith<$Res>  {
  factory $CorrectionCopyWith(Correction value, $Res Function(Correction) _then) = _$CorrectionCopyWithImpl;
@useResult
$Res call({
 String id, int hpBonus, int apBonus, int attackBonus, int defenseBonus, int speedBonus, int evasionRateBonus, Map<String, int> abnormalityResistanceBonuses
});




}
/// @nodoc
class _$CorrectionCopyWithImpl<$Res>
    implements $CorrectionCopyWith<$Res> {
  _$CorrectionCopyWithImpl(this._self, this._then);

  final Correction _self;
  final $Res Function(Correction) _then;

/// Create a copy of Correction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hpBonus = null,Object? apBonus = null,Object? attackBonus = null,Object? defenseBonus = null,Object? speedBonus = null,Object? evasionRateBonus = null,Object? abnormalityResistanceBonuses = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hpBonus: null == hpBonus ? _self.hpBonus : hpBonus // ignore: cast_nullable_to_non_nullable
as int,apBonus: null == apBonus ? _self.apBonus : apBonus // ignore: cast_nullable_to_non_nullable
as int,attackBonus: null == attackBonus ? _self.attackBonus : attackBonus // ignore: cast_nullable_to_non_nullable
as int,defenseBonus: null == defenseBonus ? _self.defenseBonus : defenseBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,evasionRateBonus: null == evasionRateBonus ? _self.evasionRateBonus : evasionRateBonus // ignore: cast_nullable_to_non_nullable
as int,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self.abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [Correction].
extension CorrectionPatterns on Correction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Correction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Correction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Correction value)  $default,){
final _that = this;
switch (_that) {
case _Correction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Correction value)?  $default,){
final _that = this;
switch (_that) {
case _Correction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus,  Map<String, int> abnormalityResistanceBonuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Correction() when $default != null:
return $default(_that.id,_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus,_that.abnormalityResistanceBonuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus,  Map<String, int> abnormalityResistanceBonuses)  $default,) {final _that = this;
switch (_that) {
case _Correction():
return $default(_that.id,_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus,_that.abnormalityResistanceBonuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus,  Map<String, int> abnormalityResistanceBonuses)?  $default,) {final _that = this;
switch (_that) {
case _Correction() when $default != null:
return $default(_that.id,_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus,_that.abnormalityResistanceBonuses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Correction implements Correction {
  const _Correction({required this.id, this.hpBonus = 0, this.apBonus = 0, this.attackBonus = 0, this.defenseBonus = 0, this.speedBonus = 0, this.evasionRateBonus = 0, final  Map<String, int> abnormalityResistanceBonuses = const {}}): _abnormalityResistanceBonuses = abnormalityResistanceBonuses;
  factory _Correction.fromJson(Map<String, dynamic> json) => _$CorrectionFromJson(json);

@override final  String id;
@override@JsonKey() final  int hpBonus;
@override@JsonKey() final  int apBonus;
@override@JsonKey() final  int attackBonus;
@override@JsonKey() final  int defenseBonus;
@override@JsonKey() final  int speedBonus;
@override@JsonKey() final  int evasionRateBonus;
 final  Map<String, int> _abnormalityResistanceBonuses;
@override@JsonKey() Map<String, int> get abnormalityResistanceBonuses {
  if (_abnormalityResistanceBonuses is EqualUnmodifiableMapView) return _abnormalityResistanceBonuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_abnormalityResistanceBonuses);
}


/// Create a copy of Correction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CorrectionCopyWith<_Correction> get copyWith => __$CorrectionCopyWithImpl<_Correction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CorrectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Correction&&(identical(other.id, id) || other.id == id)&&(identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus)&&(identical(other.apBonus, apBonus) || other.apBonus == apBonus)&&(identical(other.attackBonus, attackBonus) || other.attackBonus == attackBonus)&&(identical(other.defenseBonus, defenseBonus) || other.defenseBonus == defenseBonus)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.evasionRateBonus, evasionRateBonus) || other.evasionRateBonus == evasionRateBonus)&&const DeepCollectionEquality().equals(other._abnormalityResistanceBonuses, _abnormalityResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hpBonus,apBonus,attackBonus,defenseBonus,speedBonus,evasionRateBonus,const DeepCollectionEquality().hash(_abnormalityResistanceBonuses));

@override
String toString() {
  return 'Correction(id: $id, hpBonus: $hpBonus, apBonus: $apBonus, attackBonus: $attackBonus, defenseBonus: $defenseBonus, speedBonus: $speedBonus, evasionRateBonus: $evasionRateBonus, abnormalityResistanceBonuses: $abnormalityResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class _$CorrectionCopyWith<$Res> implements $CorrectionCopyWith<$Res> {
  factory _$CorrectionCopyWith(_Correction value, $Res Function(_Correction) _then) = __$CorrectionCopyWithImpl;
@override @useResult
$Res call({
 String id, int hpBonus, int apBonus, int attackBonus, int defenseBonus, int speedBonus, int evasionRateBonus, Map<String, int> abnormalityResistanceBonuses
});




}
/// @nodoc
class __$CorrectionCopyWithImpl<$Res>
    implements _$CorrectionCopyWith<$Res> {
  __$CorrectionCopyWithImpl(this._self, this._then);

  final _Correction _self;
  final $Res Function(_Correction) _then;

/// Create a copy of Correction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hpBonus = null,Object? apBonus = null,Object? attackBonus = null,Object? defenseBonus = null,Object? speedBonus = null,Object? evasionRateBonus = null,Object? abnormalityResistanceBonuses = null,}) {
  return _then(_Correction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hpBonus: null == hpBonus ? _self.hpBonus : hpBonus // ignore: cast_nullable_to_non_nullable
as int,apBonus: null == apBonus ? _self.apBonus : apBonus // ignore: cast_nullable_to_non_nullable
as int,attackBonus: null == attackBonus ? _self.attackBonus : attackBonus // ignore: cast_nullable_to_non_nullable
as int,defenseBonus: null == defenseBonus ? _self.defenseBonus : defenseBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,evasionRateBonus: null == evasionRateBonus ? _self.evasionRateBonus : evasionRateBonus // ignore: cast_nullable_to_non_nullable
as int,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self._abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
