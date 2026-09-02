// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_table_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueTableRecord {

 String get statusCategory; String get level; String get anntenaCategory; int get lineOffset; List<int> get values;
/// Create a copy of PhysiqueTableRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueTableRecordCopyWith<PhysiqueTableRecord> get copyWith => _$PhysiqueTableRecordCopyWithImpl<PhysiqueTableRecord>(this as PhysiqueTableRecord, _$identity);

  /// Serializes this PhysiqueTableRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueTableRecord&&(identical(other.statusCategory, statusCategory) || other.statusCategory == statusCategory)&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.lineOffset, lineOffset) || other.lineOffset == lineOffset)&&const DeepCollectionEquality().equals(other.values, values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCategory,level,anntenaCategory,lineOffset,const DeepCollectionEquality().hash(values));

@override
String toString() {
  return 'PhysiqueTableRecord(statusCategory: $statusCategory, level: $level, anntenaCategory: $anntenaCategory, lineOffset: $lineOffset, values: $values)';
}


}

/// @nodoc
abstract mixin class $PhysiqueTableRecordCopyWith<$Res>  {
  factory $PhysiqueTableRecordCopyWith(PhysiqueTableRecord value, $Res Function(PhysiqueTableRecord) _then) = _$PhysiqueTableRecordCopyWithImpl;
@useResult
$Res call({
 String statusCategory, String level, String anntenaCategory, int lineOffset, List<int> values
});




}
/// @nodoc
class _$PhysiqueTableRecordCopyWithImpl<$Res>
    implements $PhysiqueTableRecordCopyWith<$Res> {
  _$PhysiqueTableRecordCopyWithImpl(this._self, this._then);

  final PhysiqueTableRecord _self;
  final $Res Function(PhysiqueTableRecord) _then;

/// Create a copy of PhysiqueTableRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCategory = null,Object? level = null,Object? anntenaCategory = null,Object? lineOffset = null,Object? values = null,}) {
  return _then(_self.copyWith(
statusCategory: null == statusCategory ? _self.statusCategory : statusCategory // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,lineOffset: null == lineOffset ? _self.lineOffset : lineOffset // ignore: cast_nullable_to_non_nullable
as int,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueTableRecord].
extension PhysiqueTableRecordPatterns on PhysiqueTableRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueTableRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueTableRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueTableRecord value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueTableRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueTableRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueTableRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String statusCategory,  String level,  String anntenaCategory,  int lineOffset,  List<int> values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueTableRecord() when $default != null:
return $default(_that.statusCategory,_that.level,_that.anntenaCategory,_that.lineOffset,_that.values);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String statusCategory,  String level,  String anntenaCategory,  int lineOffset,  List<int> values)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueTableRecord():
return $default(_that.statusCategory,_that.level,_that.anntenaCategory,_that.lineOffset,_that.values);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String statusCategory,  String level,  String anntenaCategory,  int lineOffset,  List<int> values)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueTableRecord() when $default != null:
return $default(_that.statusCategory,_that.level,_that.anntenaCategory,_that.lineOffset,_that.values);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueTableRecord implements PhysiqueTableRecord {
  const _PhysiqueTableRecord({required this.statusCategory, required this.level, required this.anntenaCategory, required this.lineOffset, required final  List<int> values}): _values = values;
  factory _PhysiqueTableRecord.fromJson(Map<String, dynamic> json) => _$PhysiqueTableRecordFromJson(json);

@override final  String statusCategory;
@override final  String level;
@override final  String anntenaCategory;
@override final  int lineOffset;
 final  List<int> _values;
@override List<int> get values {
  if (_values is EqualUnmodifiableListView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_values);
}


/// Create a copy of PhysiqueTableRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueTableRecordCopyWith<_PhysiqueTableRecord> get copyWith => __$PhysiqueTableRecordCopyWithImpl<_PhysiqueTableRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueTableRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueTableRecord&&(identical(other.statusCategory, statusCategory) || other.statusCategory == statusCategory)&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.lineOffset, lineOffset) || other.lineOffset == lineOffset)&&const DeepCollectionEquality().equals(other._values, _values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCategory,level,anntenaCategory,lineOffset,const DeepCollectionEquality().hash(_values));

@override
String toString() {
  return 'PhysiqueTableRecord(statusCategory: $statusCategory, level: $level, anntenaCategory: $anntenaCategory, lineOffset: $lineOffset, values: $values)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueTableRecordCopyWith<$Res> implements $PhysiqueTableRecordCopyWith<$Res> {
  factory _$PhysiqueTableRecordCopyWith(_PhysiqueTableRecord value, $Res Function(_PhysiqueTableRecord) _then) = __$PhysiqueTableRecordCopyWithImpl;
@override @useResult
$Res call({
 String statusCategory, String level, String anntenaCategory, int lineOffset, List<int> values
});




}
/// @nodoc
class __$PhysiqueTableRecordCopyWithImpl<$Res>
    implements _$PhysiqueTableRecordCopyWith<$Res> {
  __$PhysiqueTableRecordCopyWithImpl(this._self, this._then);

  final _PhysiqueTableRecord _self;
  final $Res Function(_PhysiqueTableRecord) _then;

/// Create a copy of PhysiqueTableRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCategory = null,Object? level = null,Object? anntenaCategory = null,Object? lineOffset = null,Object? values = null,}) {
  return _then(_PhysiqueTableRecord(
statusCategory: null == statusCategory ? _self.statusCategory : statusCategory // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,lineOffset: null == lineOffset ? _self.lineOffset : lineOffset // ignore: cast_nullable_to_non_nullable
as int,values: null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
