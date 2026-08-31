// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dm_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DMFile {

 String get dataVersion;
/// Create a copy of DMFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DMFileCopyWith<DMFile> get copyWith => _$DMFileCopyWithImpl<DMFile>(this as DMFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DMFile&&(identical(other.dataVersion, dataVersion) || other.dataVersion == dataVersion));
}


@override
int get hashCode => Object.hash(runtimeType,dataVersion);

@override
String toString() {
  return 'DMFile(dataVersion: $dataVersion)';
}


}

/// @nodoc
abstract mixin class $DMFileCopyWith<$Res>  {
  factory $DMFileCopyWith(DMFile value, $Res Function(DMFile) _then) = _$DMFileCopyWithImpl;
@useResult
$Res call({
 String dataVersion
});




}
/// @nodoc
class _$DMFileCopyWithImpl<$Res>
    implements $DMFileCopyWith<$Res> {
  _$DMFileCopyWithImpl(this._self, this._then);

  final DMFile _self;
  final $Res Function(DMFile) _then;

/// Create a copy of DMFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dataVersion = null,}) {
  return _then(_self.copyWith(
dataVersion: null == dataVersion ? _self.dataVersion : dataVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DMFile].
extension DMFilePatterns on DMFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DMFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DMFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DMFile value)  $default,){
final _that = this;
switch (_that) {
case _DMFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DMFile value)?  $default,){
final _that = this;
switch (_that) {
case _DMFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dataVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DMFile() when $default != null:
return $default(_that.dataVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dataVersion)  $default,) {final _that = this;
switch (_that) {
case _DMFile():
return $default(_that.dataVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dataVersion)?  $default,) {final _that = this;
switch (_that) {
case _DMFile() when $default != null:
return $default(_that.dataVersion);case _:
  return null;

}
}

}

/// @nodoc


class _DMFile extends DMFile {
  const _DMFile({required this.dataVersion}): super._();
  

@override final  String dataVersion;

/// Create a copy of DMFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DMFileCopyWith<_DMFile> get copyWith => __$DMFileCopyWithImpl<_DMFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DMFile&&(identical(other.dataVersion, dataVersion) || other.dataVersion == dataVersion));
}


@override
int get hashCode => Object.hash(runtimeType,dataVersion);

@override
String toString() {
  return 'DMFile(dataVersion: $dataVersion)';
}


}

/// @nodoc
abstract mixin class _$DMFileCopyWith<$Res> implements $DMFileCopyWith<$Res> {
  factory _$DMFileCopyWith(_DMFile value, $Res Function(_DMFile) _then) = __$DMFileCopyWithImpl;
@override @useResult
$Res call({
 String dataVersion
});




}
/// @nodoc
class __$DMFileCopyWithImpl<$Res>
    implements _$DMFileCopyWith<$Res> {
  __$DMFileCopyWithImpl(this._self, this._then);

  final _DMFile _self;
  final $Res Function(_DMFile) _then;

/// Create a copy of DMFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dataVersion = null,}) {
  return _then(_DMFile(
dataVersion: null == dataVersion ? _self.dataVersion : dataVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
