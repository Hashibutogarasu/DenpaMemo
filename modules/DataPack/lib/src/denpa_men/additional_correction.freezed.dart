// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'additional_correction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdditionalCorrection {

 int get hpBonus; int get apBonus; int get attackBonus; int get defenseBonus; int get speedBonus; int get evasionRateBonus; String get statBonusName; List<AttributeResistance> get attributeResistances; String get attributeResistanceName; List<AbnormalityResistance> get abnormalityResistances; String get abnormalityResistanceName;
/// Create a copy of AdditionalCorrection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalCorrectionCopyWith<AdditionalCorrection> get copyWith => _$AdditionalCorrectionCopyWithImpl<AdditionalCorrection>(this as AdditionalCorrection, _$identity);

  /// Serializes this AdditionalCorrection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalCorrection&&(identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus)&&(identical(other.apBonus, apBonus) || other.apBonus == apBonus)&&(identical(other.attackBonus, attackBonus) || other.attackBonus == attackBonus)&&(identical(other.defenseBonus, defenseBonus) || other.defenseBonus == defenseBonus)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.evasionRateBonus, evasionRateBonus) || other.evasionRateBonus == evasionRateBonus)&&(identical(other.statBonusName, statBonusName) || other.statBonusName == statBonusName)&&const DeepCollectionEquality().equals(other.attributeResistances, attributeResistances)&&(identical(other.attributeResistanceName, attributeResistanceName) || other.attributeResistanceName == attributeResistanceName)&&const DeepCollectionEquality().equals(other.abnormalityResistances, abnormalityResistances)&&(identical(other.abnormalityResistanceName, abnormalityResistanceName) || other.abnormalityResistanceName == abnormalityResistanceName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hpBonus,apBonus,attackBonus,defenseBonus,speedBonus,evasionRateBonus,statBonusName,const DeepCollectionEquality().hash(attributeResistances),attributeResistanceName,const DeepCollectionEquality().hash(abnormalityResistances),abnormalityResistanceName);

@override
String toString() {
  return 'AdditionalCorrection(hpBonus: $hpBonus, apBonus: $apBonus, attackBonus: $attackBonus, defenseBonus: $defenseBonus, speedBonus: $speedBonus, evasionRateBonus: $evasionRateBonus, statBonusName: $statBonusName, attributeResistances: $attributeResistances, attributeResistanceName: $attributeResistanceName, abnormalityResistances: $abnormalityResistances, abnormalityResistanceName: $abnormalityResistanceName)';
}


}

