// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_contracts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteRequest {

 GeoPoint get from; GeoPoint get to; RideKind get rideType;
/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteRequestCopyWith<QuoteRequest> get copyWith => _$QuoteRequestCopyWithImpl<QuoteRequest>(this as QuoteRequest, _$identity);

  /// Serializes this QuoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuoteRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteRequest&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to)&&(identical(other.rideType, _this.rideType) || other.rideType == _this.rideType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuoteRequest;
  return Object.hash(runtimeType,_this.from,_this.to,_this.rideType);
}

@override
String toString() {
  final _this = this as QuoteRequest;
  return 'QuoteRequest(from: ${_this.from}, to: ${_this.to}, rideType: ${_this.rideType})';
}


}

/// @nodoc
abstract mixin class $QuoteRequestCopyWith<$Res>  {
  factory $QuoteRequestCopyWith(QuoteRequest value, $Res Function(QuoteRequest) _then) = _$QuoteRequestCopyWithImpl;
@useResult
$Res call({
 GeoPoint from, GeoPoint to, RideKind rideType
});


$GeoPointCopyWith<$Res> get from;$GeoPointCopyWith<$Res> get to;

}
/// @nodoc
class _$QuoteRequestCopyWithImpl<$Res>
    implements $QuoteRequestCopyWith<$Res> {
  _$QuoteRequestCopyWithImpl(this._self, this._then);

  final QuoteRequest _self;
  final $Res Function(QuoteRequest) _then;

/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? rideType = null,}) {
  return _then(QuoteRequest(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as GeoPoint,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as GeoPoint,rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideKind,
  ));
}
/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get from {
  
  return $GeoPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get to {
  
  return $GeoPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteRequest].
extension QuoteRequestPatterns on QuoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _QuoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint from,  GeoPoint to,  RideKind rideType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteRequest() when $default != null:
return $default(_that.from,_that.to,_that.rideType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint from,  GeoPoint to,  RideKind rideType)  $default,) {final _that = this;
switch (_that) {
case _QuoteRequest():
return $default(_that.from,_that.to,_that.rideType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint from,  GeoPoint to,  RideKind rideType)?  $default,) {final _that = this;
switch (_that) {
case _QuoteRequest() when $default != null:
return $default(_that.from,_that.to,_that.rideType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteRequest implements QuoteRequest {
  const _QuoteRequest({required this.from, required this.to, required this.rideType});
  factory _QuoteRequest.fromJson(Map<String, dynamic> json) => _$QuoteRequestFromJson(json);

@override final  GeoPoint from;
@override final  GeoPoint to;
@override final  RideKind rideType;

/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteRequestCopyWith<_QuoteRequest> get copyWith => __$QuoteRequestCopyWithImpl<_QuoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteRequest&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.rideType, rideType) || other.rideType == rideType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,from,to,rideType);
}

@override
String toString() {
    return 'QuoteRequest(from: $from, to: $to, rideType: $rideType)';
}


}

/// @nodoc
abstract mixin class _$QuoteRequestCopyWith<$Res> implements $QuoteRequestCopyWith<$Res> {
  factory _$QuoteRequestCopyWith(_QuoteRequest value, $Res Function(_QuoteRequest) _then) = __$QuoteRequestCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint from, GeoPoint to, RideKind rideType
});


@override $GeoPointCopyWith<$Res> get from;@override $GeoPointCopyWith<$Res> get to;

}
/// @nodoc
class __$QuoteRequestCopyWithImpl<$Res>
    implements _$QuoteRequestCopyWith<$Res> {
  __$QuoteRequestCopyWithImpl(this._self, this._then);

  final _QuoteRequest _self;
  final $Res Function(_QuoteRequest) _then;

/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? rideType = null,}) {
  return _then(_QuoteRequest(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as GeoPoint,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as GeoPoint,rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideKind,
  ));
}

