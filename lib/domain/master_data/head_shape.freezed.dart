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

 String get id; String get displayName; Map<String, int> get abnormalityResistanceBonuses;
/// Create a copy of HeadShape
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadShapeCopyWith<HeadShape> get copyWith => _$HeadShapeCopyWithImpl<HeadShape>(this as HeadShape, _$identity);

  /// Serializes this HeadShape to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadShape&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&const DeepCollectionEquality().equals(other.abnormalityResistanceBonuses, abnormalityResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,const DeepCollectionEquality().hash(abnormalityResistanceBonuses));

@override
String toString() {
  return 'HeadShape(id: $id, displayName: $displayName, abnormalityResistanceBonuses: $abnormalityResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class $HeadShapeCopyWith<$Res>  {
  factory $HeadShapeCopyWith(HeadShape value, $Res Function(HeadShape) _then) = _$HeadShapeCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, Map<String, int> abnormalityResistanceBonuses
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? abnormalityResistanceBonuses = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self.abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  Map<String, int> abnormalityResistanceBonuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadShape() when $default != null:
return $default(_that.id,_that.displayName,_that.abnormalityResistanceBonuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  Map<String, int> abnormalityResistanceBonuses)  $default,) {final _that = this;
switch (_that) {
case _HeadShape():
return $default(_that.id,_that.displayName,_that.abnormalityResistanceBonuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  Map<String, int> abnormalityResistanceBonuses)?  $default,) {final _that = this;
switch (_that) {
case _HeadShape() when $default != null:
return $default(_that.id,_that.displayName,_that.abnormalityResistanceBonuses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadShape implements HeadShape {
  const _HeadShape({required this.id, required this.displayName, final  Map<String, int> abnormalityResistanceBonuses = const {}}): _abnormalityResistanceBonuses = abnormalityResistanceBonuses;
  factory _HeadShape.fromJson(Map<String, dynamic> json) => _$HeadShapeFromJson(json);

@override final  String id;
@override final  String displayName;
 final  Map<String, int> _abnormalityResistanceBonuses;
@override@JsonKey() Map<String, int> get abnormalityResistanceBonuses {
  if (_abnormalityResistanceBonuses is EqualUnmodifiableMapView) return _abnormalityResistanceBonuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_abnormalityResistanceBonuses);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadShape&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&const DeepCollectionEquality().equals(other._abnormalityResistanceBonuses, _abnormalityResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,const DeepCollectionEquality().hash(_abnormalityResistanceBonuses));

@override
String toString() {
  return 'HeadShape(id: $id, displayName: $displayName, abnormalityResistanceBonuses: $abnormalityResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class _$HeadShapeCopyWith<$Res> implements $HeadShapeCopyWith<$Res> {
  factory _$HeadShapeCopyWith(_HeadShape value, $Res Function(_HeadShape) _then) = __$HeadShapeCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, Map<String, int> abnormalityResistanceBonuses
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? abnormalityResistanceBonuses = null,}) {
  return _then(_HeadShape(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self._abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