/// @nodoc
abstract mixin class $AdditionalCorrectionCopyWith<$Res>  {
  factory $AdditionalCorrectionCopyWith(AdditionalCorrection value, $Res Function(AdditionalCorrection) _then) = _$AdditionalCorrectionCopyWithImpl;
@useResult
$Res call({
 int hpBonus, int apBonus, int attackBonus, int defenseBonus, int speedBonus, int evasionRateBonus, String statBonusName, List<AttributeResistance> attributeResistances, String attributeResistanceName, List<AbnormalityResistance> abnormalityResistances, String abnormalityResistanceName
});




}
/// @nodoc
class _$AdditionalCorrectionCopyWithImpl<$Res>
    implements $AdditionalCorrectionCopyWith<$Res> {
  _$AdditionalCorrectionCopyWithImpl(this._self, this._then);

  final AdditionalCorrection _self;
  final $Res Function(AdditionalCorrection) _then;

/// Create a copy of AdditionalCorrection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hpBonus = null,Object? apBonus = null,Object? attackBonus = null,Object? defenseBonus = null,Object? speedBonus = null,Object? evasionRateBonus = null,Object? statBonusName = null,Object? attributeResistances = null,Object? attributeResistanceName = null,Object? abnormalityResistances = null,Object? abnormalityResistanceName = null,}) {
  return _then(_self.copyWith(
hpBonus: null == hpBonus ? _self.hpBonus : hpBonus // ignore: cast_nullable_to_non_nullable
as int,apBonus: null == apBonus ? _self.apBonus : apBonus // ignore: cast_nullable_to_non_nullable
as int,attackBonus: null == attackBonus ? _self.attackBonus : attackBonus // ignore: cast_nullable_to_non_nullable
as int,defenseBonus: null == defenseBonus ? _self.defenseBonus : defenseBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,evasionRateBonus: null == evasionRateBonus ? _self.evasionRateBonus : evasionRateBonus // ignore: cast_nullable_to_non_nullable
as int,statBonusName: null == statBonusName ? _self.statBonusName : statBonusName // ignore: cast_nullable_to_non_nullable
as String,attributeResistances: null == attributeResistances ? _self.attributeResistances : attributeResistances // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,attributeResistanceName: null == attributeResistanceName ? _self.attributeResistanceName : attributeResistanceName // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistances: null == abnormalityResistances ? _self.abnormalityResistances : abnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,abnormalityResistanceName: null == abnormalityResistanceName ? _self.abnormalityResistanceName : abnormalityResistanceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalCorrection].
extension AdditionalCorrectionPatterns on AdditionalCorrection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalCorrection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalCorrection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalCorrection value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalCorrection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalCorrection value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalCorrection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus,  String statBonusName,  List<AttributeResistance> attributeResistances,  String attributeResistanceName,  List<AbnormalityResistance> abnormalityResistances,  String abnormalityResistanceName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalCorrection() when $default != null:
return $default(_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus,_that.statBonusName,_that.attributeResistances,_that.attributeResistanceName,_that.abnormalityResistances,_that.abnormalityResistanceName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus,  String statBonusName,  List<AttributeResistance> attributeResistances,  String attributeResistanceName,  List<AbnormalityResistance> abnormalityResistances,  String abnormalityResistanceName)  $default,) {final _that = this;
switch (_that) {
case _AdditionalCorrection():
return $default(_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus,_that.statBonusName,_that.attributeResistances,_that.attributeResistanceName,_that.abnormalityResistances,_that.abnormalityResistanceName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int hpBonus,  int apBonus,  int attackBonus,  int defenseBonus,  int speedBonus,  int evasionRateBonus,  String statBonusName,  List<AttributeResistance> attributeResistances,  String attributeResistanceName,  List<AbnormalityResistance> abnormalityResistances,  String abnormalityResistanceName)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalCorrection() when $default != null:
return $default(_that.hpBonus,_that.apBonus,_that.attackBonus,_that.defenseBonus,_that.speedBonus,_that.evasionRateBonus,_that.statBonusName,_that.attributeResistances,_that.attributeResistanceName,_that.abnormalityResistances,_that.abnormalityResistanceName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalCorrection implements AdditionalCorrection {
  const _AdditionalCorrection({this.hpBonus = 0, this.apBonus = 0, this.attackBonus = 0, this.defenseBonus = 0, this.speedBonus = 0, this.evasionRateBonus = 0, this.statBonusName = '', final  List<AttributeResistance> attributeResistances = const <AttributeResistance>[], this.attributeResistanceName = '', final  List<AbnormalityResistance> abnormalityResistances = const <AbnormalityResistance>[], this.abnormalityResistanceName = ''}): _attributeResistances = attributeResistances,_abnormalityResistances = abnormalityResistances;
  factory _AdditionalCorrection.fromJson(Map<String, dynamic> json) => _$AdditionalCorrectionFromJson(json);

@override@JsonKey() final  int hpBonus;
@override@JsonKey() final  int apBonus;
@override@JsonKey() final  int attackBonus;
@override@JsonKey() final  int defenseBonus;
@override@JsonKey() final  int speedBonus;
@override@JsonKey() final  int evasionRateBonus;
@override@JsonKey() final  String statBonusName;
 final  List<AttributeResistance> _attributeResistances;
@override@JsonKey() List<AttributeResistance> get attributeResistances {
  if (_attributeResistances is EqualUnmodifiableListView) return _attributeResistances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributeResistances);
}

@override@JsonKey() final  String attributeResistanceName;
 final  List<AbnormalityResistance> _abnormalityResistances;
@override@JsonKey() List<AbnormalityResistance> get abnormalityResistances {
  if (_abnormalityResistances is EqualUnmodifiableListView) return _abnormalityResistances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abnormalityResistances);
}

@override@JsonKey() final  String abnormalityResistanceName;

/// Create a copy of AdditionalCorrection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalCorrectionCopyWith<_AdditionalCorrection> get copyWith => __$AdditionalCorrectionCopyWithImpl<_AdditionalCorrection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalCorrectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalCorrection&&(identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus)&&(identical(other.apBonus, apBonus) || other.apBonus == apBonus)&&(identical(other.attackBonus, attackBonus) || other.attackBonus == attackBonus)&&(identical(other.defenseBonus, defenseBonus) || other.defenseBonus == defenseBonus)&&(identical(other.speedBonus, speedBonus) || other.speedBonus == speedBonus)&&(identical(other.evasionRateBonus, evasionRateBonus) || other.evasionRateBonus == evasionRateBonus)&&(identical(other.statBonusName, statBonusName) || other.statBonusName == statBonusName)&&const DeepCollectionEquality().equals(other._attributeResistances, _attributeResistances)&&(identical(other.attributeResistanceName, attributeResistanceName) || other.attributeResistanceName == attributeResistanceName)&&const DeepCollectionEquality().equals(other._abnormalityResistances, _abnormalityResistances)&&(identical(other.abnormalityResistanceName, abnormalityResistanceName) || other.abnormalityResistanceName == abnormalityResistanceName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hpBonus,apBonus,attackBonus,defenseBonus,speedBonus,evasionRateBonus,statBonusName,const DeepCollectionEquality().hash(_attributeResistances),attributeResistanceName,const DeepCollectionEquality().hash(_abnormalityResistances),abnormalityResistanceName);

@override
String toString() {
  return 'AdditionalCorrection(hpBonus: $hpBonus, apBonus: $apBonus, attackBonus: $attackBonus, defenseBonus: $defenseBonus, speedBonus: $speedBonus, evasionRateBonus: $evasionRateBonus, statBonusName: $statBonusName, attributeResistances: $attributeResistances, attributeResistanceName: $attributeResistanceName, abnormalityResistances: $abnormalityResistances, abnormalityResistanceName: $abnormalityResistanceName)';
}


}

/// @nodoc
abstract mixin class _$AdditionalCorrectionCopyWith<$Res> implements $AdditionalCorrectionCopyWith<$Res> {
  factory _$AdditionalCorrectionCopyWith(_AdditionalCorrection value, $Res Function(_AdditionalCorrection) _then) = __$AdditionalCorrectionCopyWithImpl;
@override @useResult
$Res call({
 int hpBonus, int apBonus, int attackBonus, int defenseBonus, int speedBonus, int evasionRateBonus, String statBonusName, List<AttributeResistance> attributeResistances, String attributeResistanceName, List<AbnormalityResistance> abnormalityResistances, String abnormalityResistanceName
});




}
/// @nodoc
class __$AdditionalCorrectionCopyWithImpl<$Res>
    implements _$AdditionalCorrectionCopyWith<$Res> {
  __$AdditionalCorrectionCopyWithImpl(this._self, this._then);

  final _AdditionalCorrection _self;
  final $Res Function(_AdditionalCorrection) _then;

/// Create a copy of AdditionalCorrection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hpBonus = null,Object? apBonus = null,Object? attackBonus = null,Object? defenseBonus = null,Object? speedBonus = null,Object? evasionRateBonus = null,Object? statBonusName = null,Object? attributeResistances = null,Object? attributeResistanceName = null,Object? abnormalityResistances = null,Object? abnormalityResistanceName = null,}) {
  return _then(_AdditionalCorrection(
hpBonus: null == hpBonus ? _self.hpBonus : hpBonus // ignore: cast_nullable_to_non_nullable
as int,apBonus: null == apBonus ? _self.apBonus : apBonus // ignore: cast_nullable_to_non_nullable
as int,attackBonus: null == attackBonus ? _self.attackBonus : attackBonus // ignore: cast_nullable_to_non_nullable
as int,defenseBonus: null == defenseBonus ? _self.defenseBonus : defenseBonus // ignore: cast_nullable_to_non_nullable
as int,speedBonus: null == speedBonus ? _self.speedBonus : speedBonus // ignore: cast_nullable_to_non_nullable
as int,evasionRateBonus: null == evasionRateBonus ? _self.evasionRateBonus : evasionRateBonus // ignore: cast_nullable_to_non_nullable
as int,statBonusName: null == statBonusName ? _self.statBonusName : statBonusName // ignore: cast_nullable_to_non_nullable
as String,attributeResistances: null == attributeResistances ? _self._attributeResistances : attributeResistances // ignore: cast_nullable_to_non_nullable
as List<AttributeResistance>,attributeResistanceName: null == attributeResistanceName ? _self.attributeResistanceName : attributeResistanceName // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistances: null == abnormalityResistances ? _self._abnormalityResistances : abnormalityResistances // ignore: cast_nullable_to_non_nullable
as List<AbnormalityResistance>,abnormalityResistanceName: null == abnormalityResistanceName ? _self.abnormalityResistanceName : abnormalityResistanceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
