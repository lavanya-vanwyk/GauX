// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverLocation {

 LatLng get position;/// Metres travelled along the route since the trip started.
 double get totalDistanceCovered;/// Compass bearing in degrees, 0 = north.
 double get heading;
/// Create a copy of DriverLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverLocationCopyWith<DriverLocation> get copyWith => _$DriverLocationCopyWithImpl<DriverLocation>(this as DriverLocation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DriverLocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverLocation&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.totalDistanceCovered, _this.totalDistanceCovered) || other.totalDistanceCovered == _this.totalDistanceCovered)&&(identical(other.heading, _this.heading) || other.heading == _this.heading));
}


@override
int get hashCode {
  final _this = this as DriverLocation;
  return Object.hash(runtimeType,_this.position,_this.totalDistanceCovered,_this.heading);
}

@override
String toString() {
  final _this = this as DriverLocation;
  return 'DriverLocation(position: ${_this.position}, totalDistanceCovered: ${_this.totalDistanceCovered}, heading: ${_this.heading})';
}


}

/// @nodoc
abstract mixin class $DriverLocationCopyWith<$Res>  {
  factory $DriverLocationCopyWith(DriverLocation value, $Res Function(DriverLocation) _then) = _$DriverLocationCopyWithImpl;
@useResult
$Res call({
 LatLng position, double totalDistanceCovered, double heading
});




}
/// @nodoc
class _$DriverLocationCopyWithImpl<$Res>
    implements $DriverLocationCopyWith<$Res> {
  _$DriverLocationCopyWithImpl(this._self, this._then);

  final DriverLocation _self;
  final $Res Function(DriverLocation) _then;

/// Create a copy of DriverLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? totalDistanceCovered = null,Object? heading = null,}) {
  return _then(DriverLocation(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,totalDistanceCovered: null == totalDistanceCovered ? _self.totalDistanceCovered : totalDistanceCovered // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverLocation].
extension DriverLocationPatterns on DriverLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverLocation value)  $default,){
final _that = this;
switch (_that) {
case _DriverLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverLocation value)?  $default,){
final _that = this;
switch (_that) {
case _DriverLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatLng position,  double totalDistanceCovered,  double heading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverLocation() when $default != null:
return $default(_that.position,_that.totalDistanceCovered,_that.heading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatLng position,  double totalDistanceCovered,  double heading)  $default,) {final _that = this;
switch (_that) {
case _DriverLocation():
return $default(_that.position,_that.totalDistanceCovered,_that.heading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatLng position,  double totalDistanceCovered,  double heading)?  $default,) {final _that = this;
switch (_that) {
case _DriverLocation() when $default != null:
return $default(_that.position,_that.totalDistanceCovered,_that.heading);case _:
  return null;

}
}

}

/// @nodoc


class _DriverLocation implements DriverLocation {
  const _DriverLocation({required this.position, required this.totalDistanceCovered, this.heading = 0.0});
  

@override final  LatLng position;
/// Metres travelled along the route since the trip started.
@override final  double totalDistanceCovered;
/// Compass bearing in degrees, 0 = north.
@override@JsonKey() final  double heading;

/// Create a copy of DriverLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverLocationCopyWith<_DriverLocation> get copyWith => __$DriverLocationCopyWithImpl<_DriverLocation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverLocation&&(identical(other.position, position) || other.position == position)&&(identical(other.totalDistanceCovered, totalDistanceCovered) || other.totalDistanceCovered == totalDistanceCovered)&&(identical(other.heading, heading) || other.heading == heading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,position,totalDistanceCovered,heading);
}

@override
String toString() {
    return 'DriverLocation(position: $position, totalDistanceCovered: $totalDistanceCovered, heading: $heading)';
}


}

/// @nodoc
abstract mixin class _$DriverLocationCopyWith<$Res> implements $DriverLocationCopyWith<$Res> {
  factory _$DriverLocationCopyWith(_DriverLocation value, $Res Function(_DriverLocation) _then) = __$DriverLocationCopyWithImpl;
@override @useResult
$Res call({
 LatLng position, double totalDistanceCovered, double heading
});




}
/// @nodoc
class __$DriverLocationCopyWithImpl<$Res>
    implements _$DriverLocationCopyWith<$Res> {
  __$DriverLocationCopyWithImpl(this._self, this._then);

  final _DriverLocation _self;
  final $Res Function(_DriverLocation) _then;

/// Create a copy of DriverLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? totalDistanceCovered = null,Object? heading = null,}) {
  return _then(_DriverLocation(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,totalDistanceCovered: null == totalDistanceCovered ? _self.totalDistanceCovered : totalDistanceCovered // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
