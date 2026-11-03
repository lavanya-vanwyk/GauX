// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'osrm_route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OsrmRouteResponse {

 List<OsrmRoute> get routes;
/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OsrmRouteResponseCopyWith<OsrmRouteResponse> get copyWith => _$OsrmRouteResponseCopyWithImpl<OsrmRouteResponse>(this as OsrmRouteResponse, _$identity);

  /// Serializes this OsrmRouteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OsrmRouteResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OsrmRouteResponse&&const DeepCollectionEquality().equals(other.routes, _this.routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OsrmRouteResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.routes));
}

@override
String toString() {
  final _this = this as OsrmRouteResponse;
  return 'OsrmRouteResponse(routes: ${_this.routes})';
}


}

/// @nodoc
abstract mixin class $OsrmRouteResponseCopyWith<$Res>  {
  factory $OsrmRouteResponseCopyWith(OsrmRouteResponse value, $Res Function(OsrmRouteResponse) _then) = _$OsrmRouteResponseCopyWithImpl;
@useResult
$Res call({
 List<OsrmRoute> routes
});




}
/// @nodoc
class _$OsrmRouteResponseCopyWithImpl<$Res>
    implements $OsrmRouteResponseCopyWith<$Res> {
  _$OsrmRouteResponseCopyWithImpl(this._self, this._then);

  final OsrmRouteResponse _self;
  final $Res Function(OsrmRouteResponse) _then;

/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routes = null,}) {
  return _then(OsrmRouteResponse(
routes: null == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<OsrmRoute>,
  ));
}

}


