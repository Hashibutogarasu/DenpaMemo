// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clipping_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClippingSlot {

 DenpaMenImageSlotType get slotType; String get name; int get priority; double get left; double get top; double get right; double get bottom;
/// Create a copy of ClippingSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClippingSlotCopyWith<ClippingSlot> get copyWith => _$ClippingSlotCopyWithImpl<ClippingSlot>(this as ClippingSlot, _$identity);

  /// Serializes this ClippingSlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClippingSlot&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.name, name) || other.name == name)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.left, left) || other.left == left)&&(identical(other.top, top) || other.top == top)&&(identical(other.right, right) || other.right == right)&&(identical(other.bottom, bottom) || other.bottom == bottom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotType,name,priority,left,top,right,bottom);

@override
String toString() {
  return 'ClippingSlot(slotType: $slotType, name: $name, priority: $priority, left: $left, top: $top, right: $right, bottom: $bottom)';
}


}

/// @nodoc
abstract mixin class $ClippingSlotCopyWith<$Res>  {
  factory $ClippingSlotCopyWith(ClippingSlot value, $Res Function(ClippingSlot) _then) = _$ClippingSlotCopyWithImpl;
@useResult
$Res call({
 DenpaMenImageSlotType slotType, String name, int priority, double left, double top, double right, double bottom
});




}
/// @nodoc
class _$ClippingSlotCopyWithImpl<$Res>
    implements $ClippingSlotCopyWith<$Res> {
  _$ClippingSlotCopyWithImpl(this._self, this._then);

  final ClippingSlot _self;
  final $Res Function(ClippingSlot) _then;

/// Create a copy of ClippingSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotType = null,Object? name = null,Object? priority = null,Object? left = null,Object? top = null,Object? right = null,Object? bottom = null,}) {
  return _then(_self.copyWith(
slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as DenpaMenImageSlotType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ClippingSlot].
extension ClippingSlotPatterns on ClippingSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClippingSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClippingSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClippingSlot value)  $default,){
final _that = this;
switch (_that) {
case _ClippingSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClippingSlot value)?  $default,){
final _that = this;
switch (_that) {
case _ClippingSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DenpaMenImageSlotType slotType,  String name,  int priority,  double left,  double top,  double right,  double bottom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClippingSlot() when $default != null:
return $default(_that.slotType,_that.name,_that.priority,_that.left,_that.top,_that.right,_that.bottom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DenpaMenImageSlotType slotType,  String name,  int priority,  double left,  double top,  double right,  double bottom)  $default,) {final _that = this;
switch (_that) {
case _ClippingSlot():
return $default(_that.slotType,_that.name,_that.priority,_that.left,_that.top,_that.right,_that.bottom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DenpaMenImageSlotType slotType,  String name,  int priority,  double left,  double top,  double right,  double bottom)?  $default,) {final _that = this;
switch (_that) {
case _ClippingSlot() when $default != null:
return $default(_that.slotType,_that.name,_that.priority,_that.left,_that.top,_that.right,_that.bottom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClippingSlot extends ClippingSlot {
  const _ClippingSlot({required this.slotType, required this.name, required this.priority, required this.left, required this.top, required this.right, required this.bottom}): super._();
  factory _ClippingSlot.fromJson(Map<String, dynamic> json) => _$ClippingSlotFromJson(json);

@override final  DenpaMenImageSlotType slotType;
@override final  String name;
@override final  int priority;
@override final  double left;
@override final  double top;
@override final  double right;
@override final  double bottom;

/// Create a copy of ClippingSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClippingSlotCopyWith<_ClippingSlot> get copyWith => __$ClippingSlotCopyWithImpl<_ClippingSlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClippingSlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClippingSlot&&(identical(other.slotType, slotType) || other.slotType == slotType)&&(identical(other.name, name) || other.name == name)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.left, left) || other.left == left)&&(identical(other.top, top) || other.top == top)&&(identical(other.right, right) || other.right == right)&&(identical(other.bottom, bottom) || other.bottom == bottom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotType,name,priority,left,top,right,bottom);

@override
String toString() {
  return 'ClippingSlot(slotType: $slotType, name: $name, priority: $priority, left: $left, top: $top, right: $right, bottom: $bottom)';
}


}

/// @nodoc
abstract mixin class _$ClippingSlotCopyWith<$Res> implements $ClippingSlotCopyWith<$Res> {
  factory _$ClippingSlotCopyWith(_ClippingSlot value, $Res Function(_ClippingSlot) _then) = __$ClippingSlotCopyWithImpl;
@override @useResult
$Res call({
 DenpaMenImageSlotType slotType, String name, int priority, double left, double top, double right, double bottom
});




}
/// @nodoc
class __$ClippingSlotCopyWithImpl<$Res>
    implements _$ClippingSlotCopyWith<$Res> {
  __$ClippingSlotCopyWithImpl(this._self, this._then);

  final _ClippingSlot _self;
  final $Res Function(_ClippingSlot) _then;

/// Create a copy of ClippingSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotType = null,Object? name = null,Object? priority = null,Object? left = null,Object? top = null,Object? right = null,Object? bottom = null,}) {
  return _then(_ClippingSlot(
slotType: null == slotType ? _self.slotType : slotType // ignore: cast_nullable_to_non_nullable
as DenpaMenImageSlotType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
