// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CloudFile {

 String get fileId; String get filename; DateTime get uploadedAt;
/// Create a copy of CloudFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloudFileCopyWith<CloudFile> get copyWith => _$CloudFileCopyWithImpl<CloudFile>(this as CloudFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloudFile&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}


@override
int get hashCode => Object.hash(runtimeType,fileId,filename,uploadedAt);

@override
String toString() {
  return 'CloudFile(fileId: $fileId, filename: $filename, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class $CloudFileCopyWith<$Res>  {
  factory $CloudFileCopyWith(CloudFile value, $Res Function(CloudFile) _then) = _$CloudFileCopyWithImpl;
@useResult
$Res call({
 String fileId, String filename, DateTime uploadedAt
});




}
/// @nodoc
class _$CloudFileCopyWithImpl<$Res>
    implements $CloudFileCopyWith<$Res> {
  _$CloudFileCopyWithImpl(this._self, this._then);

  final CloudFile _self;
  final $Res Function(CloudFile) _then;

/// Create a copy of CloudFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileId = null,Object? filename = null,Object? uploadedAt = null,}) {
  return _then(_self.copyWith(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CloudFile].
extension CloudFilePatterns on CloudFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloudFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloudFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloudFile value)  $default,){
final _that = this;
switch (_that) {
case _CloudFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloudFile value)?  $default,){
final _that = this;
switch (_that) {
case _CloudFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileId,  String filename,  DateTime uploadedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloudFile() when $default != null:
return $default(_that.fileId,_that.filename,_that.uploadedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileId,  String filename,  DateTime uploadedAt)  $default,) {final _that = this;
switch (_that) {
case _CloudFile():
return $default(_that.fileId,_that.filename,_that.uploadedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileId,  String filename,  DateTime uploadedAt)?  $default,) {final _that = this;
switch (_that) {
case _CloudFile() when $default != null:
return $default(_that.fileId,_that.filename,_that.uploadedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CloudFile implements CloudFile {
  const _CloudFile({required this.fileId, required this.filename, required this.uploadedAt});
  

@override final  String fileId;
@override final  String filename;
@override final  DateTime uploadedAt;

/// Create a copy of CloudFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloudFileCopyWith<_CloudFile> get copyWith => __$CloudFileCopyWithImpl<_CloudFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloudFile&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}


@override
int get hashCode => Object.hash(runtimeType,fileId,filename,uploadedAt);

@override
String toString() {
  return 'CloudFile(fileId: $fileId, filename: $filename, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class _$CloudFileCopyWith<$Res> implements $CloudFileCopyWith<$Res> {
  factory _$CloudFileCopyWith(_CloudFile value, $Res Function(_CloudFile) _then) = __$CloudFileCopyWithImpl;
@override @useResult
$Res call({
 String fileId, String filename, DateTime uploadedAt
});




}
/// @nodoc
class __$CloudFileCopyWithImpl<$Res>
    implements _$CloudFileCopyWith<$Res> {
  __$CloudFileCopyWithImpl(this._self, this._then);

  final _CloudFile _self;
  final $Res Function(_CloudFile) _then;

/// Create a copy of CloudFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileId = null,Object? filename = null,Object? uploadedAt = null,}) {
  return _then(_CloudFile(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
