// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'abnormality_resistance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AbnormalityResistance {

 String get abnormalityId; int get value;
/// Create a copy of AbnormalityResistance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbnormalityResistanceCopyWith<AbnormalityResistance> get copyWith => _$AbnormalityResistanceCopyWithImpl<AbnormalityResistance>(this as AbnormalityResistance, _$identity);

  /// Serializes this AbnormalityResistance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbnormalityResistance&&(identical(other.abnormalityId, abnormalityId) || other.abnormalityId == abnormalityId)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,abnormalityId,value);

@override
String toString() {
  return 'AbnormalityResistance(abnormalityId: $abnormalityId, value: $value)';
}


}

/// @nodoc
abstract mixin class $AbnormalityResistanceCopyWith<$Res>  {
  factory $AbnormalityResistanceCopyWith(AbnormalityResistance value, $Res Function(AbnormalityResistance) _then) = _$AbnormalityResistanceCopyWithImpl;
@useResult
$Res call({
 String abnormalityId, int value
});




}
/// @nodoc
class _$AbnormalityResistanceCopyWithImpl<$Res>
    implements $AbnormalityResistanceCopyWith<$Res> {
  _$AbnormalityResistanceCopyWithImpl(this._self, this._then);

  final AbnormalityResistance _self;
  final $Res Function(AbnormalityResistance) _then;

/// Create a copy of AbnormalityResistance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? abnormalityId = null,Object? value = null,}) {
  return _then(_self.copyWith(
abnormalityId: null == abnormalityId ? _self.abnormalityId : abnormalityId // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AbnormalityResistance].
extension AbnormalityResistancePatterns on AbnormalityResistance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AbnormalityResistance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AbnormalityResistance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AbnormalityResistance value)  $default,){
final _that = this;
switch (_that) {
case _AbnormalityResistance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AbnormalityResistance value)?  $default,){
final _that = this;
switch (_that) {
case _AbnormalityResistance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String abnormalityId,  int value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AbnormalityResistance() when $default != null:
return $default(_that.abnormalityId,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String abnormalityId,  int value)  $default,) {final _that = this;
switch (_that) {
case _AbnormalityResistance():
return $default(_that.abnormalityId,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String abnormalityId,  int value)?  $default,) {final _that = this;
switch (_that) {
case _AbnormalityResistance() when $default != null:
return $default(_that.abnormalityId,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AbnormalityResistance implements AbnormalityResistance {
  const _AbnormalityResistance({required this.abnormalityId, required this.value});
  factory _AbnormalityResistance.fromJson(Map<String, dynamic> json) => _$AbnormalityResistanceFromJson(json);

@override final  String abnormalityId;
@override final  int value;

/// Create a copy of AbnormalityResistance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbnormalityResistanceCopyWith<_AbnormalityResistance> get copyWith => __$AbnormalityResistanceCopyWithImpl<_AbnormalityResistance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AbnormalityResistanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbnormalityResistance&&(identical(other.abnormalityId, abnormalityId) || other.abnormalityId == abnormalityId)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,abnormalityId,value);

@override
String toString() {
  return 'AbnormalityResistance(abnormalityId: $abnormalityId, value: $value)';
}


}

/// @nodoc
abstract mixin class _$AbnormalityResistanceCopyWith<$Res> implements $AbnormalityResistanceCopyWith<$Res> {
  factory _$AbnormalityResistanceCopyWith(_AbnormalityResistance value, $Res Function(_AbnormalityResistance) _then) = __$AbnormalityResistanceCopyWithImpl;
@override @useResult
$Res call({
 String abnormalityId, int value
});




}
/// @nodoc
class __$AbnormalityResistanceCopyWithImpl<$Res>
    implements _$AbnormalityResistanceCopyWith<$Res> {
  __$AbnormalityResistanceCopyWithImpl(this._self, this._then);

  final _AbnormalityResistance _self;
  final $Res Function(_AbnormalityResistance) _then;

/// Create a copy of AbnormalityResistance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? abnormalityId = null,Object? value = null,}) {
  return _then(_AbnormalityResistance(
abnormalityId: null == abnormalityId ? _self.abnormalityId : abnormalityId // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
