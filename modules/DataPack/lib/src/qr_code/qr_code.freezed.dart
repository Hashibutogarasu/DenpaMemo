// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QrCode {

 String get id; String get rawValue; String get hash; DateTime get createdAt; String? get name;
/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrCodeCopyWith<QrCode> get copyWith => _$QrCodeCopyWithImpl<QrCode>(this as QrCode, _$identity);

  /// Serializes this QrCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrCode&&(identical(other.id, id) || other.id == id)&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rawValue,hash,createdAt,name);

@override
String toString() {
  return 'QrCode(id: $id, rawValue: $rawValue, hash: $hash, createdAt: $createdAt, name: $name)';
}


}

/// @nodoc
abstract mixin class $QrCodeCopyWith<$Res>  {
  factory $QrCodeCopyWith(QrCode value, $Res Function(QrCode) _then) = _$QrCodeCopyWithImpl;
@useResult
$Res call({
 String id, String rawValue, String hash, DateTime createdAt, String? name
});




}
/// @nodoc
class _$QrCodeCopyWithImpl<$Res>
    implements $QrCodeCopyWith<$Res> {
  _$QrCodeCopyWithImpl(this._self, this._then);

  final QrCode _self;
  final $Res Function(QrCode) _then;

/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rawValue = null,Object? hash = null,Object? createdAt = null,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rawValue: null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QrCode].
extension QrCodePatterns on QrCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrCode value)  $default,){
final _that = this;
switch (_that) {
case _QrCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrCode value)?  $default,){
final _that = this;
switch (_that) {
case _QrCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String rawValue,  String hash,  DateTime createdAt,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrCode() when $default != null:
return $default(_that.id,_that.rawValue,_that.hash,_that.createdAt,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String rawValue,  String hash,  DateTime createdAt,  String? name)  $default,) {final _that = this;
switch (_that) {
case _QrCode():
return $default(_that.id,_that.rawValue,_that.hash,_that.createdAt,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String rawValue,  String hash,  DateTime createdAt,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _QrCode() when $default != null:
return $default(_that.id,_that.rawValue,_that.hash,_that.createdAt,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QrCode implements QrCode {
  const _QrCode({required this.id, required this.rawValue, required this.hash, required this.createdAt, this.name});
  factory _QrCode.fromJson(Map<String, dynamic> json) => _$QrCodeFromJson(json);

@override final  String id;
@override final  String rawValue;
@override final  String hash;
@override final  DateTime createdAt;
@override final  String? name;

/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrCodeCopyWith<_QrCode> get copyWith => __$QrCodeCopyWithImpl<_QrCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QrCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrCode&&(identical(other.id, id) || other.id == id)&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rawValue,hash,createdAt,name);

@override
String toString() {
  return 'QrCode(id: $id, rawValue: $rawValue, hash: $hash, createdAt: $createdAt, name: $name)';
}


}

/// @nodoc
abstract mixin class _$QrCodeCopyWith<$Res> implements $QrCodeCopyWith<$Res> {
  factory _$QrCodeCopyWith(_QrCode value, $Res Function(_QrCode) _then) = __$QrCodeCopyWithImpl;
@override @useResult
$Res call({
 String id, String rawValue, String hash, DateTime createdAt, String? name
});




}
/// @nodoc
class __$QrCodeCopyWithImpl<$Res>
    implements _$QrCodeCopyWith<$Res> {
  __$QrCodeCopyWithImpl(this._self, this._then);

  final _QrCode _self;
  final $Res Function(_QrCode) _then;

/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rawValue = null,Object? hash = null,Object? createdAt = null,Object? name = freezed,}) {
  return _then(_QrCode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rawValue: null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
