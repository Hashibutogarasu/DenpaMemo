// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denpa_men_search_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DenpaMenSearchQuery {

 String get name; String? get headShapeId; List<String> get bodyColors; bool? get isSpColor; String? get antennaId; int? get minAntennaLevel; String get memo; int? get minHp; int? get minAp; int? get minAttack; int? get minDefense; int? get minSpeed; int? get minEvasionRate;
/// Create a copy of DenpaMenSearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DenpaMenSearchQueryCopyWith<DenpaMenSearchQuery> get copyWith => _$DenpaMenSearchQueryCopyWithImpl<DenpaMenSearchQuery>(this as DenpaMenSearchQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DenpaMenSearchQuery&&(identical(other.name, name) || other.name == name)&&(identical(other.headShapeId, headShapeId) || other.headShapeId == headShapeId)&&const DeepCollectionEquality().equals(other.bodyColors, bodyColors)&&(identical(other.isSpColor, isSpColor) || other.isSpColor == isSpColor)&&(identical(other.antennaId, antennaId) || other.antennaId == antennaId)&&(identical(other.minAntennaLevel, minAntennaLevel) || other.minAntennaLevel == minAntennaLevel)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.minHp, minHp) || other.minHp == minHp)&&(identical(other.minAp, minAp) || other.minAp == minAp)&&(identical(other.minAttack, minAttack) || other.minAttack == minAttack)&&(identical(other.minDefense, minDefense) || other.minDefense == minDefense)&&(identical(other.minSpeed, minSpeed) || other.minSpeed == minSpeed)&&(identical(other.minEvasionRate, minEvasionRate) || other.minEvasionRate == minEvasionRate));
}


@override
int get hashCode => Object.hash(runtimeType,name,headShapeId,const DeepCollectionEquality().hash(bodyColors),isSpColor,antennaId,minAntennaLevel,memo,minHp,minAp,minAttack,minDefense,minSpeed,minEvasionRate);

@override
String toString() {
  return 'DenpaMenSearchQuery(name: $name, headShapeId: $headShapeId, bodyColors: $bodyColors, isSpColor: $isSpColor, antennaId: $antennaId, minAntennaLevel: $minAntennaLevel, memo: $memo, minHp: $minHp, minAp: $minAp, minAttack: $minAttack, minDefense: $minDefense, minSpeed: $minSpeed, minEvasionRate: $minEvasionRate)';
}


}

