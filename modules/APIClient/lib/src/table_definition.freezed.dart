// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TableDefinition {

 String get type; int get columnCount; String get translationKey;
/// Create a copy of TableDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableDefinitionCopyWith<TableDefinition> get copyWith => _$TableDefinitionCopyWithImpl<TableDefinition>(this as TableDefinition, _$identity);

  /// Serializes this TableDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableDefinition&&(identical(other.type, type) || other.type == type)&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount)&&(identical(other.translationKey, translationKey) || other.translationKey == translationKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,columnCount,translationKey);

@override
String toString() {
  return 'TableDefinition(type: $type, columnCount: $columnCount, translationKey: $translationKey)';
}


}

/// @nodoc
abstract mixin class $TableDefinitionCopyWith<$Res>  {
  factory $TableDefinitionCopyWith(TableDefinition value, $Res Function(TableDefinition) _then) = _$TableDefinitionCopyWithImpl;
@useResult
$Res call({
 String type, int columnCount, String translationKey
});




}
/// @nodoc
class _$TableDefinitionCopyWithImpl<$Res>
    implements $TableDefinitionCopyWith<$Res> {
  _$TableDefinitionCopyWithImpl(this._self, this._then);

  final TableDefinition _self;
  final $Res Function(TableDefinition) _then;

/// Create a copy of TableDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? columnCount = null,Object? translationKey = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,translationKey: null == translationKey ? _self.translationKey : translationKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TableDefinition].
extension TableDefinitionPatterns on TableDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableDefinition value)  $default,){
final _that = this;
switch (_that) {
case _TableDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _TableDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int columnCount,  String translationKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableDefinition() when $default != null:
return $default(_that.type,_that.columnCount,_that.translationKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int columnCount,  String translationKey)  $default,) {final _that = this;
switch (_that) {
case _TableDefinition():
return $default(_that.type,_that.columnCount,_that.translationKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int columnCount,  String translationKey)?  $default,) {final _that = this;
switch (_that) {
case _TableDefinition() when $default != null:
return $default(_that.type,_that.columnCount,_that.translationKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TableDefinition implements TableDefinition {
  const _TableDefinition({required this.type, required this.columnCount, required this.translationKey});
  factory _TableDefinition.fromJson(Map<String, dynamic> json) => _$TableDefinitionFromJson(json);

@override final  String type;
@override final  int columnCount;
@override final  String translationKey;

/// Create a copy of TableDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableDefinitionCopyWith<_TableDefinition> get copyWith => __$TableDefinitionCopyWithImpl<_TableDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TableDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableDefinition&&(identical(other.type, type) || other.type == type)&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount)&&(identical(other.translationKey, translationKey) || other.translationKey == translationKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,columnCount,translationKey);

@override
String toString() {
  return 'TableDefinition(type: $type, columnCount: $columnCount, translationKey: $translationKey)';
}


}

/// @nodoc
abstract mixin class _$TableDefinitionCopyWith<$Res> implements $TableDefinitionCopyWith<$Res> {
  factory _$TableDefinitionCopyWith(_TableDefinition value, $Res Function(_TableDefinition) _then) = __$TableDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String type, int columnCount, String translationKey
});




}
/// @nodoc
class __$TableDefinitionCopyWithImpl<$Res>
    implements _$TableDefinitionCopyWith<$Res> {
  __$TableDefinitionCopyWithImpl(this._self, this._then);

  final _TableDefinition _self;
  final $Res Function(_TableDefinition) _then;

/// Create a copy of TableDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? columnCount = null,Object? translationKey = null,}) {
  return _then(_TableDefinition(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,translationKey: null == translationKey ? _self.translationKey : translationKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
