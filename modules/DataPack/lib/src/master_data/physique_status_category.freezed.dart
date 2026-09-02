// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_status_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueStatusCategory {

 String get name; int get columnCount;
/// Create a copy of PhysiqueStatusCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueStatusCategoryCopyWith<PhysiqueStatusCategory> get copyWith => _$PhysiqueStatusCategoryCopyWithImpl<PhysiqueStatusCategory>(this as PhysiqueStatusCategory, _$identity);

  /// Serializes this PhysiqueStatusCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueStatusCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,columnCount);

@override
String toString() {
  return 'PhysiqueStatusCategory(name: $name, columnCount: $columnCount)';
}


}

/// @nodoc
abstract mixin class $PhysiqueStatusCategoryCopyWith<$Res>  {
  factory $PhysiqueStatusCategoryCopyWith(PhysiqueStatusCategory value, $Res Function(PhysiqueStatusCategory) _then) = _$PhysiqueStatusCategoryCopyWithImpl;
@useResult
$Res call({
 String name, int columnCount
});




}
/// @nodoc
class _$PhysiqueStatusCategoryCopyWithImpl<$Res>
    implements $PhysiqueStatusCategoryCopyWith<$Res> {
  _$PhysiqueStatusCategoryCopyWithImpl(this._self, this._then);

  final PhysiqueStatusCategory _self;
  final $Res Function(PhysiqueStatusCategory) _then;

/// Create a copy of PhysiqueStatusCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? columnCount = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueStatusCategory].
extension PhysiqueStatusCategoryPatterns on PhysiqueStatusCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueStatusCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueStatusCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueStatusCategory value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueStatusCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueStatusCategory value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueStatusCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int columnCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueStatusCategory() when $default != null:
return $default(_that.name,_that.columnCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int columnCount)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueStatusCategory():
return $default(_that.name,_that.columnCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int columnCount)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueStatusCategory() when $default != null:
return $default(_that.name,_that.columnCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueStatusCategory implements PhysiqueStatusCategory {
  const _PhysiqueStatusCategory({required this.name, required this.columnCount});
  factory _PhysiqueStatusCategory.fromJson(Map<String, dynamic> json) => _$PhysiqueStatusCategoryFromJson(json);

@override final  String name;
@override final  int columnCount;

/// Create a copy of PhysiqueStatusCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueStatusCategoryCopyWith<_PhysiqueStatusCategory> get copyWith => __$PhysiqueStatusCategoryCopyWithImpl<_PhysiqueStatusCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueStatusCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueStatusCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,columnCount);

@override
String toString() {
  return 'PhysiqueStatusCategory(name: $name, columnCount: $columnCount)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueStatusCategoryCopyWith<$Res> implements $PhysiqueStatusCategoryCopyWith<$Res> {
  factory _$PhysiqueStatusCategoryCopyWith(_PhysiqueStatusCategory value, $Res Function(_PhysiqueStatusCategory) _then) = __$PhysiqueStatusCategoryCopyWithImpl;
@override @useResult
$Res call({
 String name, int columnCount
});




}
/// @nodoc
class __$PhysiqueStatusCategoryCopyWithImpl<$Res>
    implements _$PhysiqueStatusCategoryCopyWith<$Res> {
  __$PhysiqueStatusCategoryCopyWithImpl(this._self, this._then);

  final _PhysiqueStatusCategory _self;
  final $Res Function(_PhysiqueStatusCategory) _then;

/// Create a copy of PhysiqueStatusCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? columnCount = null,}) {
  return _then(_PhysiqueStatusCategory(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
