// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driving_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DrivingRoute {

 List<LatLng> get points; double get distanceMeters;
/// Create a copy of DrivingRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrivingRouteCopyWith<DrivingRoute> get copyWith => _$DrivingRouteCopyWithImpl<DrivingRoute>(this as DrivingRoute, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DrivingRoute;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrivingRoute&&const DeepCollectionEquality().equals(other.points, _this.points)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters));
}


@override
int get hashCode {
  final _this = this as DrivingRoute;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.points),_this.distanceMeters);
}

@override
String toString() {
  final _this = this as DrivingRoute;
  return 'DrivingRoute(points: ${_this.points}, distanceMeters: ${_this.distanceMeters})';
}


}

/// @nodoc
abstract mixin class $DrivingRouteCopyWith<$Res>  {
  factory $DrivingRouteCopyWith(DrivingRoute value, $Res Function(DrivingRoute) _then) = _$DrivingRouteCopyWithImpl;
@useResult
$Res call({
 List<LatLng> points, double distanceMeters
});




}
/// @nodoc
class _$DrivingRouteCopyWithImpl<$Res>
    implements $DrivingRouteCopyWith<$Res> {
  _$DrivingRouteCopyWithImpl(this._self, this._then);

  final DrivingRoute _self;
  final $Res Function(DrivingRoute) _then;

/// Create a copy of DrivingRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? distanceMeters = null,}) {
  return _then(DrivingRoute(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DrivingRoute].
extension DrivingRoutePatterns on DrivingRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DrivingRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DrivingRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DrivingRoute value)  $default,){
final _that = this;
switch (_that) {
case _DrivingRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DrivingRoute value)?  $default,){
final _that = this;
switch (_that) {
case _DrivingRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LatLng> points,  double distanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DrivingRoute() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LatLng> points,  double distanceMeters)  $default,) {final _that = this;
switch (_that) {
case _DrivingRoute():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LatLng> points,  double distanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _DrivingRoute() when $default != null:
return $default(_that.points,_that.distanceMeters);case _:
  return null;

}
}

}

/// @nodoc


class _DrivingRoute implements DrivingRoute {
  const _DrivingRoute({required  List<LatLng> points, required this.distanceMeters}): _points = points;
  

 final  List<LatLng> _points;
@override List<LatLng> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  double distanceMeters;

/// Create a copy of DrivingRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrivingRouteCopyWith<_DrivingRoute> get copyWith => __$DrivingRouteCopyWithImpl<_DrivingRoute>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DrivingRoute&&const DeepCollectionEquality().equals(other.points, _points)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points),distanceMeters);
}

@override
String toString() {
    return 'DrivingRoute(points: $points, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class _$DrivingRouteCopyWith<$Res> implements $DrivingRouteCopyWith<$Res> {
  factory _$DrivingRouteCopyWith(_DrivingRoute value, $Res Function(_DrivingRoute) _then) = __$DrivingRouteCopyWithImpl;
@override @useResult
$Res call({
 List<LatLng> points, double distanceMeters
});




}
/// @nodoc
class __$DrivingRouteCopyWithImpl<$Res>
    implements _$DrivingRouteCopyWith<$Res> {
  __$DrivingRouteCopyWithImpl(this._self, this._then);

  final _DrivingRoute _self;
  final $Res Function(_DrivingRoute) _then;

/// Create a copy of DrivingRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? distanceMeters = null,}) {
  return _then(_DrivingRoute(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