/// Adds pattern-matching-related methods to [OsrmRouteResponse].
extension OsrmRouteResponsePatterns on OsrmRouteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OsrmRouteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OsrmRouteResponse value)  $default,){
final _that = this;
switch (_that) {
case _OsrmRouteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OsrmRouteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OsrmRoute> routes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
return $default(_that.routes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OsrmRoute> routes)  $default,) {final _that = this;
switch (_that) {
case _OsrmRouteResponse():
return $default(_that.routes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OsrmRoute> routes)?  $default,) {final _that = this;
switch (_that) {
case _OsrmRouteResponse() when $default != null:
return $default(_that.routes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OsrmRouteResponse implements OsrmRouteResponse {
  const _OsrmRouteResponse({ List<OsrmRoute> routes = const <OsrmRoute>[]}): _routes = routes;
  factory _OsrmRouteResponse.fromJson(Map<String, dynamic> json) => _$OsrmRouteResponseFromJson(json);

 final  List<OsrmRoute> _routes;
@override@JsonKey() List<OsrmRoute> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OsrmRouteResponseCopyWith<_OsrmRouteResponse> get copyWith => __$OsrmRouteResponseCopyWithImpl<_OsrmRouteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OsrmRouteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OsrmRouteResponse&&const DeepCollectionEquality().equals(other.routes, _routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_routes));
}

@override
String toString() {
    return 'OsrmRouteResponse(routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$OsrmRouteResponseCopyWith<$Res> implements $OsrmRouteResponseCopyWith<$Res> {
  factory _$OsrmRouteResponseCopyWith(_OsrmRouteResponse value, $Res Function(_OsrmRouteResponse) _then) = __$OsrmRouteResponseCopyWithImpl;
@override @useResult
$Res call({
 List<OsrmRoute> routes
});




}
/// @nodoc
class __$OsrmRouteResponseCopyWithImpl<$Res>
    implements _$OsrmRouteResponseCopyWith<$Res> {
  __$OsrmRouteResponseCopyWithImpl(this._self, this._then);

  final _OsrmRouteResponse _self;
  final $Res Function(_OsrmRouteResponse) _then;

/// Create a copy of OsrmRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routes = null,}) {
  return _then(_OsrmRouteResponse(
routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<OsrmRoute>,
  ));
}


}


/// @nodoc
mixin _$OsrmRoute {

 OsrmGeometry get geometry;
/// Create a copy of OsrmRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OsrmRouteCopyWith<OsrmRoute> get copyWith => _$OsrmRouteCopyWithImpl<OsrmRoute>(this as OsrmRoute, _$identity);

  /// Serializes this OsrmRoute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OsrmRoute;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OsrmRoute&&(identical(other.geometry, _this.geometry) || other.geometry == _this.geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OsrmRoute;
  return Object.hash(runtimeType,_this.geometry);
}

@override
String toString() {
  final _this = this as OsrmRoute;
  return 'OsrmRoute(geometry: ${_this.geometry})';
}


}

/// @nodoc
abstract mixin class $OsrmRouteCopyWith<$Res>  {
  factory $OsrmRouteCopyWith(OsrmRoute value, $Res Function(OsrmRoute) _then) = _$OsrmRouteCopyWithImpl;
@useResult
$Res call({
 OsrmGeometry geometry
});


$OsrmGeometryCopyWith<$Res> get geometry;

}
/// @nodoc
class _$OsrmRouteCopyWithImpl<$Res>
    implements $OsrmRouteCopyWith<$Res> {
  _$OsrmRouteCopyWithImpl(this._self, this._then);

  final OsrmRoute _self;
  final $Res Function(OsrmRoute) _then;

/// Create a copy of OsrmRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? geometry = null,}) {
  return _then(OsrmRoute(
geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as OsrmGeometry,
  ));
}
/// Create a copy of OsrmRoute
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OsrmGeometryCopyWith<$Res> get geometry {
  
  return $OsrmGeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// Adds pattern-matching-related methods to [OsrmRoute].
extension OsrmRoutePatterns on OsrmRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OsrmRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OsrmRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OsrmRoute value)  $default,){
final _that = this;
switch (_that) {
case _OsrmRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OsrmRoute value)?  $default,){
final _that = this;
switch (_that) {
case _OsrmRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OsrmGeometry geometry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OsrmRoute() when $default != null:
return $default(_that.geometry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OsrmGeometry geometry)  $default,) {final _that = this;
switch (_that) {
case _OsrmRoute():
return $default(_that.geometry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OsrmGeometry geometry)?  $default,) {final _that = this;
switch (_that) {
case _OsrmRoute() when $default != null:
return $default(_that.geometry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OsrmRoute implements OsrmRoute {
  const _OsrmRoute({required this.geometry});
  factory _OsrmRoute.fromJson(Map<String, dynamic> json) => _$OsrmRouteFromJson(json);

@override final  OsrmGeometry geometry;

/// Create a copy of OsrmRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OsrmRouteCopyWith<_OsrmRoute> get copyWith => __$OsrmRouteCopyWithImpl<_OsrmRoute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OsrmRouteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OsrmRoute&&(identical(other.geometry, geometry) || other.geometry == geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,geometry);
}

@override
String toString() {
    return 'OsrmRoute(geometry: $geometry)';
}


}

/// @nodoc
abstract mixin class _$OsrmRouteCopyWith<$Res> implements $OsrmRouteCopyWith<$Res> {
  factory _$OsrmRouteCopyWith(_OsrmRoute value, $Res Function(_OsrmRoute) _then) = __$OsrmRouteCopyWithImpl;
@override @useResult
$Res call({
 OsrmGeometry geometry
});


@override $OsrmGeometryCopyWith<$Res> get geometry;

}
/// @nodoc
class __$OsrmRouteCopyWithImpl<$Res>
    implements _$OsrmRouteCopyWith<$Res> {
  __$OsrmRouteCopyWithImpl(this._self, this._then);

  final _OsrmRoute _self;
  final $Res Function(_OsrmRoute) _then;

/// Create a copy of OsrmRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? geometry = null,}) {
  return _then(_OsrmRoute(
geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as OsrmGeometry,
  ));
}

/// Create a copy of OsrmRoute
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OsrmGeometryCopyWith<$Res> get geometry {
  
  return $OsrmGeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// @nodoc
mixin _$OsrmGeometry {

 List<List<double>> get coordinates;
/// Create a copy of OsrmGeometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OsrmGeometryCopyWith<OsrmGeometry> get copyWith => _$OsrmGeometryCopyWithImpl<OsrmGeometry>(this as OsrmGeometry, _$identity);

  /// Serializes this OsrmGeometry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OsrmGeometry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OsrmGeometry&&const DeepCollectionEquality().equals(other.coordinates, _this.coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OsrmGeometry;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.coordinates));
}

@override
String toString() {
  final _this = this as OsrmGeometry;
  return 'OsrmGeometry(coordinates: ${_this.coordinates})';
}


}

/// @nodoc
abstract mixin class $OsrmGeometryCopyWith<$Res>  {
  factory $OsrmGeometryCopyWith(OsrmGeometry value, $Res Function(OsrmGeometry) _then) = _$OsrmGeometryCopyWithImpl;
@useResult
$Res call({
 List<List<double>> coordinates
});




}
/// @nodoc
class _$OsrmGeometryCopyWithImpl<$Res>
    implements $OsrmGeometryCopyWith<$Res> {
  _$OsrmGeometryCopyWithImpl(this._self, this._then);

  final OsrmGeometry _self;
  final $Res Function(OsrmGeometry) _then;

/// Create a copy of OsrmGeometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coordinates = null,}) {
  return _then(OsrmGeometry(
coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}

}


/// Adds pattern-matching-related methods to [OsrmGeometry].
extension OsrmGeometryPatterns on OsrmGeometry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OsrmGeometry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OsrmGeometry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OsrmGeometry value)  $default,){
final _that = this;
switch (_that) {
case _OsrmGeometry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OsrmGeometry value)?  $default,){
final _that = this;
switch (_that) {
case _OsrmGeometry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<double>> coordinates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OsrmGeometry() when $default != null:
return $default(_that.coordinates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<double>> coordinates)  $default,) {final _that = this;
switch (_that) {
case _OsrmGeometry():
return $default(_that.coordinates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<double>> coordinates)?  $default,) {final _that = this;
switch (_that) {
case _OsrmGeometry() when $default != null:
return $default(_that.coordinates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OsrmGeometry extends OsrmGeometry {
  const _OsrmGeometry({required  List<List<double>> coordinates}): _coordinates = coordinates,super._();
  factory _OsrmGeometry.fromJson(Map<String, dynamic> json) => _$OsrmGeometryFromJson(json);

 final  List<List<double>> _coordinates;
@override List<List<double>> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}


/// Create a copy of OsrmGeometry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OsrmGeometryCopyWith<_OsrmGeometry> get copyWith => __$OsrmGeometryCopyWithImpl<_OsrmGeometry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OsrmGeometryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OsrmGeometry&&const DeepCollectionEquality().equals(other.coordinates, _coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_coordinates));
}

@override
String toString() {
    return 'OsrmGeometry(coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class _$OsrmGeometryCopyWith<$Res> implements $OsrmGeometryCopyWith<$Res> {
  factory _$OsrmGeometryCopyWith(_OsrmGeometry value, $Res Function(_OsrmGeometry) _then) = __$OsrmGeometryCopyWithImpl;
@override @useResult
$Res call({
 List<List<double>> coordinates
});




}
/// @nodoc
class __$OsrmGeometryCopyWithImpl<$Res>
    implements _$OsrmGeometryCopyWith<$Res> {
  __$OsrmGeometryCopyWithImpl(this._self, this._then);

  final _OsrmGeometry _self;
  final $Res Function(_OsrmGeometry) _then;

/// Create a copy of OsrmGeometry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coordinates = null,}) {
  return _then(_OsrmGeometry(
coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<List<double>>,
  ));
}


}

// dart format on
