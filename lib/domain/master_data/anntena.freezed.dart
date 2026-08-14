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

 String get id; AnntenaCategory get category; int? get targetCount; bool get targetsAll; bool get dealsDamage; List<Attribute> get attackAttributes; bool get isInheritable; String? get evolvesToId; int? get maxLevel; String? get variantGroupId; bool get hasLevel;
/// Create a copy of Anntena
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnntenaCopyWith<Anntena> get copyWith => _$AnntenaCopyWithImpl<Anntena>(this as Anntena, _$identity);

  /// Serializes this Anntena to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Anntena&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.targetsAll, targetsAll) || other.targetsAll == targetsAll)&&(identical(other.dealsDamage, dealsDamage) || other.dealsDamage == dealsDamage)&&const DeepCollectionEquality().equals(other.attackAttributes, attackAttributes)&&(identical(other.isInheritable, isInheritable) || other.isInheritable == isInheritable)&&(identical(other.evolvesToId, evolvesToId) || other.evolvesToId == evolvesToId)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.variantGroupId, variantGroupId) || other.variantGroupId == variantGroupId)&&(identical(other.hasLevel, hasLevel) || other.hasLevel == hasLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,targetCount,targetsAll,dealsDamage,const DeepCollectionEquality().hash(attackAttributes),isInheritable,evolvesToId,maxLevel,variantGroupId,hasLevel);

@override
String toString() {
  return 'Anntena(id: $id, category: $category, targetCount: $targetCount, targetsAll: $targetsAll, dealsDamage: $dealsDamage, attackAttributes: $attackAttributes, isInheritable: $isInheritable, evolvesToId: $evolvesToId, maxLevel: $maxLevel, variantGroupId: $variantGroupId, hasLevel: $hasLevel)';
}


}