/// @nodoc
abstract mixin class $DenpaMenSearchQueryCopyWith<$Res>  {
  factory $DenpaMenSearchQueryCopyWith(DenpaMenSearchQuery value, $Res Function(DenpaMenSearchQuery) _then) = _$DenpaMenSearchQueryCopyWithImpl;
@useResult
$Res call({
 String name, String? headShapeId, List<String> bodyColors, bool? isSpColor, String? antennaId, int? minAntennaLevel, String memo, int? minHp, int? minAp, int? minAttack, int? minDefense, int? minSpeed, int? minEvasionRate
});




}
/// @nodoc
class _$DenpaMenSearchQueryCopyWithImpl<$Res>
    implements $DenpaMenSearchQueryCopyWith<$Res> {
  _$DenpaMenSearchQueryCopyWithImpl(this._self, this._then);

  final DenpaMenSearchQuery _self;
  final $Res Function(DenpaMenSearchQuery) _then;

/// Create a copy of DenpaMenSearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? headShapeId = freezed,Object? bodyColors = null,Object? isSpColor = freezed,Object? antennaId = freezed,Object? minAntennaLevel = freezed,Object? memo = null,Object? minHp = freezed,Object? minAp = freezed,Object? minAttack = freezed,Object? minDefense = freezed,Object? minSpeed = freezed,Object? minEvasionRate = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,headShapeId: freezed == headShapeId ? _self.headShapeId : headShapeId // ignore: cast_nullable_to_non_nullable
as String?,bodyColors: null == bodyColors ? _self.bodyColors : bodyColors // ignore: cast_nullable_to_non_nullable
as List<String>,isSpColor: freezed == isSpColor ? _self.isSpColor : isSpColor // ignore: cast_nullable_to_non_nullable
as bool?,antennaId: freezed == antennaId ? _self.antennaId : antennaId // ignore: cast_nullable_to_non_nullable
as String?,minAntennaLevel: freezed == minAntennaLevel ? _self.minAntennaLevel : minAntennaLevel // ignore: cast_nullable_to_non_nullable
as int?,memo: null == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String,minHp: freezed == minHp ? _self.minHp : minHp // ignore: cast_nullable_to_non_nullable
as int?,minAp: freezed == minAp ? _self.minAp : minAp // ignore: cast_nullable_to_non_nullable
as int?,minAttack: freezed == minAttack ? _self.minAttack : minAttack // ignore: cast_nullable_to_non_nullable
as int?,minDefense: freezed == minDefense ? _self.minDefense : minDefense // ignore: cast_nullable_to_non_nullable
as int?,minSpeed: freezed == minSpeed ? _self.minSpeed : minSpeed // ignore: cast_nullable_to_non_nullable
as int?,minEvasionRate: freezed == minEvasionRate ? _self.minEvasionRate : minEvasionRate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DenpaMenSearchQuery].
extension DenpaMenSearchQueryPatterns on DenpaMenSearchQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DenpaMenSearchQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DenpaMenSearchQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DenpaMenSearchQuery value)  $default,){
final _that = this;
switch (_that) {
case _DenpaMenSearchQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DenpaMenSearchQuery value)?  $default,){
final _that = this;
switch (_that) {
case _DenpaMenSearchQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? headShapeId,  List<String> bodyColors,  bool? isSpColor,  String? antennaId,  int? minAntennaLevel,  String memo,  int? minHp,  int? minAp,  int? minAttack,  int? minDefense,  int? minSpeed,  int? minEvasionRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DenpaMenSearchQuery() when $default != null:
return $default(_that.name,_that.headShapeId,_that.bodyColors,_that.isSpColor,_that.antennaId,_that.minAntennaLevel,_that.memo,_that.minHp,_that.minAp,_that.minAttack,_that.minDefense,_that.minSpeed,_that.minEvasionRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? headShapeId,  List<String> bodyColors,  bool? isSpColor,  String? antennaId,  int? minAntennaLevel,  String memo,  int? minHp,  int? minAp,  int? minAttack,  int? minDefense,  int? minSpeed,  int? minEvasionRate)  $default,) {final _that = this;
switch (_that) {
case _DenpaMenSearchQuery():
return $default(_that.name,_that.headShapeId,_that.bodyColors,_that.isSpColor,_that.antennaId,_that.minAntennaLevel,_that.memo,_that.minHp,_that.minAp,_that.minAttack,_that.minDefense,_that.minSpeed,_that.minEvasionRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? headShapeId,  List<String> bodyColors,  bool? isSpColor,  String? antennaId,  int? minAntennaLevel,  String memo,  int? minHp,  int? minAp,  int? minAttack,  int? minDefense,  int? minSpeed,  int? minEvasionRate)?  $default,) {final _that = this;
switch (_that) {
case _DenpaMenSearchQuery() when $default != null:
return $default(_that.name,_that.headShapeId,_that.bodyColors,_that.isSpColor,_that.antennaId,_that.minAntennaLevel,_that.memo,_that.minHp,_that.minAp,_that.minAttack,_that.minDefense,_that.minSpeed,_that.minEvasionRate);case _:
  return null;

}
}

}

/// @nodoc


class _DenpaMenSearchQuery extends DenpaMenSearchQuery {
  const _DenpaMenSearchQuery({this.name = '', this.headShapeId, final  List<String> bodyColors = const <String>[], this.isSpColor, this.antennaId, this.minAntennaLevel, this.memo = '', this.minHp, this.minAp, this.minAttack, this.minDefense, this.minSpeed, this.minEvasionRate}): _bodyColors = bodyColors,super._();
  

@override@JsonKey() final  String name;
@override final  String? headShapeId;
 final  List<String> _bodyColors;
@override@JsonKey() List<String> get bodyColors {
  if (_bodyColors is EqualUnmodifiableListView) return _bodyColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyColors);
}

@override final  bool? isSpColor;
@override final  String? antennaId;
@override final  int? minAntennaLevel;
@override@JsonKey() final  String memo;
@override final  int? minHp;
@override final  int? minAp;
@override final  int? minAttack;
@override final  int? minDefense;
@override final  int? minSpeed;
@override final  int? minEvasionRate;

/// Create a copy of DenpaMenSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DenpaMenSearchQueryCopyWith<_DenpaMenSearchQuery> get copyWith => __$DenpaMenSearchQueryCopyWithImpl<_DenpaMenSearchQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DenpaMenSearchQuery&&(identical(other.name, name) || other.name == name)&&(identical(other.headShapeId, headShapeId) || other.headShapeId == headShapeId)&&const DeepCollectionEquality().equals(other._bodyColors, _bodyColors)&&(identical(other.isSpColor, isSpColor) || other.isSpColor == isSpColor)&&(identical(other.antennaId, antennaId) || other.antennaId == antennaId)&&(identical(other.minAntennaLevel, minAntennaLevel) || other.minAntennaLevel == minAntennaLevel)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.minHp, minHp) || other.minHp == minHp)&&(identical(other.minAp, minAp) || other.minAp == minAp)&&(identical(other.minAttack, minAttack) || other.minAttack == minAttack)&&(identical(other.minDefense, minDefense) || other.minDefense == minDefense)&&(identical(other.minSpeed, minSpeed) || other.minSpeed == minSpeed)&&(identical(other.minEvasionRate, minEvasionRate) || other.minEvasionRate == minEvasionRate));
}