/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get from {
  
  return $GeoPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of QuoteRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get to {
  
  return $GeoPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// @nodoc
mixin _$QuoteResponse {

 String get id; RideKind get rideType; double get distanceMeters; int get fareCents; int get etaMinutes; DateTime get expiresAt;
/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteResponseCopyWith<QuoteResponse> get copyWith => _$QuoteResponseCopyWithImpl<QuoteResponse>(this as QuoteResponse, _$identity);

  /// Serializes this QuoteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuoteResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.rideType, _this.rideType) || other.rideType == _this.rideType)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.fareCents, _this.fareCents) || other.fareCents == _this.fareCents)&&(identical(other.etaMinutes, _this.etaMinutes) || other.etaMinutes == _this.etaMinutes)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuoteResponse;
  return Object.hash(runtimeType,_this.id,_this.rideType,_this.distanceMeters,_this.fareCents,_this.etaMinutes,_this.expiresAt);
}

@override
String toString() {
  final _this = this as QuoteResponse;
  return 'QuoteResponse(id: ${_this.id}, rideType: ${_this.rideType}, distanceMeters: ${_this.distanceMeters}, fareCents: ${_this.fareCents}, etaMinutes: ${_this.etaMinutes}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $QuoteResponseCopyWith<$Res>  {
  factory $QuoteResponseCopyWith(QuoteResponse value, $Res Function(QuoteResponse) _then) = _$QuoteResponseCopyWithImpl;
@useResult
$Res call({
 String id, RideKind rideType, double distanceMeters, int fareCents, int etaMinutes, DateTime expiresAt
});




}
/// @nodoc
class _$QuoteResponseCopyWithImpl<$Res>
    implements $QuoteResponseCopyWith<$Res> {
  _$QuoteResponseCopyWithImpl(this._self, this._then);

  final QuoteResponse _self;
  final $Res Function(QuoteResponse) _then;

/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rideType = null,Object? distanceMeters = null,Object? fareCents = null,Object? etaMinutes = null,Object? expiresAt = null,}) {
  return _then(QuoteResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideKind,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,fareCents: null == fareCents ? _self.fareCents : fareCents // ignore: cast_nullable_to_non_nullable
as int,etaMinutes: null == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteResponse].
extension QuoteResponsePatterns on QuoteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteResponse value)  $default,){
final _that = this;
switch (_that) {
case _QuoteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  RideKind rideType,  double distanceMeters,  int fareCents,  int etaMinutes,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
return $default(_that.id,_that.rideType,_that.distanceMeters,_that.fareCents,_that.etaMinutes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  RideKind rideType,  double distanceMeters,  int fareCents,  int etaMinutes,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _QuoteResponse():
return $default(_that.id,_that.rideType,_that.distanceMeters,_that.fareCents,_that.etaMinutes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  RideKind rideType,  double distanceMeters,  int fareCents,  int etaMinutes,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _QuoteResponse() when $default != null:
return $default(_that.id,_that.rideType,_that.distanceMeters,_that.fareCents,_that.etaMinutes,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteResponse implements QuoteResponse {
  const _QuoteResponse({required this.id, required this.rideType, required this.distanceMeters, required this.fareCents, required this.etaMinutes, required this.expiresAt});
  factory _QuoteResponse.fromJson(Map<String, dynamic> json) => _$QuoteResponseFromJson(json);

@override final  String id;
@override final  RideKind rideType;
@override final  double distanceMeters;
@override final  int fareCents;
@override final  int etaMinutes;
@override final  DateTime expiresAt;

/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteResponseCopyWith<_QuoteResponse> get copyWith => __$QuoteResponseCopyWithImpl<_QuoteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.rideType, rideType) || other.rideType == rideType)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.fareCents, fareCents) || other.fareCents == fareCents)&&(identical(other.etaMinutes, etaMinutes) || other.etaMinutes == etaMinutes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,rideType,distanceMeters,fareCents,etaMinutes,expiresAt);
}

@override
String toString() {
    return 'QuoteResponse(id: $id, rideType: $rideType, distanceMeters: $distanceMeters, fareCents: $fareCents, etaMinutes: $etaMinutes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteResponseCopyWith<$Res> implements $QuoteResponseCopyWith<$Res> {
  factory _$QuoteResponseCopyWith(_QuoteResponse value, $Res Function(_QuoteResponse) _then) = __$QuoteResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, RideKind rideType, double distanceMeters, int fareCents, int etaMinutes, DateTime expiresAt
});




}
/// @nodoc
class __$QuoteResponseCopyWithImpl<$Res>
    implements _$QuoteResponseCopyWith<$Res> {
  __$QuoteResponseCopyWithImpl(this._self, this._then);

  final _QuoteResponse _self;
  final $Res Function(_QuoteResponse) _then;

/// Create a copy of QuoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rideType = null,Object? distanceMeters = null,Object? fareCents = null,Object? etaMinutes = null,Object? expiresAt = null,}) {
  return _then(_QuoteResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideKind,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,fareCents: null == fareCents ? _self.fareCents : fareCents // ignore: cast_nullable_to_non_nullable
as int,etaMinutes: null == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ChargeRequest {

 String get quoteId;/// True for a cancelled ride: the server charges a partial fare for
/// [distanceCoveredMeters] instead of the full quote.
 bool get cancelled; double get distanceCoveredMeters;
/// Create a copy of ChargeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChargeRequestCopyWith<ChargeRequest> get copyWith => _$ChargeRequestCopyWithImpl<ChargeRequest>(this as ChargeRequest, _$identity);

  /// Serializes this ChargeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChargeRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChargeRequest&&(identical(other.quoteId, _this.quoteId) || other.quoteId == _this.quoteId)&&(identical(other.cancelled, _this.cancelled) || other.cancelled == _this.cancelled)&&(identical(other.distanceCoveredMeters, _this.distanceCoveredMeters) || other.distanceCoveredMeters == _this.distanceCoveredMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChargeRequest;
  return Object.hash(runtimeType,_this.quoteId,_this.cancelled,_this.distanceCoveredMeters);
}

@override
String toString() {
  final _this = this as ChargeRequest;
  return 'ChargeRequest(quoteId: ${_this.quoteId}, cancelled: ${_this.cancelled}, distanceCoveredMeters: ${_this.distanceCoveredMeters})';
}


}

/// @nodoc
abstract mixin class $ChargeRequestCopyWith<$Res>  {
  factory $ChargeRequestCopyWith(ChargeRequest value, $Res Function(ChargeRequest) _then) = _$ChargeRequestCopyWithImpl;
@useResult
$Res call({
 String quoteId, bool cancelled, double distanceCoveredMeters
});




}
/// @nodoc
class _$ChargeRequestCopyWithImpl<$Res>
    implements $ChargeRequestCopyWith<$Res> {
  _$ChargeRequestCopyWithImpl(this._self, this._then);

  final ChargeRequest _self;
  final $Res Function(ChargeRequest) _then;

/// Create a copy of ChargeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quoteId = null,Object? cancelled = null,Object? distanceCoveredMeters = null,}) {
  return _then(ChargeRequest(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as bool,distanceCoveredMeters: null == distanceCoveredMeters ? _self.distanceCoveredMeters : distanceCoveredMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChargeRequest].
extension ChargeRequestPatterns on ChargeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChargeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChargeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChargeRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChargeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChargeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChargeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quoteId,  bool cancelled,  double distanceCoveredMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChargeRequest() when $default != null:
return $default(_that.quoteId,_that.cancelled,_that.distanceCoveredMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quoteId,  bool cancelled,  double distanceCoveredMeters)  $default,) {final _that = this;
switch (_that) {
case _ChargeRequest():
return $default(_that.quoteId,_that.cancelled,_that.distanceCoveredMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quoteId,  bool cancelled,  double distanceCoveredMeters)?  $default,) {final _that = this;
switch (_that) {
case _ChargeRequest() when $default != null:
return $default(_that.quoteId,_that.cancelled,_that.distanceCoveredMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChargeRequest implements ChargeRequest {
  const _ChargeRequest({required this.quoteId, this.cancelled = false, this.distanceCoveredMeters = 0});
  factory _ChargeRequest.fromJson(Map<String, dynamic> json) => _$ChargeRequestFromJson(json);

@override final  String quoteId;
/// True for a cancelled ride: the server charges a partial fare for
/// [distanceCoveredMeters] instead of the full quote.
@override@JsonKey() final  bool cancelled;
@override@JsonKey() final  double distanceCoveredMeters;

/// Create a copy of ChargeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChargeRequestCopyWith<_ChargeRequest> get copyWith => __$ChargeRequestCopyWithImpl<_ChargeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChargeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChargeRequest&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled)&&(identical(other.distanceCoveredMeters, distanceCoveredMeters) || other.distanceCoveredMeters == distanceCoveredMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quoteId,cancelled,distanceCoveredMeters);
}

@override
String toString() {
    return 'ChargeRequest(quoteId: $quoteId, cancelled: $cancelled, distanceCoveredMeters: $distanceCoveredMeters)';
}


}

/// @nodoc
abstract mixin class _$ChargeRequestCopyWith<$Res> implements $ChargeRequestCopyWith<$Res> {
  factory _$ChargeRequestCopyWith(_ChargeRequest value, $Res Function(_ChargeRequest) _then) = __$ChargeRequestCopyWithImpl;
@override @useResult
$Res call({
 String quoteId, bool cancelled, double distanceCoveredMeters
});




}
/// @nodoc
class __$ChargeRequestCopyWithImpl<$Res>
    implements _$ChargeRequestCopyWith<$Res> {
  __$ChargeRequestCopyWithImpl(this._self, this._then);

  final _ChargeRequest _self;
  final $Res Function(_ChargeRequest) _then;

/// Create a copy of ChargeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quoteId = null,Object? cancelled = null,Object? distanceCoveredMeters = null,}) {
  return _then(_ChargeRequest(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as bool,distanceCoveredMeters: null == distanceCoveredMeters ? _self.distanceCoveredMeters : distanceCoveredMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$HoldRequest {

 String get quoteId;
/// Create a copy of HoldRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoldRequestCopyWith<HoldRequest> get copyWith => _$HoldRequestCopyWithImpl<HoldRequest>(this as HoldRequest, _$identity);

  /// Serializes this HoldRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HoldRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoldRequest&&(identical(other.quoteId, _this.quoteId) || other.quoteId == _this.quoteId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HoldRequest;
  return Object.hash(runtimeType,_this.quoteId);
}

@override
String toString() {
  final _this = this as HoldRequest;
  return 'HoldRequest(quoteId: ${_this.quoteId})';
}


}

/// @nodoc
abstract mixin class $HoldRequestCopyWith<$Res>  {
  factory $HoldRequestCopyWith(HoldRequest value, $Res Function(HoldRequest) _then) = _$HoldRequestCopyWithImpl;
@useResult
$Res call({
 String quoteId
});




}
/// @nodoc
class _$HoldRequestCopyWithImpl<$Res>
    implements $HoldRequestCopyWith<$Res> {
  _$HoldRequestCopyWithImpl(this._self, this._then);

  final HoldRequest _self;
  final $Res Function(HoldRequest) _then;

/// Create a copy of HoldRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quoteId = null,}) {
  return _then(HoldRequest(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HoldRequest].
extension HoldRequestPatterns on HoldRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HoldRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HoldRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HoldRequest value)  $default,){
final _that = this;
switch (_that) {
case _HoldRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HoldRequest value)?  $default,){
final _that = this;
switch (_that) {
case _HoldRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quoteId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HoldRequest() when $default != null:
return $default(_that.quoteId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quoteId)  $default,) {final _that = this;
switch (_that) {
case _HoldRequest():
return $default(_that.quoteId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quoteId)?  $default,) {final _that = this;
switch (_that) {
case _HoldRequest() when $default != null:
return $default(_that.quoteId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HoldRequest implements HoldRequest {
  const _HoldRequest({required this.quoteId});
  factory _HoldRequest.fromJson(Map<String, dynamic> json) => _$HoldRequestFromJson(json);

@override final  String quoteId;

/// Create a copy of HoldRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoldRequestCopyWith<_HoldRequest> get copyWith => __$HoldRequestCopyWithImpl<_HoldRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HoldRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoldRequest&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quoteId);
}

@override
String toString() {
    return 'HoldRequest(quoteId: $quoteId)';
}


}

/// @nodoc
abstract mixin class _$HoldRequestCopyWith<$Res> implements $HoldRequestCopyWith<$Res> {
  factory _$HoldRequestCopyWith(_HoldRequest value, $Res Function(_HoldRequest) _then) = __$HoldRequestCopyWithImpl;
@override @useResult
$Res call({
 String quoteId
});




}
/// @nodoc
class __$HoldRequestCopyWithImpl<$Res>
    implements _$HoldRequestCopyWith<$Res> {
  __$HoldRequestCopyWithImpl(this._self, this._then);

  final _HoldRequest _self;
  final $Res Function(_HoldRequest) _then;

/// Create a copy of HoldRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quoteId = null,}) {
  return _then(_HoldRequest(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TopUpRequest {

 int get amountCents; String get paymentMethod;
/// Create a copy of TopUpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopUpRequestCopyWith<TopUpRequest> get copyWith => _$TopUpRequestCopyWithImpl<TopUpRequest>(this as TopUpRequest, _$identity);

  /// Serializes this TopUpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TopUpRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopUpRequest&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TopUpRequest;
  return Object.hash(runtimeType,_this.amountCents,_this.paymentMethod);
}

@override
String toString() {
  final _this = this as TopUpRequest;
  return 'TopUpRequest(amountCents: ${_this.amountCents}, paymentMethod: ${_this.paymentMethod})';
}


}

/// @nodoc
abstract mixin class $TopUpRequestCopyWith<$Res>  {
  factory $TopUpRequestCopyWith(TopUpRequest value, $Res Function(TopUpRequest) _then) = _$TopUpRequestCopyWithImpl;
@useResult
$Res call({
 int amountCents, String paymentMethod
});




}
/// @nodoc
class _$TopUpRequestCopyWithImpl<$Res>
    implements $TopUpRequestCopyWith<$Res> {
  _$TopUpRequestCopyWithImpl(this._self, this._then);

  final TopUpRequest _self;
  final $Res Function(TopUpRequest) _then;

/// Create a copy of TopUpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amountCents = null,Object? paymentMethod = null,}) {
  return _then(TopUpRequest(
amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TopUpRequest].
extension TopUpRequestPatterns on TopUpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopUpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopUpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopUpRequest value)  $default,){
final _that = this;
switch (_that) {
case _TopUpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopUpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TopUpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amountCents,  String paymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopUpRequest() when $default != null:
return $default(_that.amountCents,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amountCents,  String paymentMethod)  $default,) {final _that = this;
switch (_that) {
case _TopUpRequest():
return $default(_that.amountCents,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amountCents,  String paymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _TopUpRequest() when $default != null:
return $default(_that.amountCents,_that.paymentMethod);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopUpRequest implements TopUpRequest {
  const _TopUpRequest({required this.amountCents, required this.paymentMethod});
  factory _TopUpRequest.fromJson(Map<String, dynamic> json) => _$TopUpRequestFromJson(json);

@override final  int amountCents;
@override final  String paymentMethod;

/// Create a copy of TopUpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopUpRequestCopyWith<_TopUpRequest> get copyWith => __$TopUpRequestCopyWithImpl<_TopUpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopUpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopUpRequest&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,amountCents,paymentMethod);
}

@override
String toString() {
    return 'TopUpRequest(amountCents: $amountCents, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class _$TopUpRequestCopyWith<$Res> implements $TopUpRequestCopyWith<$Res> {
  factory _$TopUpRequestCopyWith(_TopUpRequest value, $Res Function(_TopUpRequest) _then) = __$TopUpRequestCopyWithImpl;
@override @useResult
$Res call({
 int amountCents, String paymentMethod
});




}
/// @nodoc
class __$TopUpRequestCopyWithImpl<$Res>
    implements _$TopUpRequestCopyWith<$Res> {
  __$TopUpRequestCopyWithImpl(this._self, this._then);

  final _TopUpRequest _self;
  final $Res Function(_TopUpRequest) _then;

/// Create a copy of TopUpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amountCents = null,Object? paymentMethod = null,}) {
  return _then(_TopUpRequest(
amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WalletEntryDto {

 String get id; String get kind; String get description; int get amountCents; DateTime get createdAt;
/// Create a copy of WalletEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletEntryDtoCopyWith<WalletEntryDto> get copyWith => _$WalletEntryDtoCopyWithImpl<WalletEntryDto>(this as WalletEntryDto, _$identity);

  /// Serializes this WalletEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalletEntryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletEntryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalletEntryDto;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.description,_this.amountCents,_this.createdAt);
}

@override
String toString() {
  final _this = this as WalletEntryDto;
  return 'WalletEntryDto(id: ${_this.id}, kind: ${_this.kind}, description: ${_this.description}, amountCents: ${_this.amountCents}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $WalletEntryDtoCopyWith<$Res>  {
  factory $WalletEntryDtoCopyWith(WalletEntryDto value, $Res Function(WalletEntryDto) _then) = _$WalletEntryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String kind, String description, int amountCents, DateTime createdAt
});




}
/// @nodoc
class _$WalletEntryDtoCopyWithImpl<$Res>
    implements $WalletEntryDtoCopyWith<$Res> {
  _$WalletEntryDtoCopyWithImpl(this._self, this._then);

  final WalletEntryDto _self;
  final $Res Function(WalletEntryDto) _then;

/// Create a copy of WalletEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? description = null,Object? amountCents = null,Object? createdAt = null,}) {
  return _then(WalletEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletEntryDto].
extension WalletEntryDtoPatterns on WalletEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _WalletEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalletEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String kind,  String description,  int amountCents,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletEntryDto() when $default != null:
return $default(_that.id,_that.kind,_that.description,_that.amountCents,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String kind,  String description,  int amountCents,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletEntryDto():
return $default(_that.id,_that.kind,_that.description,_that.amountCents,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String kind,  String description,  int amountCents,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletEntryDto() when $default != null:
return $default(_that.id,_that.kind,_that.description,_that.amountCents,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletEntryDto implements WalletEntryDto {
  const _WalletEntryDto({required this.id, required this.kind, required this.description, required this.amountCents, required this.createdAt});
  factory _WalletEntryDto.fromJson(Map<String, dynamic> json) => _$WalletEntryDtoFromJson(json);

@override final  String id;
@override final  String kind;
@override final  String description;
@override final  int amountCents;
@override final  DateTime createdAt;

/// Create a copy of WalletEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletEntryDtoCopyWith<_WalletEntryDto> get copyWith => __$WalletEntryDtoCopyWithImpl<_WalletEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.description, description) || other.description == description)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,description,amountCents,createdAt);
}

@override
String toString() {
    return 'WalletEntryDto(id: $id, kind: $kind, description: $description, amountCents: $amountCents, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletEntryDtoCopyWith<$Res> implements $WalletEntryDtoCopyWith<$Res> {
  factory _$WalletEntryDtoCopyWith(_WalletEntryDto value, $Res Function(_WalletEntryDto) _then) = __$WalletEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String kind, String description, int amountCents, DateTime createdAt
});




}
/// @nodoc
class __$WalletEntryDtoCopyWithImpl<$Res>
    implements _$WalletEntryDtoCopyWith<$Res> {
  __$WalletEntryDtoCopyWithImpl(this._self, this._then);

  final _WalletEntryDto _self;
  final $Res Function(_WalletEntryDto) _then;

/// Create a copy of WalletEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? description = null,Object? amountCents = null,Object? createdAt = null,}) {
  return _then(_WalletEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$WalletResponse {

/// Available to spend. Excludes [heldCents].
 int get balanceCents;/// Reserved for rides in progress; settled or returned when they end.
 int get heldCents; String get currency;/// Newest first.
 List<WalletEntryDto> get entries;/// The entry a charge, hold or top-up created (or found, on a retry).
/// Null when nothing touched the wallet directly, e.g. a ride settled
/// exactly from its hold.
 WalletEntryDto? get entry;/// Set by charges: what the rider paid for the quote, in cents. With a
/// hold this differs from [entry], which is then the refund of any
/// unused part.
 int? get chargedCents;
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseCopyWith<WalletResponse> get copyWith => _$WalletResponseCopyWithImpl<WalletResponse>(this as WalletResponse, _$identity);

  /// Serializes this WalletResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WalletResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponse&&(identical(other.balanceCents, _this.balanceCents) || other.balanceCents == _this.balanceCents)&&(identical(other.heldCents, _this.heldCents) || other.heldCents == _this.heldCents)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.chargedCents, _this.chargedCents) || other.chargedCents == _this.chargedCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WalletResponse;
  return Object.hash(runtimeType,_this.balanceCents,_this.heldCents,_this.currency,const DeepCollectionEquality().hash(_this.entries),_this.entry,_this.chargedCents);
}

@override
String toString() {
  final _this = this as WalletResponse;
  return 'WalletResponse(balanceCents: ${_this.balanceCents}, heldCents: ${_this.heldCents}, currency: ${_this.currency}, entries: ${_this.entries}, entry: ${_this.entry}, chargedCents: ${_this.chargedCents})';
}


}

/// @nodoc
abstract mixin class $WalletResponseCopyWith<$Res>  {
  factory $WalletResponseCopyWith(WalletResponse value, $Res Function(WalletResponse) _then) = _$WalletResponseCopyWithImpl;
@useResult
$Res call({
 int balanceCents, int heldCents, String currency, List<WalletEntryDto> entries, WalletEntryDto? entry, int? chargedCents
});


$WalletEntryDtoCopyWith<$Res>? get entry;

}
/// @nodoc
class _$WalletResponseCopyWithImpl<$Res>
    implements $WalletResponseCopyWith<$Res> {
  _$WalletResponseCopyWithImpl(this._self, this._then);

  final WalletResponse _self;
  final $Res Function(WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balanceCents = null,Object? heldCents = null,Object? currency = null,Object? entries = null,Object? entry = freezed,Object? chargedCents = freezed,}) {
  return _then(WalletResponse(
balanceCents: null == balanceCents ? _self.balanceCents : balanceCents // ignore: cast_nullable_to_non_nullable
as int,heldCents: null == heldCents ? _self.heldCents : heldCents // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<WalletEntryDto>,entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as WalletEntryDto?,chargedCents: freezed == chargedCents ? _self.chargedCents : chargedCents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletEntryDtoCopyWith<$Res>? get entry {
    if (_self.entry == null) {
    return null;
  }

  return $WalletEntryDtoCopyWith<$Res>(_self.entry!, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalletResponse].
extension WalletResponsePatterns on WalletResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletResponse value)  $default,){
final _that = this;
switch (_that) {
case _WalletResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int balanceCents,  int heldCents,  String currency,  List<WalletEntryDto> entries,  WalletEntryDto? entry,  int? chargedCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.balanceCents,_that.heldCents,_that.currency,_that.entries,_that.entry,_that.chargedCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int balanceCents,  int heldCents,  String currency,  List<WalletEntryDto> entries,  WalletEntryDto? entry,  int? chargedCents)  $default,) {final _that = this;
switch (_that) {
case _WalletResponse():
return $default(_that.balanceCents,_that.heldCents,_that.currency,_that.entries,_that.entry,_that.chargedCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int balanceCents,  int heldCents,  String currency,  List<WalletEntryDto> entries,  WalletEntryDto? entry,  int? chargedCents)?  $default,) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.balanceCents,_that.heldCents,_that.currency,_that.entries,_that.entry,_that.chargedCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletResponse implements WalletResponse {
  const _WalletResponse({required this.balanceCents, this.heldCents = 0, this.currency = 'ZAR', required  List<WalletEntryDto> entries, this.entry, this.chargedCents}): _entries = entries;
  factory _WalletResponse.fromJson(Map<String, dynamic> json) => _$WalletResponseFromJson(json);

/// Available to spend. Excludes [heldCents].
@override final  int balanceCents;
/// Reserved for rides in progress; settled or returned when they end.
@override@JsonKey() final  int heldCents;
@override@JsonKey() final  String currency;
/// Newest first.
 final  List<WalletEntryDto> _entries;
/// Newest first.
@override List<WalletEntryDto> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// The entry a charge, hold or top-up created (or found, on a retry).
/// Null when nothing touched the wallet directly, e.g. a ride settled
/// exactly from its hold.
@override final  WalletEntryDto? entry;
/// Set by charges: what the rider paid for the quote, in cents. With a
/// hold this differs from [entry], which is then the refund of any
/// unused part.
@override final  int? chargedCents;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletResponseCopyWith<_WalletResponse> get copyWith => __$WalletResponseCopyWithImpl<_WalletResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletResponse&&(identical(other.balanceCents, balanceCents) || other.balanceCents == balanceCents)&&(identical(other.heldCents, heldCents) || other.heldCents == heldCents)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.chargedCents, chargedCents) || other.chargedCents == chargedCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,balanceCents,heldCents,currency,const DeepCollectionEquality().hash(_entries),entry,chargedCents);
}

@override
String toString() {
    return 'WalletResponse(balanceCents: $balanceCents, heldCents: $heldCents, currency: $currency, entries: $entries, entry: $entry, chargedCents: $chargedCents)';
}


}

/// @nodoc
abstract mixin class _$WalletResponseCopyWith<$Res> implements $WalletResponseCopyWith<$Res> {
  factory _$WalletResponseCopyWith(_WalletResponse value, $Res Function(_WalletResponse) _then) = __$WalletResponseCopyWithImpl;
@override @useResult
$Res call({
 int balanceCents, int heldCents, String currency, List<WalletEntryDto> entries, WalletEntryDto? entry, int? chargedCents
});


@override $WalletEntryDtoCopyWith<$Res>? get entry;

}
/// @nodoc
class __$WalletResponseCopyWithImpl<$Res>
    implements _$WalletResponseCopyWith<$Res> {
  __$WalletResponseCopyWithImpl(this._self, this._then);

  final _WalletResponse _self;
  final $Res Function(_WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balanceCents = null,Object? heldCents = null,Object? currency = null,Object? entries = null,Object? entry = freezed,Object? chargedCents = freezed,}) {
  return _then(_WalletResponse(
balanceCents: null == balanceCents ? _self.balanceCents : balanceCents // ignore: cast_nullable_to_non_nullable
as int,heldCents: null == heldCents ? _self.heldCents : heldCents // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<WalletEntryDto>,entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as WalletEntryDto?,chargedCents: freezed == chargedCents ? _self.chargedCents : chargedCents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletEntryDtoCopyWith<$Res>? get entry {
    if (_self.entry == null) {
    return null;
  }

  return $WalletEntryDtoCopyWith<$Res>(_self.entry!, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}

// dart format on
