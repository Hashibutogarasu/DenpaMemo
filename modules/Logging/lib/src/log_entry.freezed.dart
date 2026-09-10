// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogEntry {

 String get id; DateTime get timestamp; LogLevel get level;
/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogEntryCopyWith<LogEntry> get copyWith => _$LogEntryCopyWithImpl<LogEntry>(this as LogEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.level, level) || other.level == level));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,level);

@override
String toString() {
  return 'LogEntry(id: $id, timestamp: $timestamp, level: $level)';
}


}

/// @nodoc
abstract mixin class $LogEntryCopyWith<$Res>  {
  factory $LogEntryCopyWith(LogEntry value, $Res Function(LogEntry) _then) = _$LogEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime timestamp, LogLevel level
});




}
/// @nodoc
class _$LogEntryCopyWithImpl<$Res>
    implements $LogEntryCopyWith<$Res> {
  _$LogEntryCopyWithImpl(this._self, this._then);

  final LogEntry _self;
  final $Res Function(LogEntry) _then;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,Object? level = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LogLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [LogEntry].
extension LogEntryPatterns on LogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MessageLogEntry value)?  message,TResult Function( WidgetRebuildLogEntry value)?  widgetRebuild,TResult Function( NetworkLogEntry value)?  network,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MessageLogEntry() when message != null:
return message(_that);case WidgetRebuildLogEntry() when widgetRebuild != null:
return widgetRebuild(_that);case NetworkLogEntry() when network != null:
return network(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MessageLogEntry value)  message,required TResult Function( WidgetRebuildLogEntry value)  widgetRebuild,required TResult Function( NetworkLogEntry value)  network,}){
final _that = this;
switch (_that) {
case MessageLogEntry():
return message(_that);case WidgetRebuildLogEntry():
return widgetRebuild(_that);case NetworkLogEntry():
return network(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MessageLogEntry value)?  message,TResult? Function( WidgetRebuildLogEntry value)?  widgetRebuild,TResult? Function( NetworkLogEntry value)?  network,}){
final _that = this;
switch (_that) {
case MessageLogEntry() when message != null:
return message(_that);case WidgetRebuildLogEntry() when widgetRebuild != null:
return widgetRebuild(_that);case NetworkLogEntry() when network != null:
return network(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  DateTime timestamp,  LogLevel level,  String message)?  message,TResult Function( String id,  DateTime timestamp,  LogLevel level,  WidgetRebuildLogSource source,  String description)?  widgetRebuild,TResult Function( String id,  DateTime timestamp,  LogLevel level,  NetworkProtocol protocol,  NetworkLogStatus status,  String? operation,  String? uri,  String? requestBody,  String? responseBody,  int? requestBytes,  int? responseBytes,  int? statusCode,  String? errorMessage,  Duration? duration)?  network,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MessageLogEntry() when message != null:
return message(_that.id,_that.timestamp,_that.level,_that.message);case WidgetRebuildLogEntry() when widgetRebuild != null:
return widgetRebuild(_that.id,_that.timestamp,_that.level,_that.source,_that.description);case NetworkLogEntry() when network != null:
return network(_that.id,_that.timestamp,_that.level,_that.protocol,_that.status,_that.operation,_that.uri,_that.requestBody,_that.responseBody,_that.requestBytes,_that.responseBytes,_that.statusCode,_that.errorMessage,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  DateTime timestamp,  LogLevel level,  String message)  message,required TResult Function( String id,  DateTime timestamp,  LogLevel level,  WidgetRebuildLogSource source,  String description)  widgetRebuild,required TResult Function( String id,  DateTime timestamp,  LogLevel level,  NetworkProtocol protocol,  NetworkLogStatus status,  String? operation,  String? uri,  String? requestBody,  String? responseBody,  int? requestBytes,  int? responseBytes,  int? statusCode,  String? errorMessage,  Duration? duration)  network,}) {final _that = this;
switch (_that) {
case MessageLogEntry():
return message(_that.id,_that.timestamp,_that.level,_that.message);case WidgetRebuildLogEntry():
return widgetRebuild(_that.id,_that.timestamp,_that.level,_that.source,_that.description);case NetworkLogEntry():
return network(_that.id,_that.timestamp,_that.level,_that.protocol,_that.status,_that.operation,_that.uri,_that.requestBody,_that.responseBody,_that.requestBytes,_that.responseBytes,_that.statusCode,_that.errorMessage,_that.duration);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  DateTime timestamp,  LogLevel level,  String message)?  message,TResult? Function( String id,  DateTime timestamp,  LogLevel level,  WidgetRebuildLogSource source,  String description)?  widgetRebuild,TResult? Function( String id,  DateTime timestamp,  LogLevel level,  NetworkProtocol protocol,  NetworkLogStatus status,  String? operation,  String? uri,  String? requestBody,  String? responseBody,  int? requestBytes,  int? responseBytes,  int? statusCode,  String? errorMessage,  Duration? duration)?  network,}) {final _that = this;
switch (_that) {
case MessageLogEntry() when message != null:
return message(_that.id,_that.timestamp,_that.level,_that.message);case WidgetRebuildLogEntry() when widgetRebuild != null:
return widgetRebuild(_that.id,_that.timestamp,_that.level,_that.source,_that.description);case NetworkLogEntry() when network != null:
return network(_that.id,_that.timestamp,_that.level,_that.protocol,_that.status,_that.operation,_that.uri,_that.requestBody,_that.responseBody,_that.requestBytes,_that.responseBytes,_that.statusCode,_that.errorMessage,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class MessageLogEntry implements LogEntry {
  const MessageLogEntry({required this.id, required this.timestamp, required this.level, required this.message});
  

@override final  String id;
@override final  DateTime timestamp;
@override final  LogLevel level;
 final  String message;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageLogEntryCopyWith<MessageLogEntry> get copyWith => _$MessageLogEntryCopyWithImpl<MessageLogEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.level, level) || other.level == level)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,level,message);

@override
String toString() {
  return 'LogEntry.message(id: $id, timestamp: $timestamp, level: $level, message: $message)';
}


}

