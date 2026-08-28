// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_color_abnormality_resistance_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BodyColorAbnormalityResistanceRule {

 String get colorId; Map<String, int> get abnormalityResistanceBonuses;
/// Create a copy of BodyColorAbnormalityResistanceRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyColorAbnormalityResistanceRuleCopyWith<BodyColorAbnormalityResistanceRule> get copyWith => _$BodyColorAbnormalityResistanceRuleCopyWithImpl<BodyColorAbnormalityResistanceRule>(this as BodyColorAbnormalityResistanceRule, _$identity);

  /// Serializes this BodyColorAbnormalityResistanceRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyColorAbnormalityResistanceRule&&(identical(other.colorId, colorId) || other.colorId == colorId)&&const DeepCollectionEquality().equals(other.abnormalityResistanceBonuses, abnormalityResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,colorId,const DeepCollectionEquality().hash(abnormalityResistanceBonuses));

@override
String toString() {
  return 'BodyColorAbnormalityResistanceRule(colorId: $colorId, abnormalityResistanceBonuses: $abnormalityResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class $BodyColorAbnormalityResistanceRuleCopyWith<$Res>  {
  factory $BodyColorAbnormalityResistanceRuleCopyWith(BodyColorAbnormalityResistanceRule value, $Res Function(BodyColorAbnormalityResistanceRule) _then) = _$BodyColorAbnormalityResistanceRuleCopyWithImpl;
@useResult
$Res call({
 String colorId, Map<String, int> abnormalityResistanceBonuses
});




}
/// @nodoc
class _$BodyColorAbnormalityResistanceRuleCopyWithImpl<$Res>
    implements $BodyColorAbnormalityResistanceRuleCopyWith<$Res> {
  _$BodyColorAbnormalityResistanceRuleCopyWithImpl(this._self, this._then);

  final BodyColorAbnormalityResistanceRule _self;
  final $Res Function(BodyColorAbnormalityResistanceRule) _then;

/// Create a copy of BodyColorAbnormalityResistanceRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colorId = null,Object? abnormalityResistanceBonuses = null,}) {
  return _then(_self.copyWith(
colorId: null == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self.abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyColorAbnormalityResistanceRule].
extension BodyColorAbnormalityResistanceRulePatterns on BodyColorAbnormalityResistanceRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyColorAbnormalityResistanceRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyColorAbnormalityResistanceRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyColorAbnormalityResistanceRule value)  $default,){
final _that = this;
switch (_that) {
case _BodyColorAbnormalityResistanceRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyColorAbnormalityResistanceRule value)?  $default,){
final _that = this;
switch (_that) {
case _BodyColorAbnormalityResistanceRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String colorId,  Map<String, int> abnormalityResistanceBonuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyColorAbnormalityResistanceRule() when $default != null:
return $default(_that.colorId,_that.abnormalityResistanceBonuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String colorId,  Map<String, int> abnormalityResistanceBonuses)  $default,) {final _that = this;
switch (_that) {
case _BodyColorAbnormalityResistanceRule():
return $default(_that.colorId,_that.abnormalityResistanceBonuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String colorId,  Map<String, int> abnormalityResistanceBonuses)?  $default,) {final _that = this;
switch (_that) {
case _BodyColorAbnormalityResistanceRule() when $default != null:
return $default(_that.colorId,_that.abnormalityResistanceBonuses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BodyColorAbnormalityResistanceRule implements BodyColorAbnormalityResistanceRule {
  const _BodyColorAbnormalityResistanceRule({required this.colorId, final  Map<String, int> abnormalityResistanceBonuses = const {}}): _abnormalityResistanceBonuses = abnormalityResistanceBonuses;
  factory _BodyColorAbnormalityResistanceRule.fromJson(Map<String, dynamic> json) => _$BodyColorAbnormalityResistanceRuleFromJson(json);

@override final  String colorId;
 final  Map<String, int> _abnormalityResistanceBonuses;
@override@JsonKey() Map<String, int> get abnormalityResistanceBonuses {
  if (_abnormalityResistanceBonuses is EqualUnmodifiableMapView) return _abnormalityResistanceBonuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_abnormalityResistanceBonuses);
}


/// Create a copy of BodyColorAbnormalityResistanceRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyColorAbnormalityResistanceRuleCopyWith<_BodyColorAbnormalityResistanceRule> get copyWith => __$BodyColorAbnormalityResistanceRuleCopyWithImpl<_BodyColorAbnormalityResistanceRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BodyColorAbnormalityResistanceRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyColorAbnormalityResistanceRule&&(identical(other.colorId, colorId) || other.colorId == colorId)&&const DeepCollectionEquality().equals(other._abnormalityResistanceBonuses, _abnormalityResistanceBonuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,colorId,const DeepCollectionEquality().hash(_abnormalityResistanceBonuses));

@override
String toString() {
  return 'BodyColorAbnormalityResistanceRule(colorId: $colorId, abnormalityResistanceBonuses: $abnormalityResistanceBonuses)';
}


}

/// @nodoc
abstract mixin class _$BodyColorAbnormalityResistanceRuleCopyWith<$Res> implements $BodyColorAbnormalityResistanceRuleCopyWith<$Res> {
  factory _$BodyColorAbnormalityResistanceRuleCopyWith(_BodyColorAbnormalityResistanceRule value, $Res Function(_BodyColorAbnormalityResistanceRule) _then) = __$BodyColorAbnormalityResistanceRuleCopyWithImpl;
@override @useResult
$Res call({
 String colorId, Map<String, int> abnormalityResistanceBonuses
});




}
/// @nodoc
class __$BodyColorAbnormalityResistanceRuleCopyWithImpl<$Res>
    implements _$BodyColorAbnormalityResistanceRuleCopyWith<$Res> {
  __$BodyColorAbnormalityResistanceRuleCopyWithImpl(this._self, this._then);

  final _BodyColorAbnormalityResistanceRule _self;
  final $Res Function(_BodyColorAbnormalityResistanceRule) _then;

/// Create a copy of BodyColorAbnormalityResistanceRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colorId = null,Object? abnormalityResistanceBonuses = null,}) {
  return _then(_BodyColorAbnormalityResistanceRule(
colorId: null == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as String,abnormalityResistanceBonuses: null == abnormalityResistanceBonuses ? _self._abnormalityResistanceBonuses : abnormalityResistanceBonuses // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
