// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_antenna_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueAntennaCategory {

 String get category; String get anntenaCategory;
/// Create a copy of PhysiqueAntennaCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueAntennaCategoryCopyWith<PhysiqueAntennaCategory> get copyWith => _$PhysiqueAntennaCategoryCopyWithImpl<PhysiqueAntennaCategory>(this as PhysiqueAntennaCategory, _$identity);

  /// Serializes this PhysiqueAntennaCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueAntennaCategory&&(identical(other.category, category) || other.category == category)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,anntenaCategory);

@override
String toString() {
  return 'PhysiqueAntennaCategory(category: $category, anntenaCategory: $anntenaCategory)';
}


}

/// @nodoc
abstract mixin class $PhysiqueAntennaCategoryCopyWith<$Res>  {
  factory $PhysiqueAntennaCategoryCopyWith(PhysiqueAntennaCategory value, $Res Function(PhysiqueAntennaCategory) _then) = _$PhysiqueAntennaCategoryCopyWithImpl;
@useResult
$Res call({
 String category, String anntenaCategory
});




}
/// @nodoc
class _$PhysiqueAntennaCategoryCopyWithImpl<$Res>
    implements $PhysiqueAntennaCategoryCopyWith<$Res> {
  _$PhysiqueAntennaCategoryCopyWithImpl(this._self, this._then);

  final PhysiqueAntennaCategory _self;
  final $Res Function(PhysiqueAntennaCategory) _then;

/// Create a copy of PhysiqueAntennaCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? anntenaCategory = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueAntennaCategory].
extension PhysiqueAntennaCategoryPatterns on PhysiqueAntennaCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueAntennaCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueAntennaCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueAntennaCategory value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueAntennaCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueAntennaCategory value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueAntennaCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  String anntenaCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueAntennaCategory() when $default != null:
return $default(_that.category,_that.anntenaCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  String anntenaCategory)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueAntennaCategory():
return $default(_that.category,_that.anntenaCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  String anntenaCategory)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueAntennaCategory() when $default != null:
return $default(_that.category,_that.anntenaCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueAntennaCategory implements PhysiqueAntennaCategory {
  const _PhysiqueAntennaCategory({required this.category, required this.anntenaCategory});
  factory _PhysiqueAntennaCategory.fromJson(Map<String, dynamic> json) => _$PhysiqueAntennaCategoryFromJson(json);

@override final  String category;
@override final  String anntenaCategory;

/// Create a copy of PhysiqueAntennaCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueAntennaCategoryCopyWith<_PhysiqueAntennaCategory> get copyWith => __$PhysiqueAntennaCategoryCopyWithImpl<_PhysiqueAntennaCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueAntennaCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueAntennaCategory&&(identical(other.category, category) || other.category == category)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,anntenaCategory);

@override
String toString() {
  return 'PhysiqueAntennaCategory(category: $category, anntenaCategory: $anntenaCategory)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueAntennaCategoryCopyWith<$Res> implements $PhysiqueAntennaCategoryCopyWith<$Res> {
  factory _$PhysiqueAntennaCategoryCopyWith(_PhysiqueAntennaCategory value, $Res Function(_PhysiqueAntennaCategory) _then) = __$PhysiqueAntennaCategoryCopyWithImpl;
@override @useResult
$Res call({
 String category, String anntenaCategory
});




}
/// @nodoc
class __$PhysiqueAntennaCategoryCopyWithImpl<$Res>
    implements _$PhysiqueAntennaCategoryCopyWith<$Res> {
  __$PhysiqueAntennaCategoryCopyWithImpl(this._self, this._then);

  final _PhysiqueAntennaCategory _self;
  final $Res Function(_PhysiqueAntennaCategory) _then;

/// Create a copy of PhysiqueAntennaCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? anntenaCategory = null,}) {
  return _then(_PhysiqueAntennaCategory(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