/// @nodoc
abstract mixin class $MessageLogEntryCopyWith<$Res> implements $LogEntryCopyWith<$Res> {
  factory $MessageLogEntryCopyWith(MessageLogEntry value, $Res Function(MessageLogEntry) _then) = _$MessageLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, LogLevel level, String message
});




}
/// @nodoc
class _$MessageLogEntryCopyWithImpl<$Res>
    implements $MessageLogEntryCopyWith<$Res> {
  _$MessageLogEntryCopyWithImpl(this._self, this._then);

  final MessageLogEntry _self;
  final $Res Function(MessageLogEntry) _then;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? level = null,Object? message = null,}) {
  return _then(MessageLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LogLevel,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WidgetRebuildLogEntry implements LogEntry {
  const WidgetRebuildLogEntry({required this.id, required this.timestamp, required this.level, required this.source, required this.description});
  

@override final  String id;
@override final  DateTime timestamp;
@override final  LogLevel level;
 final  WidgetRebuildLogSource source;
 final  String description;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetRebuildLogEntryCopyWith<WidgetRebuildLogEntry> get copyWith => _$WidgetRebuildLogEntryCopyWithImpl<WidgetRebuildLogEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetRebuildLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.level, level) || other.level == level)&&(identical(other.source, source) || other.source == source)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,level,source,description);

@override
String toString() {
  return 'LogEntry.widgetRebuild(id: $id, timestamp: $timestamp, level: $level, source: $source, description: $description)';
}


}

