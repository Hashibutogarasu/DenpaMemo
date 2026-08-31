// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppMetadataConfig {

 String get author; String get license;
/// Create a copy of AppMetadataConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppMetadataConfigCopyWith<AppMetadataConfig> get copyWith => _$AppMetadataConfigCopyWithImpl<AppMetadataConfig>(this as AppMetadataConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppMetadataConfig&&(identical(other.author, author) || other.author == author)&&(identical(other.license, license) || other.license == license));
}


@override
int get hashCode => Object.hash(runtimeType,author,license);

@override
String toString() {
  return 'AppMetadataConfig(author: $author, license: $license)';
}


}

/// @nodoc
abstract mixin class $AppMetadataConfigCopyWith<$Res>  {
  factory $AppMetadataConfigCopyWith(AppMetadataConfig value, $Res Function(AppMetadataConfig) _then) = _$AppMetadataConfigCopyWithImpl;
@useResult
$Res call({
 String author, String license
});




}
/// @nodoc
class _$AppMetadataConfigCopyWithImpl<$Res>
    implements $AppMetadataConfigCopyWith<$Res> {
  _$AppMetadataConfigCopyWithImpl(this._self, this._then);

  final AppMetadataConfig _self;
  final $Res Function(AppMetadataConfig) _then;

/// Create a copy of AppMetadataConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? author = null,Object? license = null,}) {
  return _then(_self.copyWith(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,license: null == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppMetadataConfig].
extension AppMetadataConfigPatterns on AppMetadataConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppMetadataConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppMetadataConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppMetadataConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppMetadataConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppMetadataConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppMetadataConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String author,  String license)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppMetadataConfig() when $default != null:
return $default(_that.author,_that.license);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String author,  String license)  $default,) {final _that = this;
switch (_that) {
case _AppMetadataConfig():
return $default(_that.author,_that.license);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String author,  String license)?  $default,) {final _that = this;
switch (_that) {
case _AppMetadataConfig() when $default != null:
return $default(_that.author,_that.license);case _:
  return null;

}
}

}

/// @nodoc


class _AppMetadataConfig implements AppMetadataConfig {
  const _AppMetadataConfig({required this.author, required this.license});
  

@override final  String author;
@override final  String license;

/// Create a copy of AppMetadataConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppMetadataConfigCopyWith<_AppMetadataConfig> get copyWith => __$AppMetadataConfigCopyWithImpl<_AppMetadataConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppMetadataConfig&&(identical(other.author, author) || other.author == author)&&(identical(other.license, license) || other.license == license));
}


@override
int get hashCode => Object.hash(runtimeType,author,license);

@override
String toString() {
  return 'AppMetadataConfig(author: $author, license: $license)';
}


}

/// @nodoc
abstract mixin class _$AppMetadataConfigCopyWith<$Res> implements $AppMetadataConfigCopyWith<$Res> {
  factory _$AppMetadataConfigCopyWith(_AppMetadataConfig value, $Res Function(_AppMetadataConfig) _then) = __$AppMetadataConfigCopyWithImpl;
@override @useResult
$Res call({
 String author, String license
});




}
/// @nodoc
class __$AppMetadataConfigCopyWithImpl<$Res>
    implements _$AppMetadataConfigCopyWith<$Res> {
  __$AppMetadataConfigCopyWithImpl(this._self, this._then);

  final _AppMetadataConfig _self;
  final $Res Function(_AppMetadataConfig) _then;

/// Create a copy of AppMetadataConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? author = null,Object? license = null,}) {
  return _then(_AppMetadataConfig(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,license: null == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
