// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'abnormality_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AbnormalityType {

 String get id;
/// Create a copy of AbnormalityType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbnormalityTypeCopyWith<AbnormalityType> get copyWith => _$AbnormalityTypeCopyWithImpl<AbnormalityType>(this as AbnormalityType, _$identity);

  /// Serializes this AbnormalityType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbnormalityType&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'AbnormalityType(id: $id)';
}


}

/// @nodoc
abstract mixin class $AbnormalityTypeCopyWith<$Res>  {
  factory $AbnormalityTypeCopyWith(AbnormalityType value, $Res Function(AbnormalityType) _then) = _$AbnormalityTypeCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$AbnormalityTypeCopyWithImpl<$Res>
    implements $AbnormalityTypeCopyWith<$Res> {
  _$AbnormalityTypeCopyWithImpl(this._self, this._then);

  final AbnormalityType _self;
  final $Res Function(AbnormalityType) _then;

/// Create a copy of AbnormalityType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AbnormalityType].
extension AbnormalityTypePatterns on AbnormalityType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AbnormalityType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AbnormalityType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AbnormalityType value)  $default,){
final _that = this;
switch (_that) {
case _AbnormalityType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AbnormalityType value)?  $default,){
final _that = this;
switch (_that) {
case _AbnormalityType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AbnormalityType() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _AbnormalityType():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _AbnormalityType() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AbnormalityType implements AbnormalityType {
  const _AbnormalityType({required this.id});
  factory _AbnormalityType.fromJson(Map<String, dynamic> json) => _$AbnormalityTypeFromJson(json);

@override final  String id;

/// Create a copy of AbnormalityType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbnormalityTypeCopyWith<_AbnormalityType> get copyWith => __$AbnormalityTypeCopyWithImpl<_AbnormalityType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AbnormalityTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbnormalityType&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'AbnormalityType(id: $id)';
}


}

/// @nodoc
abstract mixin class _$AbnormalityTypeCopyWith<$Res> implements $AbnormalityTypeCopyWith<$Res> {
  factory _$AbnormalityTypeCopyWith(_AbnormalityType value, $Res Function(_AbnormalityType) _then) = __$AbnormalityTypeCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$AbnormalityTypeCopyWithImpl<$Res>
    implements _$AbnormalityTypeCopyWith<$Res> {
  __$AbnormalityTypeCopyWithImpl(this._self, this._then);

  final _AbnormalityType _self;
  final $Res Function(_AbnormalityType) _then;

/// Create a copy of AbnormalityType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_AbnormalityType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