/// @nodoc
abstract mixin class $AnntenaCopyWith<$Res>  {
  factory $AnntenaCopyWith(Anntena value, $Res Function(Anntena) _then) = _$AnntenaCopyWithImpl;
@useResult
$Res call({
 String id, AnntenaCategory category, int? targetCount, bool targetsAll, bool dealsDamage, List<Attribute> attackAttributes, bool isInheritable, String? evolvesToId, int? maxLevel, String? variantGroupId, bool hasLevel
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? targetCount = freezed,Object? targetsAll = null,Object? dealsDamage = null,Object? attackAttributes = null,Object? isInheritable = null,Object? evolvesToId = freezed,Object? maxLevel = freezed,Object? variantGroupId = freezed,Object? hasLevel = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AnntenaCategory,targetCount: freezed == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int?,targetsAll: null == targetsAll ? _self.targetsAll : targetsAll // ignore: cast_nullable_to_non_nullable
as bool,dealsDamage: null == dealsDamage ? _self.dealsDamage : dealsDamage // ignore: cast_nullable_to_non_nullable
as bool,attackAttributes: null == attackAttributes ? _self.attackAttributes : attackAttributes // ignore: cast_nullable_to_non_nullable
as List<Attribute>,isInheritable: null == isInheritable ? _self.isInheritable : isInheritable // ignore: cast_nullable_to_non_nullable
as bool,evolvesToId: freezed == evolvesToId ? _self.evolvesToId : evolvesToId // ignore: cast_nullable_to_non_nullable
as String?,maxLevel: freezed == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int?,variantGroupId: freezed == variantGroupId ? _self.variantGroupId : variantGroupId // ignore: cast_nullable_to_non_nullable
as String?,hasLevel: null == hasLevel ? _self.hasLevel : hasLevel // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  AnntenaCategory category,  int? targetCount,  bool targetsAll,  bool dealsDamage,  List<Attribute> attackAttributes,  bool isInheritable,  String? evolvesToId,  int? maxLevel,  String? variantGroupId,  bool hasLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Anntena() when $default != null:
return $default(_that.id,_that.category,_that.targetCount,_that.targetsAll,_that.dealsDamage,_that.attackAttributes,_that.isInheritable,_that.evolvesToId,_that.maxLevel,_that.variantGroupId,_that.hasLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  AnntenaCategory category,  int? targetCount,  bool targetsAll,  bool dealsDamage,  List<Attribute> attackAttributes,  bool isInheritable,  String? evolvesToId,  int? maxLevel,  String? variantGroupId,  bool hasLevel)  $default,) {final _that = this;
switch (_that) {
case _Anntena():
return $default(_that.id,_that.category,_that.targetCount,_that.targetsAll,_that.dealsDamage,_that.attackAttributes,_that.isInheritable,_that.evolvesToId,_that.maxLevel,_that.variantGroupId,_that.hasLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  AnntenaCategory category,  int? targetCount,  bool targetsAll,  bool dealsDamage,  List<Attribute> attackAttributes,  bool isInheritable,  String? evolvesToId,  int? maxLevel,  String? variantGroupId,  bool hasLevel)?  $default,) {final _that = this;
switch (_that) {
case _Anntena() when $default != null:
return $default(_that.id,_that.category,_that.targetCount,_that.targetsAll,_that.dealsDamage,_that.attackAttributes,_that.isInheritable,_that.evolvesToId,_that.maxLevel,_that.variantGroupId,_that.hasLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Anntena implements Anntena {
  const _Anntena({required this.id, required this.category, this.targetCount, this.targetsAll = false, this.dealsDamage = false, final  List<Attribute> attackAttributes = const <Attribute>[], this.isInheritable = false, this.evolvesToId, this.maxLevel, this.variantGroupId, this.hasLevel = true}): _attackAttributes = attackAttributes;
  factory _Anntena.fromJson(Map<String, dynamic> json) => _$AnntenaFromJson(json);

@override final  String id;
@override final  AnntenaCategory category;
@override final  int? targetCount;
@override@JsonKey() final  bool targetsAll;
@override@JsonKey() final  bool dealsDamage;
 final  List<Attribute> _attackAttributes;
@override@JsonKey() List<Attribute> get attackAttributes {
  if (_attackAttributes is EqualUnmodifiableListView) return _attackAttributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attackAttributes);
}

@override@JsonKey() final  bool isInheritable;
@override final  String? evolvesToId;
@override final  int? maxLevel;
@override final  String? variantGroupId;
@override@JsonKey() final  bool hasLevel;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Anntena&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.targetsAll, targetsAll) || other.targetsAll == targetsAll)&&(identical(other.dealsDamage, dealsDamage) || other.dealsDamage == dealsDamage)&&const DeepCollectionEquality().equals(other._attackAttributes, _attackAttributes)&&(identical(other.isInheritable, isInheritable) || other.isInheritable == isInheritable)&&(identical(other.evolvesToId, evolvesToId) || other.evolvesToId == evolvesToId)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel)&&(identical(other.variantGroupId, variantGroupId) || other.variantGroupId == variantGroupId)&&(identical(other.hasLevel, hasLevel) || other.hasLevel == hasLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,targetCount,targetsAll,dealsDamage,const DeepCollectionEquality().hash(_attackAttributes),isInheritable,evolvesToId,maxLevel,variantGroupId,hasLevel);

@override
String toString() {
  return 'Anntena(id: $id, category: $category, targetCount: $targetCount, targetsAll: $targetsAll, dealsDamage: $dealsDamage, attackAttributes: $attackAttributes, isInheritable: $isInheritable, evolvesToId: $evolvesToId, maxLevel: $maxLevel, variantGroupId: $variantGroupId, hasLevel: $hasLevel)';
}


}

/// @nodoc
abstract mixin class _$AnntenaCopyWith<$Res> implements $AnntenaCopyWith<$Res> {
  factory _$AnntenaCopyWith(_Anntena value, $Res Function(_Anntena) _then) = __$AnntenaCopyWithImpl;
@override @useResult
$Res call({
 String id, AnntenaCategory category, int? targetCount, bool targetsAll, bool dealsDamage, List<Attribute> attackAttributes, bool isInheritable, String? evolvesToId, int? maxLevel, String? variantGroupId, bool hasLevel
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? targetCount = freezed,Object? targetsAll = null,Object? dealsDamage = null,Object? attackAttributes = null,Object? isInheritable = null,Object? evolvesToId = freezed,Object? maxLevel = freezed,Object? variantGroupId = freezed,Object? hasLevel = null,}) {
  return _then(_Anntena(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AnntenaCategory,targetCount: freezed == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int?,targetsAll: null == targetsAll ? _self.targetsAll : targetsAll // ignore: cast_nullable_to_non_nullable
as bool,dealsDamage: null == dealsDamage ? _self.dealsDamage : dealsDamage // ignore: cast_nullable_to_non_nullable
as bool,attackAttributes: null == attackAttributes ? _self._attackAttributes : attackAttributes // ignore: cast_nullable_to_non_nullable
as List<Attribute>,isInheritable: null == isInheritable ? _self.isInheritable : isInheritable // ignore: cast_nullable_to_non_nullable
as bool,evolvesToId: freezed == evolvesToId ? _self.evolvesToId : evolvesToId // ignore: cast_nullable_to_non_nullable
as String?,maxLevel: freezed == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int?,variantGroupId: freezed == variantGroupId ? _self.variantGroupId : variantGroupId // ignore: cast_nullable_to_non_nullable
as String?,hasLevel: null == hasLevel ? _self.hasLevel : hasLevel // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