/// @nodoc
abstract mixin class $WidgetRebuildLogEntryCopyWith<$Res> implements $LogEntryCopyWith<$Res> {
  factory $WidgetRebuildLogEntryCopyWith(WidgetRebuildLogEntry value, $Res Function(WidgetRebuildLogEntry) _then) = _$WidgetRebuildLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, LogLevel level, WidgetRebuildLogSource source, String description
});




}
/// @nodoc
class _$WidgetRebuildLogEntryCopyWithImpl<$Res>
    implements $WidgetRebuildLogEntryCopyWith<$Res> {
  _$WidgetRebuildLogEntryCopyWithImpl(this._self, this._then);

  final WidgetRebuildLogEntry _self;
  final $Res Function(WidgetRebuildLogEntry) _then;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? level = null,Object? source = null,Object? description = null,}) {
  return _then(WidgetRebuildLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LogLevel,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as WidgetRebuildLogSource,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkLogEntry implements LogEntry {
  const NetworkLogEntry({required this.id, required this.timestamp, required this.level, required this.protocol, required this.status, this.operation, this.uri, this.requestBody, this.responseBody, this.requestBytes, this.responseBytes, this.statusCode, this.errorMessage, this.duration});
  

@override final  String id;
@override final  DateTime timestamp;
@override final  LogLevel level;
 final  NetworkProtocol protocol;
 final  NetworkLogStatus status;
 final  String? operation;
 final  String? uri;
 final  String? requestBody;
 final  String? responseBody;
 final  int? requestBytes;
 final  int? responseBytes;
 final  int? statusCode;
 final  String? errorMessage;
 final  Duration? duration;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkLogEntryCopyWith<NetworkLogEntry> get copyWith => _$NetworkLogEntryCopyWithImpl<NetworkLogEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.level, level) || other.level == level)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.status, status) || other.status == status)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.requestBody, requestBody) || other.requestBody == requestBody)&&(identical(other.responseBody, responseBody) || other.responseBody == responseBody)&&(identical(other.requestBytes, requestBytes) || other.requestBytes == requestBytes)&&(identical(other.responseBytes, responseBytes) || other.responseBytes == responseBytes)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,id,timestamp,level,protocol,status,operation,uri,requestBody,responseBody,requestBytes,responseBytes,statusCode,errorMessage,duration);

@override
String toString() {
  return 'LogEntry.network(id: $id, timestamp: $timestamp, level: $level, protocol: $protocol, status: $status, operation: $operation, uri: $uri, requestBody: $requestBody, responseBody: $responseBody, requestBytes: $requestBytes, responseBytes: $responseBytes, statusCode: $statusCode, errorMessage: $errorMessage, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $NetworkLogEntryCopyWith<$Res> implements $LogEntryCopyWith<$Res> {
  factory $NetworkLogEntryCopyWith(NetworkLogEntry value, $Res Function(NetworkLogEntry) _then) = _$NetworkLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, LogLevel level, NetworkProtocol protocol, NetworkLogStatus status, String? operation, String? uri, String? requestBody, String? responseBody, int? requestBytes, int? responseBytes, int? statusCode, String? errorMessage, Duration? duration
});




}
/// @nodoc
class _$NetworkLogEntryCopyWithImpl<$Res>
    implements $NetworkLogEntryCopyWith<$Res> {
  _$NetworkLogEntryCopyWithImpl(this._self, this._then);

  final NetworkLogEntry _self;
  final $Res Function(NetworkLogEntry) _then;

/// Create a copy of LogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? level = null,Object? protocol = null,Object? status = null,Object? operation = freezed,Object? uri = freezed,Object? requestBody = freezed,Object? responseBody = freezed,Object? requestBytes = freezed,Object? responseBytes = freezed,Object? statusCode = freezed,Object? errorMessage = freezed,Object? duration = freezed,}) {
  return _then(NetworkLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LogLevel,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as NetworkProtocol,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NetworkLogStatus,operation: freezed == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String?,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,requestBody: freezed == requestBody ? _self.requestBody : requestBody // ignore: cast_nullable_to_non_nullable
as String?,responseBody: freezed == responseBody ? _self.responseBody : responseBody // ignore: cast_nullable_to_non_nullable
as String?,requestBytes: freezed == requestBytes ? _self.requestBytes : requestBytes // ignore: cast_nullable_to_non_nullable
as int?,responseBytes: freezed == responseBytes ? _self.responseBytes : responseBytes // ignore: cast_nullable_to_non_nullable
as int?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
