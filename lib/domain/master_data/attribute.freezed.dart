// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Attribute {

 String get id; int get index; bool get isElemental; List<Attribute> get resistantTo; List<Attribute> get weakTo;
/// Create a copy of Attribute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributeCopyWith<Attribute> get copyWith => _$AttributeCopyWithImpl<Attribute>(this as Attribute, _$identity);

  /// Serializes this Attribute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attribute&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.isElemental, isElemental) || other.isElemental == isElemental)&&const DeepCollectionEquality().equals(other.resistantTo, resistantTo)&&const DeepCollectionEquality().equals(other.weakTo, weakTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,index,isElemental,const DeepCollectionEquality().hash(resistantTo),const DeepCollectionEquality().hash(weakTo));

@override
String toString() {
  return 'Attribute(id: $id, index: $index, isElemental: $isElemental, resistantTo: $resistantTo, weakTo: $weakTo)';
}


}

/// @nodoc
abstract mixin class $AttributeCopyWith<$Res>  {
  factory $AttributeCopyWith(Attribute value, $Res Function(Attribute) _then) = _$AttributeCopyWithImpl;
@useResult
$Res call({
 String id, int index, bool isElemental, List<Attribute> resistantTo, List<Attribute> weakTo
});




}
/// @nodoc
class _$AttributeCopyWithImpl<$Res>
    implements $AttributeCopyWith<$Res> {
  _$AttributeCopyWithImpl(this._self, this._then);

  final Attribute _self;
  final $Res Function(Attribute) _then;

/// Create a copy of Attribute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? index = null,Object? isElemental = null,Object? resistantTo = null,Object? weakTo = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,isElemental: null == isElemental ? _self.isElemental : isElemental // ignore: cast_nullable_to_non_nullable
as bool,resistantTo: null == resistantTo ? _self.resistantTo : resistantTo // ignore: cast_nullable_to_non_nullable
as List<Attribute>,weakTo: null == weakTo ? _self.weakTo : weakTo // ignore: cast_nullable_to_non_nullable
as List<Attribute>,
  ));
}

}


/// Adds pattern-matching-related methods to [Attribute].
extension AttributePatterns on Attribute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attribute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attribute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attribute value)  $default,){
final _that = this;
switch (_that) {
case _Attribute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attribute value)?  $default,){
final _that = this;
switch (_that) {
case _Attribute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int index,  bool isElemental,  List<Attribute> resistantTo,  List<Attribute> weakTo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attribute() when $default != null:
return $default(_that.id,_that.index,_that.isElemental,_that.resistantTo,_that.weakTo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int index,  bool isElemental,  List<Attribute> resistantTo,  List<Attribute> weakTo)  $default,) {final _that = this;
switch (_that) {
case _Attribute():
return $default(_that.id,_that.index,_that.isElemental,_that.resistantTo,_that.weakTo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int index,  bool isElemental,  List<Attribute> resistantTo,  List<Attribute> weakTo)?  $default,) {final _that = this;
switch (_that) {
case _Attribute() when $default != null:
return $default(_that.id,_that.index,_that.isElemental,_that.resistantTo,_that.weakTo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Attribute implements Attribute {
  const _Attribute({required this.id, required this.index, this.isElemental = true, final  List<Attribute> resistantTo = const <Attribute>[], final  List<Attribute> weakTo = const <Attribute>[]}): _resistantTo = resistantTo,_weakTo = weakTo;
  factory _Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);

@override final  String id;
@override final  int index;
@override@JsonKey() final  bool isElemental;
 final  List<Attribute> _resistantTo;
@override@JsonKey() List<Attribute> get resistantTo {
  if (_resistantTo is EqualUnmodifiableListView) return _resistantTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resistantTo);
}

 final  List<Attribute> _weakTo;
@override@JsonKey() List<Attribute> get weakTo {
  if (_weakTo is EqualUnmodifiableListView) return _weakTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weakTo);
}


/// Create a copy of Attribute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttributeCopyWith<_Attribute> get copyWith => __$AttributeCopyWithImpl<_Attribute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttributeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attribute&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.isElemental, isElemental) || other.isElemental == isElemental)&&const DeepCollectionEquality().equals(other._resistantTo, _resistantTo)&&const DeepCollectionEquality().equals(other._weakTo, _weakTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,index,isElemental,const DeepCollectionEquality().hash(_resistantTo),const DeepCollectionEquality().hash(_weakTo));

@override
String toString() {
  return 'Attribute(id: $id, index: $index, isElemental: $isElemental, resistantTo: $resistantTo, weakTo: $weakTo)';
}


}

/// @nodoc
abstract mixin class _$AttributeCopyWith<$Res> implements $AttributeCopyWith<$Res> {
  factory _$AttributeCopyWith(_Attribute value, $Res Function(_Attribute) _then) = __$AttributeCopyWithImpl;
@override @useResult
$Res call({
 String id, int index, bool isElemental, List<Attribute> resistantTo, List<Attribute> weakTo
});




}
/// @nodoc
class __$AttributeCopyWithImpl<$Res>
    implements _$AttributeCopyWith<$Res> {
  __$AttributeCopyWithImpl(this._self, this._then);

  final _Attribute _self;
  final $Res Function(_Attribute) _then;

/// Create a copy of Attribute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? index = null,Object? isElemental = null,Object? resistantTo = null,Object? weakTo = null,}) {
  return _then(_Attribute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,isElemental: null == isElemental ? _self.isElemental : isElemental // ignore: cast_nullable_to_non_nullable
as bool,resistantTo: null == resistantTo ? _self._resistantTo : resistantTo // ignore: cast_nullable_to_non_nullable
as List<Attribute>,weakTo: null == weakTo ? _self._weakTo : weakTo // ignore: cast_nullable_to_non_nullable
as List<Attribute>,
  ));
}


}

// dart format on
