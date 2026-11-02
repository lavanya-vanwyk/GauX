// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_contracts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouteResponse {

 List<GeoPoint> get points;/// Length of [points] in metres, measured along the geometry.
 double get distanceMeters;
/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteResponseCopyWith<RouteResponse> get copyWith => _$RouteResponseCopyWithImpl<RouteResponse>(this as RouteResponse, _$identity);

  /// Serializes this RouteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RouteResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteResponse&&const DeepCollectionEquality().equals(other.points, _this.points)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RouteResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.points),_this.distanceMeters);
}

@override
String toString() {
  final _this = this as RouteResponse;
  return 'RouteResponse(points: ${_this.points}, distanceMeters: ${_this.distanceMeters})';
}


}

/// @nodoc
abstract mixin class $RouteResponseCopyWith<$Res>  {
  factory $RouteResponseCopyWith(RouteResponse value, $Res Function(RouteResponse) _then) = _$RouteResponseCopyWithImpl;
@useResult
$Res call({
 List<GeoPoint> points, double distanceMeters
});




}
/// @nodoc
class _$RouteResponseCopyWithImpl<$Res>
    implements $RouteResponseCopyWith<$Res> {
  _$RouteResponseCopyWithImpl(this._self, this._then);

  final RouteResponse _self;
  final $Res Function(RouteResponse) _then;

/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? distanceMeters = null,}) {
  return _then(RouteResponse(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteResponse].
extension RouteResponsePatterns on RouteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteResponse value)  $default,){
final _that = this;
switch (_that) {
case _RouteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GeoPoint> points,  double distanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
return $default(_that.points,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GeoPoint> points,  double distanceMeters)  $default,) {final _that = this;
switch (_that) {
case _RouteResponse():
return $default(_that.points,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GeoPoint> points,  double distanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
return $default(_that.points,_that.distanceMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RouteResponse implements RouteResponse {
  const _RouteResponse({required  List<GeoPoint> points, required this.distanceMeters}): _points = points;
  factory _RouteResponse.fromJson(Map<String, dynamic> json) => _$RouteResponseFromJson(json);

 final  List<GeoPoint> _points;
@override List<GeoPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

/// Length of [points] in metres, measured along the geometry.
@override final  double distanceMeters;

/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteResponseCopyWith<_RouteResponse> get copyWith => __$RouteResponseCopyWithImpl<_RouteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteResponse&&const DeepCollectionEquality().equals(other.points, _points)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points),distanceMeters);
}

@override
String toString() {
    return 'RouteResponse(points: $points, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class _$RouteResponseCopyWith<$Res> implements $RouteResponseCopyWith<$Res> {
  factory _$RouteResponseCopyWith(_RouteResponse value, $Res Function(_RouteResponse) _then) = __$RouteResponseCopyWithImpl;
@override @useResult
$Res call({
 List<GeoPoint> points, double distanceMeters
});




}
/// @nodoc
class __$RouteResponseCopyWithImpl<$Res>
    implements _$RouteResponseCopyWith<$Res> {
  __$RouteResponseCopyWithImpl(this._self, this._then);

  final _RouteResponse _self;
  final $Res Function(_RouteResponse) _then;

/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? distanceMeters = null,}) {
  return _then(_RouteResponse(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PlaceDto {

 String get name; GeoPoint get location;
/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDtoCopyWith<PlaceDto> get copyWith => _$PlaceDtoCopyWithImpl<PlaceDto>(this as PlaceDto, _$identity);

  /// Serializes this PlaceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDto&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.location, _this.location) || other.location == _this.location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceDto;
  return Object.hash(runtimeType,_this.name,_this.location);
}

@override
String toString() {
  final _this = this as PlaceDto;
  return 'PlaceDto(name: ${_this.name}, location: ${_this.location})';
}


}

/// @nodoc
abstract mixin class $PlaceDtoCopyWith<$Res>  {
  factory $PlaceDtoCopyWith(PlaceDto value, $Res Function(PlaceDto) _then) = _$PlaceDtoCopyWithImpl;
@useResult
$Res call({
 String name, GeoPoint location
});


$GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class _$PlaceDtoCopyWithImpl<$Res>
    implements $PlaceDtoCopyWith<$Res> {
  _$PlaceDtoCopyWithImpl(this._self, this._then);

  final PlaceDto _self;
  final $Res Function(PlaceDto) _then;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? location = null,}) {
  return _then(PlaceDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}
/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceDto].
extension PlaceDtoPatterns on PlaceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  GeoPoint location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that.name,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  GeoPoint location)  $default,) {final _that = this;
switch (_that) {
case _PlaceDto():
return $default(_that.name,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  GeoPoint location)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDto implements PlaceDto {
  const _PlaceDto({required this.name, required this.location});
  factory _PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);

@override final  String name;
@override final  GeoPoint location;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDtoCopyWith<_PlaceDto> get copyWith => __$PlaceDtoCopyWithImpl<_PlaceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDto&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,location);
}

@override
String toString() {
    return 'PlaceDto(name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$PlaceDtoCopyWith<$Res> implements $PlaceDtoCopyWith<$Res> {
  factory _$PlaceDtoCopyWith(_PlaceDto value, $Res Function(_PlaceDto) _then) = __$PlaceDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, GeoPoint location
});


@override $GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class __$PlaceDtoCopyWithImpl<$Res>
    implements _$PlaceDtoCopyWith<$Res> {
  __$PlaceDtoCopyWithImpl(this._self, this._then);

  final _PlaceDto _self;
  final $Res Function(_PlaceDto) _then;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? location = null,}) {
  return _then(_PlaceDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$PlacesResponse {

 List<PlaceDto> get places;
/// Create a copy of PlacesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesResponseCopyWith<PlacesResponse> get copyWith => _$PlacesResponseCopyWithImpl<PlacesResponse>(this as PlacesResponse, _$identity);

  /// Serializes this PlacesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlacesResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesResponse&&const DeepCollectionEquality().equals(other.places, _this.places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlacesResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.places));
}

@override
String toString() {
  final _this = this as PlacesResponse;
  return 'PlacesResponse(places: ${_this.places})';
}


}

/// @nodoc
abstract mixin class $PlacesResponseCopyWith<$Res>  {
  factory $PlacesResponseCopyWith(PlacesResponse value, $Res Function(PlacesResponse) _then) = _$PlacesResponseCopyWithImpl;
@useResult
$Res call({
 List<PlaceDto> places
});




}
/// @nodoc
class _$PlacesResponseCopyWithImpl<$Res>
    implements $PlacesResponseCopyWith<$Res> {
  _$PlacesResponseCopyWithImpl(this._self, this._then);

  final PlacesResponse _self;
  final $Res Function(PlacesResponse) _then;

/// Create a copy of PlacesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? places = null,}) {
  return _then(PlacesResponse(
places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacesResponse].
extension PlacesResponsePatterns on PlacesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacesResponse value)  $default,){
final _that = this;
switch (_that) {
case _PlacesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PlacesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlaceDto> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacesResponse() when $default != null:
return $default(_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlaceDto> places)  $default,) {final _that = this;
switch (_that) {
case _PlacesResponse():
return $default(_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlaceDto> places)?  $default,) {final _that = this;
switch (_that) {
case _PlacesResponse() when $default != null:
return $default(_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacesResponse implements PlacesResponse {
  const _PlacesResponse({required  List<PlaceDto> places}): _places = places;
  factory _PlacesResponse.fromJson(Map<String, dynamic> json) => _$PlacesResponseFromJson(json);

 final  List<PlaceDto> _places;
@override List<PlaceDto> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of PlacesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacesResponseCopyWith<_PlacesResponse> get copyWith => __$PlacesResponseCopyWithImpl<_PlacesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacesResponse&&const DeepCollectionEquality().equals(other.places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_places));
}

@override
String toString() {
    return 'PlacesResponse(places: $places)';
}


}

/// @nodoc
abstract mixin class _$PlacesResponseCopyWith<$Res> implements $PlacesResponseCopyWith<$Res> {
  factory _$PlacesResponseCopyWith(_PlacesResponse value, $Res Function(_PlacesResponse) _then) = __$PlacesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<PlaceDto> places
});




}
/// @nodoc
class __$PlacesResponseCopyWithImpl<$Res>
    implements _$PlacesResponseCopyWith<$Res> {
  __$PlacesResponseCopyWithImpl(this._self, this._then);

  final _PlacesResponse _self;
  final $Res Function(_PlacesResponse) _then;

/// Create a copy of PlacesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? places = null,}) {
  return _then(_PlacesResponse(
places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceDto>,
  ));
}


}


/// @nodoc
mixin _$StationDto {

 String get id; String get name; GeoPoint get location;
/// Create a copy of StationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationDtoCopyWith<StationDto> get copyWith => _$StationDtoCopyWithImpl<StationDto>(this as StationDto, _$identity);

  /// Serializes this StationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StationDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.location, _this.location) || other.location == _this.location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StationDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.location);
}

@override
String toString() {
  final _this = this as StationDto;
  return 'StationDto(id: ${_this.id}, name: ${_this.name}, location: ${_this.location})';
}


}

