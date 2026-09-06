// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_column_search_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueColumnSearchQuery {

 String get type; String get against; int get evasionRate; int get hp; String? get level; String? get anntenaCategory; String? get antenna;
/// Create a copy of PhysiqueColumnSearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueColumnSearchQueryCopyWith<PhysiqueColumnSearchQuery> get copyWith => _$PhysiqueColumnSearchQueryCopyWithImpl<PhysiqueColumnSearchQuery>(this as PhysiqueColumnSearchQuery, _$identity);

  /// Serializes this PhysiqueColumnSearchQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueColumnSearchQuery&&(identical(other.type, type) || other.type == type)&&(identical(other.against, against) || other.against == against)&&(identical(other.evasionRate, evasionRate) || other.evasionRate == evasionRate)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.antenna, antenna) || other.antenna == antenna));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,against,evasionRate,hp,level,anntenaCategory,antenna);

@override
String toString() {
  return 'PhysiqueColumnSearchQuery(type: $type, against: $against, evasionRate: $evasionRate, hp: $hp, level: $level, anntenaCategory: $anntenaCategory, antenna: $antenna)';
}


}

/// @nodoc
abstract mixin class $PhysiqueColumnSearchQueryCopyWith<$Res>  {
  factory $PhysiqueColumnSearchQueryCopyWith(PhysiqueColumnSearchQuery value, $Res Function(PhysiqueColumnSearchQuery) _then) = _$PhysiqueColumnSearchQueryCopyWithImpl;
@useResult
$Res call({
 String type, String against, int evasionRate, int hp, String? level, String? anntenaCategory, String? antenna
});




}
/// @nodoc
class _$PhysiqueColumnSearchQueryCopyWithImpl<$Res>
    implements $PhysiqueColumnSearchQueryCopyWith<$Res> {
  _$PhysiqueColumnSearchQueryCopyWithImpl(this._self, this._then);

  final PhysiqueColumnSearchQuery _self;
  final $Res Function(PhysiqueColumnSearchQuery) _then;

/// Create a copy of PhysiqueColumnSearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? against = null,Object? evasionRate = null,Object? hp = null,Object? level = freezed,Object? anntenaCategory = freezed,Object? antenna = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,against: null == against ? _self.against : against // ignore: cast_nullable_to_non_nullable
as String,evasionRate: null == evasionRate ? _self.evasionRate : evasionRate // ignore: cast_nullable_to_non_nullable
as int,hp: null == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,anntenaCategory: freezed == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String?,antenna: freezed == antenna ? _self.antenna : antenna // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueColumnSearchQuery].
extension PhysiqueColumnSearchQueryPatterns on PhysiqueColumnSearchQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueColumnSearchQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueColumnSearchQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueColumnSearchQuery value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueColumnSearchQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueColumnSearchQuery value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueColumnSearchQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String against,  int evasionRate,  int hp,  String? level,  String? anntenaCategory,  String? antenna)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueColumnSearchQuery() when $default != null:
return $default(_that.type,_that.against,_that.evasionRate,_that.hp,_that.level,_that.anntenaCategory,_that.antenna);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String against,  int evasionRate,  int hp,  String? level,  String? anntenaCategory,  String? antenna)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueColumnSearchQuery():
return $default(_that.type,_that.against,_that.evasionRate,_that.hp,_that.level,_that.anntenaCategory,_that.antenna);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String against,  int evasionRate,  int hp,  String? level,  String? anntenaCategory,  String? antenna)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueColumnSearchQuery() when $default != null:
return $default(_that.type,_that.against,_that.evasionRate,_that.hp,_that.level,_that.anntenaCategory,_that.antenna);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueColumnSearchQuery implements PhysiqueColumnSearchQuery {
  const _PhysiqueColumnSearchQuery({required this.type, required this.against, required this.evasionRate, required this.hp, this.level, this.anntenaCategory, this.antenna});
  factory _PhysiqueColumnSearchQuery.fromJson(Map<String, dynamic> json) => _$PhysiqueColumnSearchQueryFromJson(json);

@override final  String type;
@override final  String against;
@override final  int evasionRate;
@override final  int hp;
@override final  String? level;
@override final  String? anntenaCategory;
@override final  String? antenna;

/// Create a copy of PhysiqueColumnSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueColumnSearchQueryCopyWith<_PhysiqueColumnSearchQuery> get copyWith => __$PhysiqueColumnSearchQueryCopyWithImpl<_PhysiqueColumnSearchQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueColumnSearchQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueColumnSearchQuery&&(identical(other.type, type) || other.type == type)&&(identical(other.against, against) || other.against == against)&&(identical(other.evasionRate, evasionRate) || other.evasionRate == evasionRate)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.antenna, antenna) || other.antenna == antenna));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,against,evasionRate,hp,level,anntenaCategory,antenna);

@override
String toString() {
  return 'PhysiqueColumnSearchQuery(type: $type, against: $against, evasionRate: $evasionRate, hp: $hp, level: $level, anntenaCategory: $anntenaCategory, antenna: $antenna)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueColumnSearchQueryCopyWith<$Res> implements $PhysiqueColumnSearchQueryCopyWith<$Res> {
  factory _$PhysiqueColumnSearchQueryCopyWith(_PhysiqueColumnSearchQuery value, $Res Function(_PhysiqueColumnSearchQuery) _then) = __$PhysiqueColumnSearchQueryCopyWithImpl;
@override @useResult
$Res call({
 String type, String against, int evasionRate, int hp, String? level, String? anntenaCategory, String? antenna
});




}
/// @nodoc
class __$PhysiqueColumnSearchQueryCopyWithImpl<$Res>
    implements _$PhysiqueColumnSearchQueryCopyWith<$Res> {
  __$PhysiqueColumnSearchQueryCopyWithImpl(this._self, this._then);

  final _PhysiqueColumnSearchQuery _self;
  final $Res Function(_PhysiqueColumnSearchQuery) _then;

/// Create a copy of PhysiqueColumnSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? against = null,Object? evasionRate = null,Object? hp = null,Object? level = freezed,Object? anntenaCategory = freezed,Object? antenna = freezed,}) {
  return _then(_PhysiqueColumnSearchQuery(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,against: null == against ? _self.against : against // ignore: cast_nullable_to_non_nullable
as String,evasionRate: null == evasionRate ? _self.evasionRate : evasionRate // ignore: cast_nullable_to_non_nullable
as int,hp: null == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,anntenaCategory: freezed == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String?,antenna: freezed == antenna ? _self.antenna : antenna // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
