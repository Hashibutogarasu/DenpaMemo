// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anntena.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Anntena {

 String get id; String get displayName;/// Number of targets the antenna's move hits, or null if it hits every
/// opposing target instead of a fixed count.
 int? get targetCount; bool get dealsDamage;/// Attribute id (see attributes.json) of the damage this antenna deals,
/// or null if it deals no attribute-typed damage.
 String? get attackAttributeId; bool get isInheritable; String? get evolvesToId;
/// Create a copy of Anntena
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnntenaCopyWith<Anntena> get copyWith => _$AnntenaCopyWithImpl<Anntena>(this as Anntena, _$identity);

  /// Serializes this Anntena to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Anntena&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.dealsDamage, dealsDamage) || other.dealsDamage == dealsDamage)&&(identical(other.attackAttributeId, attackAttributeId) || other.attackAttributeId == attackAttributeId)&&(identical(other.isInheritable, isInheritable) || other.isInheritable == isInheritable)&&(identical(other.evolvesToId, evolvesToId) || other.evolvesToId == evolvesToId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,targetCount,dealsDamage,attackAttributeId,isInheritable,evolvesToId);

@override
String toString() {
  return 'Anntena(id: $id, displayName: $displayName, targetCount: $targetCount, dealsDamage: $dealsDamage, attackAttributeId: $attackAttributeId, isInheritable: $isInheritable, evolvesToId: $evolvesToId)';
}


}

/// @nodoc
abstract mixin class $AnntenaCopyWith<$Res>  {
  factory $AnntenaCopyWith(Anntena value, $Res Function(Anntena) _then) = _$AnntenaCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, int? targetCount, bool dealsDamage, String? attackAttributeId, bool isInheritable, String? evolvesToId
});




}
/// @nodoc
class _$AnntenaCopyWithImpl<$Res>
    implements $AnntenaCopyWith<$Res> {
  _$AnntenaCopyWithImpl(this._self, this._then);

  final Anntena _self;
  final $Res Function(Anntena) _then;

/// Create a copy of Anntena
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? targetCount = freezed,Object? dealsDamage = null,Object? attackAttributeId = freezed,Object? isInheritable = null,Object? evolvesToId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,targetCount: freezed == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int?,dealsDamage: null == dealsDamage ? _self.dealsDamage : dealsDamage // ignore: cast_nullable_to_non_nullable
as bool,attackAttributeId: freezed == attackAttributeId ? _self.attackAttributeId : attackAttributeId // ignore: cast_nullable_to_non_nullable
as String?,isInheritable: null == isInheritable ? _self.isInheritable : isInheritable // ignore: cast_nullable_to_non_nullable
as bool,evolvesToId: freezed == evolvesToId ? _self.evolvesToId : evolvesToId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Anntena].
extension AnntenaPatterns on Anntena {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Anntena value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Anntena() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Anntena value)  $default,){
final _that = this;
switch (_that) {
case _Anntena():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Anntena value)?  $default,){
final _that = this;
switch (_that) {
case _Anntena() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  int? targetCount,  bool dealsDamage,  String? attackAttributeId,  bool isInheritable,  String? evolvesToId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Anntena() when $default != null:
return $default(_that.id,_that.displayName,_that.targetCount,_that.dealsDamage,_that.attackAttributeId,_that.isInheritable,_that.evolvesToId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  int? targetCount,  bool dealsDamage,  String? attackAttributeId,  bool isInheritable,  String? evolvesToId)  $default,) {final _that = this;
switch (_that) {
case _Anntena():
return $default(_that.id,_that.displayName,_that.targetCount,_that.dealsDamage,_that.attackAttributeId,_that.isInheritable,_that.evolvesToId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  int? targetCount,  bool dealsDamage,  String? attackAttributeId,  bool isInheritable,  String? evolvesToId)?  $default,) {final _that = this;
switch (_that) {
case _Anntena() when $default != null:
return $default(_that.id,_that.displayName,_that.targetCount,_that.dealsDamage,_that.attackAttributeId,_that.isInheritable,_that.evolvesToId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Anntena implements Anntena {
  const _Anntena({required this.id, required this.displayName, this.targetCount, this.dealsDamage = false, this.attackAttributeId, this.isInheritable = false, this.evolvesToId});
  factory _Anntena.fromJson(Map<String, dynamic> json) => _$AnntenaFromJson(json);

@override final  String id;
@override final  String displayName;
/// Number of targets the antenna's move hits, or null if it hits every
/// opposing target instead of a fixed count.
@override final  int? targetCount;
@override@JsonKey() final  bool dealsDamage;
/// Attribute id (see attributes.json) of the damage this antenna deals,
/// or null if it deals no attribute-typed damage.
@override final  String? attackAttributeId;
@override@JsonKey() final  bool isInheritable;
@override final  String? evolvesToId;

/// Create a copy of Anntena
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnntenaCopyWith<_Anntena> get copyWith => __$AnntenaCopyWithImpl<_Anntena>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnntenaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Anntena&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.dealsDamage, dealsDamage) || other.dealsDamage == dealsDamage)&&(identical(other.attackAttributeId, attackAttributeId) || other.attackAttributeId == attackAttributeId)&&(identical(other.isInheritable, isInheritable) || other.isInheritable == isInheritable)&&(identical(other.evolvesToId, evolvesToId) || other.evolvesToId == evolvesToId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,targetCount,dealsDamage,attackAttributeId,isInheritable,evolvesToId);

@override
String toString() {
  return 'Anntena(id: $id, displayName: $displayName, targetCount: $targetCount, dealsDamage: $dealsDamage, attackAttributeId: $attackAttributeId, isInheritable: $isInheritable, evolvesToId: $evolvesToId)';
}


}

/// @nodoc
abstract mixin class _$AnntenaCopyWith<$Res> implements $AnntenaCopyWith<$Res> {
  factory _$AnntenaCopyWith(_Anntena value, $Res Function(_Anntena) _then) = __$AnntenaCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, int? targetCount, bool dealsDamage, String? attackAttributeId, bool isInheritable, String? evolvesToId
});




}
/// @nodoc
class __$AnntenaCopyWithImpl<$Res>
    implements _$AnntenaCopyWith<$Res> {
  __$AnntenaCopyWithImpl(this._self, this._then);

  final _Anntena _self;
  final $Res Function(_Anntena) _then;

/// Create a copy of Anntena
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? targetCount = freezed,Object? dealsDamage = null,Object? attackAttributeId = freezed,Object? isInheritable = null,Object? evolvesToId = freezed,}) {
  return _then(_Anntena(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,targetCount: freezed == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int?,dealsDamage: null == dealsDamage ? _self.dealsDamage : dealsDamage // ignore: cast_nullable_to_non_nullable
as bool,attackAttributeId: freezed == attackAttributeId ? _self.attackAttributeId : attackAttributeId // ignore: cast_nullable_to_non_nullable
as String?,isInheritable: null == isInheritable ? _self.isInheritable : isInheritable // ignore: cast_nullable_to_non_nullable
as bool,evolvesToId: freezed == evolvesToId ? _self.evolvesToId : evolvesToId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
