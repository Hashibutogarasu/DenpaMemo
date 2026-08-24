// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monster_exp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonsterExp {

 String get monsterId; int get count; int get exp; int get level; int get maxLevelTeammateCount; int get expRecipientCount;
/// Create a copy of MonsterExp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonsterExpCopyWith<MonsterExp> get copyWith => _$MonsterExpCopyWithImpl<MonsterExp>(this as MonsterExp, _$identity);

  /// Serializes this MonsterExp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonsterExp&&(identical(other.monsterId, monsterId) || other.monsterId == monsterId)&&(identical(other.count, count) || other.count == count)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevelTeammateCount, maxLevelTeammateCount) || other.maxLevelTeammateCount == maxLevelTeammateCount)&&(identical(other.expRecipientCount, expRecipientCount) || other.expRecipientCount == expRecipientCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monsterId,count,exp,level,maxLevelTeammateCount,expRecipientCount);

@override
String toString() {
  return 'MonsterExp(monsterId: $monsterId, count: $count, exp: $exp, level: $level, maxLevelTeammateCount: $maxLevelTeammateCount, expRecipientCount: $expRecipientCount)';
}


}

/// @nodoc
abstract mixin class $MonsterExpCopyWith<$Res>  {
  factory $MonsterExpCopyWith(MonsterExp value, $Res Function(MonsterExp) _then) = _$MonsterExpCopyWithImpl;
@useResult
$Res call({
 String monsterId, int count, int exp, int level, int maxLevelTeammateCount, int expRecipientCount
});




}
/// @nodoc
class _$MonsterExpCopyWithImpl<$Res>
    implements $MonsterExpCopyWith<$Res> {
  _$MonsterExpCopyWithImpl(this._self, this._then);

  final MonsterExp _self;
  final $Res Function(MonsterExp) _then;

/// Create a copy of MonsterExp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monsterId = null,Object? count = null,Object? exp = null,Object? level = null,Object? maxLevelTeammateCount = null,Object? expRecipientCount = null,}) {
  return _then(_self.copyWith(
monsterId: null == monsterId ? _self.monsterId : monsterId // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,exp: null == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,maxLevelTeammateCount: null == maxLevelTeammateCount ? _self.maxLevelTeammateCount : maxLevelTeammateCount // ignore: cast_nullable_to_non_nullable
as int,expRecipientCount: null == expRecipientCount ? _self.expRecipientCount : expRecipientCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonsterExp].
extension MonsterExpPatterns on MonsterExp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonsterExp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonsterExp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonsterExp value)  $default,){
final _that = this;
switch (_that) {
case _MonsterExp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonsterExp value)?  $default,){
final _that = this;
switch (_that) {
case _MonsterExp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String monsterId,  int count,  int exp,  int level,  int maxLevelTeammateCount,  int expRecipientCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonsterExp() when $default != null:
return $default(_that.monsterId,_that.count,_that.exp,_that.level,_that.maxLevelTeammateCount,_that.expRecipientCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String monsterId,  int count,  int exp,  int level,  int maxLevelTeammateCount,  int expRecipientCount)  $default,) {final _that = this;
switch (_that) {
case _MonsterExp():
return $default(_that.monsterId,_that.count,_that.exp,_that.level,_that.maxLevelTeammateCount,_that.expRecipientCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String monsterId,  int count,  int exp,  int level,  int maxLevelTeammateCount,  int expRecipientCount)?  $default,) {final _that = this;
switch (_that) {
case _MonsterExp() when $default != null:
return $default(_that.monsterId,_that.count,_that.exp,_that.level,_that.maxLevelTeammateCount,_that.expRecipientCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonsterExp implements MonsterExp {
  const _MonsterExp({required this.monsterId, required this.count, required this.exp, required this.level, required this.maxLevelTeammateCount, required this.expRecipientCount});
  factory _MonsterExp.fromJson(Map<String, dynamic> json) => _$MonsterExpFromJson(json);

@override final  String monsterId;
@override final  int count;
@override final  int exp;
@override final  int level;
@override final  int maxLevelTeammateCount;
@override final  int expRecipientCount;

/// Create a copy of MonsterExp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonsterExpCopyWith<_MonsterExp> get copyWith => __$MonsterExpCopyWithImpl<_MonsterExp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonsterExpToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonsterExp&&(identical(other.monsterId, monsterId) || other.monsterId == monsterId)&&(identical(other.count, count) || other.count == count)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevelTeammateCount, maxLevelTeammateCount) || other.maxLevelTeammateCount == maxLevelTeammateCount)&&(identical(other.expRecipientCount, expRecipientCount) || other.expRecipientCount == expRecipientCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monsterId,count,exp,level,maxLevelTeammateCount,expRecipientCount);

@override
String toString() {
  return 'MonsterExp(monsterId: $monsterId, count: $count, exp: $exp, level: $level, maxLevelTeammateCount: $maxLevelTeammateCount, expRecipientCount: $expRecipientCount)';
}


}

/// @nodoc
abstract mixin class _$MonsterExpCopyWith<$Res> implements $MonsterExpCopyWith<$Res> {
  factory _$MonsterExpCopyWith(_MonsterExp value, $Res Function(_MonsterExp) _then) = __$MonsterExpCopyWithImpl;
@override @useResult
$Res call({
 String monsterId, int count, int exp, int level, int maxLevelTeammateCount, int expRecipientCount
});




}
/// @nodoc
class __$MonsterExpCopyWithImpl<$Res>
    implements _$MonsterExpCopyWith<$Res> {
  __$MonsterExpCopyWithImpl(this._self, this._then);

  final _MonsterExp _self;
  final $Res Function(_MonsterExp) _then;

/// Create a copy of MonsterExp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monsterId = null,Object? count = null,Object? exp = null,Object? level = null,Object? maxLevelTeammateCount = null,Object? expRecipientCount = null,}) {
  return _then(_MonsterExp(
monsterId: null == monsterId ? _self.monsterId : monsterId // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,exp: null == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,maxLevelTeammateCount: null == maxLevelTeammateCount ? _self.maxLevelTeammateCount : maxLevelTeammateCount // ignore: cast_nullable_to_non_nullable
as int,expRecipientCount: null == expRecipientCount ? _self.expRecipientCount : expRecipientCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