/// @nodoc
abstract mixin class $StationDtoCopyWith<$Res>  {
  factory $StationDtoCopyWith(StationDto value, $Res Function(StationDto) _then) = _$StationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, GeoPoint location
});


$GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class _$StationDtoCopyWithImpl<$Res>
    implements $StationDtoCopyWith<$Res> {
  _$StationDtoCopyWithImpl(this._self, this._then);

  final StationDto _self;
  final $Res Function(StationDto) _then;

/// Create a copy of StationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,}) {
  return _then(StationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}
/// Create a copy of StationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [StationDto].
extension StationDtoPatterns on StationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationDto value)  $default,){
final _that = this;
switch (_that) {
case _StationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationDto value)?  $default,){
final _that = this;
switch (_that) {
case _StationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  GeoPoint location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationDto() when $default != null:
return $default(_that.id,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  GeoPoint location)  $default,) {final _that = this;
switch (_that) {
case _StationDto():
return $default(_that.id,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  GeoPoint location)?  $default,) {final _that = this;
switch (_that) {
case _StationDto() when $default != null:
return $default(_that.id,_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationDto implements StationDto {
  const _StationDto({required this.id, required this.name, required this.location});
  factory _StationDto.fromJson(Map<String, dynamic> json) => _$StationDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  GeoPoint location;

/// Create a copy of StationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationDtoCopyWith<_StationDto> get copyWith => __$StationDtoCopyWithImpl<_StationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,location);
}

@override
String toString() {
    return 'StationDto(id: $id, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$StationDtoCopyWith<$Res> implements $StationDtoCopyWith<$Res> {
  factory _$StationDtoCopyWith(_StationDto value, $Res Function(_StationDto) _then) = __$StationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, GeoPoint location
});


@override $GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class __$StationDtoCopyWithImpl<$Res>
    implements _$StationDtoCopyWith<$Res> {
  __$StationDtoCopyWithImpl(this._self, this._then);

  final _StationDto _self;
  final $Res Function(_StationDto) _then;

/// Create a copy of StationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,}) {
  return _then(_StationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}

/// Create a copy of StationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$StationsResponse {

 List<StationDto> get stations;
/// Create a copy of StationsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationsResponseCopyWith<StationsResponse> get copyWith => _$StationsResponseCopyWithImpl<StationsResponse>(this as StationsResponse, _$identity);

  /// Serializes this StationsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StationsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationsResponse&&const DeepCollectionEquality().equals(other.stations, _this.stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StationsResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.stations));
}

@override
String toString() {
  final _this = this as StationsResponse;
  return 'StationsResponse(stations: ${_this.stations})';
}


}

/// @nodoc
abstract mixin class $StationsResponseCopyWith<$Res>  {
  factory $StationsResponseCopyWith(StationsResponse value, $Res Function(StationsResponse) _then) = _$StationsResponseCopyWithImpl;
@useResult
$Res call({
 List<StationDto> stations
});




}
/// @nodoc
class _$StationsResponseCopyWithImpl<$Res>
    implements $StationsResponseCopyWith<$Res> {
  _$StationsResponseCopyWithImpl(this._self, this._then);

  final StationsResponse _self;
  final $Res Function(StationsResponse) _then;

/// Create a copy of StationsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stations = null,}) {
  return _then(StationsResponse(
stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [StationsResponse].
extension StationsResponsePatterns on StationsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationsResponse value)  $default,){
final _that = this;
switch (_that) {
case _StationsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StationsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StationDto> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationsResponse() when $default != null:
return $default(_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StationDto> stations)  $default,) {final _that = this;
switch (_that) {
case _StationsResponse():
return $default(_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StationDto> stations)?  $default,) {final _that = this;
switch (_that) {
case _StationsResponse() when $default != null:
return $default(_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationsResponse implements StationsResponse {
  const _StationsResponse({required  List<StationDto> stations}): _stations = stations;
  factory _StationsResponse.fromJson(Map<String, dynamic> json) => _$StationsResponseFromJson(json);

 final  List<StationDto> _stations;
@override List<StationDto> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of StationsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationsResponseCopyWith<_StationsResponse> get copyWith => __$StationsResponseCopyWithImpl<_StationsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationsResponse&&const DeepCollectionEquality().equals(other.stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_stations));
}

@override
String toString() {
    return 'StationsResponse(stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$StationsResponseCopyWith<$Res> implements $StationsResponseCopyWith<$Res> {
  factory _$StationsResponseCopyWith(_StationsResponse value, $Res Function(_StationsResponse) _then) = __$StationsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<StationDto> stations
});




}
/// @nodoc
class __$StationsResponseCopyWithImpl<$Res>
    implements _$StationsResponseCopyWith<$Res> {
  __$StationsResponseCopyWithImpl(this._self, this._then);

  final _StationsResponse _self;
  final $Res Function(_StationsResponse) _then;

/// Create a copy of StationsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stations = null,}) {
  return _then(_StationsResponse(
stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationDto>,
  ));
}


}

// dart format on
