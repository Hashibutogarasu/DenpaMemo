// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_color_resistance_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BodyColorResistanceRule {

 String get colorId; Map<String, int> get attributeResistanceBonuses;
/// Create a copy of BodyColorResistanceRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyColorResistanceRuleCopyWith<BodyColorResistanceRule> get copyWith => _$BodyColorResistanceRuleCopyWithImpl<BodyColorResistanceRule>(this as BodyColorResistanceRule, _$identity);

  /// Serializes this BodyColorResistanceRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyColorResistanceRule&&(identical(other.colorId, colorId) || other.colorId == colorId)&&const DeepCollectionEquality().equals(other.attributeResistanceBonuses, attributeResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,colorId,const DeepCollectionEquality().hash(attributeResistanceBonuses));

@override
String toString() {
  return 'BodyColorResistanceRule(colorId: $colorId, attributeResistanceBonuses: $attributeResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class $BodyColorResistanceRuleCopyWith<$Res>  {
  factory $BodyColorResistanceRuleCopyWith(BodyColorResistanceRule value, $Res Function(BodyColorResistanceRule) _then) = _$BodyColorResistanceRuleCopyWithImpl;
@useResult
$Res call({
 String colorId, Map<String, int> attributeResistanceBonuses
});




}
/// @nodoc
class _$BodyColorResistanceRuleCopyWithImpl<$Res>
    implements $BodyColorResistanceRuleCopyWith<$Res> {
  _$BodyColorResistanceRuleCopyWithImpl(this._self, this._then);

  final BodyColorResistanceRule _self;
  final $Res Function(BodyColorResistanceRule) _then;

/// Create a copy of BodyColorResistanceRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colorId = null,Object? attributeResistanceBonuses = null,}) {
  return _then(_self.copyWith(
colorId: null == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as String,attributeResistanceBonuses: null == attributeResistanceBonuses ? _self.attributeResistanceBonuses : attributeResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyColorResistanceRule].
extension BodyColorResistanceRulePatterns on BodyColorResistanceRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyColorResistanceRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyColorResistanceRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyColorResistanceRule value)  $default,){
final _that = this;
switch (_that) {
case _BodyColorResistanceRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyColorResistanceRule value)?  $default,){
final _that = this;
switch (_that) {
case _BodyColorResistanceRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String colorId,  Map<String, int> attributeResistanceBonuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyColorResistanceRule() when $default != null:
return $default(_that.colorId,_that.attributeResistanceBonuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String colorId,  Map<String, int> attributeResistanceBonuses)  $default,) {final _that = this;
switch (_that) {
case _BodyColorResistanceRule():
return $default(_that.colorId,_that.attributeResistanceBonuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String colorId,  Map<String, int> attributeResistanceBonuses)?  $default,) {final _that = this;
switch (_that) {
case _BodyColorResistanceRule() when $default != null:
return $default(_that.colorId,_that.attributeResistanceBonuses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BodyColorResistanceRule implements BodyColorResistanceRule {
  const _BodyColorResistanceRule({required this.colorId, final  Map<String, int> attributeResistanceBonuses = const {}}): _attributeResistanceBonuses = attributeResistanceBonuses;
  factory _BodyColorResistanceRule.fromJson(Map<String, dynamic> json) => _$BodyColorResistanceRuleFromJson(json);

@override final  String colorId;
 final  Map<String, int> _attributeResistanceBonuses;
@override@JsonKey() Map<String, int> get attributeResistanceBonuses {
  if (_attributeResistanceBonuses is EqualUnmodifiableMapView) return _attributeResistanceBonuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributeResistanceBonuses);
}


/// Create a copy of BodyColorResistanceRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyColorResistanceRuleCopyWith<_BodyColorResistanceRule> get copyWith => __$BodyColorResistanceRuleCopyWithImpl<_BodyColorResistanceRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BodyColorResistanceRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyColorResistanceRule&&(identical(other.colorId, colorId) || other.colorId == colorId)&&const DeepCollectionEquality().equals(other._attributeResistanceBonuses, _attributeResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,colorId,const DeepCollectionEquality().hash(_attributeResistanceBonuses));

@override
String toString() {
  return 'BodyColorResistanceRule(colorId: $colorId, attributeResistanceBonuses: $attributeResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class _$BodyColorResistanceRuleCopyWith<$Res> implements $BodyColorResistanceRuleCopyWith<$Res> {
  factory _$BodyColorResistanceRuleCopyWith(_BodyColorResistanceRule value, $Res Function(_BodyColorResistanceRule) _then) = __$BodyColorResistanceRuleCopyWithImpl;
@override @useResult
$Res call({
 String colorId, Map<String, int> attributeResistanceBonuses
});




}
/// @nodoc
class __$BodyColorResistanceRuleCopyWithImpl<$Res>
    implements _$BodyColorResistanceRuleCopyWith<$Res> {
  __$BodyColorResistanceRuleCopyWithImpl(this._self, this._then);

  final _BodyColorResistanceRule _self;
  final $Res Function(_BodyColorResistanceRule) _then;

/// Create a copy of BodyColorResistanceRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colorId = null,Object? attributeResistanceBonuses = null,}) {
  return _then(_BodyColorResistanceRule(
colorId: null == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as String,attributeResistanceBonuses: null == attributeResistanceBonuses ? _self._attributeResistanceBonuses : attributeResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