@override
int get hashCode => Object.hash(runtimeType,name,headShapeId,const DeepCollectionEquality().hash(_bodyColors),isSpColor,antennaId,minAntennaLevel,memo,minHp,minAp,minAttack,minDefense,minSpeed,minEvasionRate);

@override
String toString() {
  return 'DenpaMenSearchQuery(name: $name, headShapeId: $headShapeId, bodyColors: $bodyColors, isSpColor: $isSpColor, antennaId: $antennaId, minAntennaLevel: $minAntennaLevel, memo: $memo, minHp: $minHp, minAp: $minAp, minAttack: $minAttack, minDefense: $minDefense, minSpeed: $minSpeed, minEvasionRate: $minEvasionRate)';
}


}

/// @nodoc
abstract mixin class _$DenpaMenSearchQueryCopyWith<$Res> implements $DenpaMenSearchQueryCopyWith<$Res> {
  factory _$DenpaMenSearchQueryCopyWith(_DenpaMenSearchQuery value, $Res Function(_DenpaMenSearchQuery) _then) = __$DenpaMenSearchQueryCopyWithImpl;
@override @useResult
$Res call({
 String name, String? headShapeId, List<String> bodyColors, bool? isSpColor, String? antennaId, int? minAntennaLevel, String memo, int? minHp, int? minAp, int? minAttack, int? minDefense, int? minSpeed, int? minEvasionRate
});




}
/// @nodoc
class __$DenpaMenSearchQueryCopyWithImpl<$Res>
    implements _$DenpaMenSearchQueryCopyWith<$Res> {
  __$DenpaMenSearchQueryCopyWithImpl(this._self, this._then);

  final _DenpaMenSearchQuery _self;
  final $Res Function(_DenpaMenSearchQuery) _then;

/// Create a copy of DenpaMenSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? headShapeId = freezed,Object? bodyColors = null,Object? isSpColor = freezed,Object? antennaId = freezed,Object? minAntennaLevel = freezed,Object? memo = null,Object? minHp = freezed,Object? minAp = freezed,Object? minAttack = freezed,Object? minDefense = freezed,Object? minSpeed = freezed,Object? minEvasionRate = freezed,}) {
  return _then(_DenpaMenSearchQuery(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,headShapeId: freezed == headShapeId ? _self.headShapeId : headShapeId // ignore: cast_nullable_to_non_nullable
as String?,bodyColors: null == bodyColors ? _self._bodyColors : bodyColors // ignore: cast_nullable_to_non_nullable
as List<String>,isSpColor: freezed == isSpColor ? _self.isSpColor : isSpColor // ignore: cast_nullable_to_non_nullable
as bool?,antennaId: freezed == antennaId ? _self.antennaId : antennaId // ignore: cast_nullable_to_non_nullable
as String?,minAntennaLevel: freezed == minAntennaLevel ? _self.minAntennaLevel : minAntennaLevel // ignore: cast_nullable_to_non_nullable
as int?,memo: null == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String,minHp: freezed == minHp ? _self.minHp : minHp // ignore: cast_nullable_to_non_nullable
as int?,minAp: freezed == minAp ? _self.minAp : minAp // ignore: cast_nullable_to_non_nullable
as int?,minAttack: freezed == minAttack ? _self.minAttack : minAttack // ignore: cast_nullable_to_non_nullable
as int?,minDefense: freezed == minDefense ? _self.minDefense : minDefense // ignore: cast_nullable_to_non_nullable
as int?,minSpeed: freezed == minSpeed ? _self.minSpeed : minSpeed // ignore: cast_nullable_to_non_nullable
as int?,minEvasionRate: freezed == minEvasionRate ? _self.minEvasionRate : minEvasionRate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
