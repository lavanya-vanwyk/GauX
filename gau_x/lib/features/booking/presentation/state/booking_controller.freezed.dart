// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingState implements DiagnosticableTreeMixin {

 LatLng? get destination; DrivingRoute? get route;/// Null until a route is loaded.
 RideQuote? get quote; RideType get rideType; bool get isLoadingRoute; bool get isSearchingAddress;
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateCopyWith<BookingState> get copyWith => _$BookingStateCopyWithImpl<BookingState>(this as BookingState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as BookingState;
  properties
    ..add(DiagnosticsProperty('type', 'BookingState'))
    ..add(DiagnosticsProperty('destination', _this.destination))..add(DiagnosticsProperty('route', _this.route))..add(DiagnosticsProperty('quote', _this.quote))..add(DiagnosticsProperty('rideType', _this.rideType))..add(DiagnosticsProperty('isLoadingRoute', _this.isLoadingRoute))..add(DiagnosticsProperty('isSearchingAddress', _this.isSearchingAddress));
}

@override
bool operator ==(Object other) {
  final _this = this as BookingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState&&(identical(other.destination, _this.destination) || other.destination == _this.destination)&&(identical(other.route, _this.route) || other.route == _this.route)&&(identical(other.quote, _this.quote) || other.quote == _this.quote)&&(identical(other.rideType, _this.rideType) || other.rideType == _this.rideType)&&(identical(other.isLoadingRoute, _this.isLoadingRoute) || other.isLoadingRoute == _this.isLoadingRoute)&&(identical(other.isSearchingAddress, _this.isSearchingAddress) || other.isSearchingAddress == _this.isSearchingAddress));
}


@override
int get hashCode {
  final _this = this as BookingState;
  return Object.hash(runtimeType,_this.destination,_this.route,_this.quote,_this.rideType,_this.isLoadingRoute,_this.isSearchingAddress);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as BookingState;
  return 'BookingState(destination: ${_this.destination}, route: ${_this.route}, quote: ${_this.quote}, rideType: ${_this.rideType}, isLoadingRoute: ${_this.isLoadingRoute}, isSearchingAddress: ${_this.isSearchingAddress})';
}


}

/// @nodoc
abstract mixin class $BookingStateCopyWith<$Res>  {
  factory $BookingStateCopyWith(BookingState value, $Res Function(BookingState) _then) = _$BookingStateCopyWithImpl;
@useResult
$Res call({
 LatLng? destination, DrivingRoute? route, RideQuote? quote, RideType rideType, bool isLoadingRoute, bool isSearchingAddress
});


$DrivingRouteCopyWith<$Res>? get route;$RideQuoteCopyWith<$Res>? get quote;

}
/// @nodoc
class _$BookingStateCopyWithImpl<$Res>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._self, this._then);

  final BookingState _self;
  final $Res Function(BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destination = freezed,Object? route = freezed,Object? quote = freezed,Object? rideType = null,Object? isLoadingRoute = null,Object? isSearchingAddress = null,}) {
  return _then(BookingState(
destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LatLng?,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as DrivingRoute?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote?,rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideType,isLoadingRoute: null == isLoadingRoute ? _self.isLoadingRoute : isLoadingRoute // ignore: cast_nullable_to_non_nullable
as bool,isSearchingAddress: null == isSearchingAddress ? _self.isSearchingAddress : isSearchingAddress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DrivingRouteCopyWith<$Res>? get route {
    if (_self.route == null) {
    return null;
  }

  return $DrivingRouteCopyWith<$Res>(_self.route!, (value) {
    return _then(_self.copyWith(route: value));
  });
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res>? get quote {
    if (_self.quote == null) {
    return null;
  }

  return $RideQuoteCopyWith<$Res>(_self.quote!, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingState].
extension BookingStatePatterns on BookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingState value)  $default,){
final _that = this;
switch (_that) {
case _BookingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatLng? destination,  DrivingRoute? route,  RideQuote? quote,  RideType rideType,  bool isLoadingRoute,  bool isSearchingAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingState() when $default != null:
return $default(_that.destination,_that.route,_that.quote,_that.rideType,_that.isLoadingRoute,_that.isSearchingAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatLng? destination,  DrivingRoute? route,  RideQuote? quote,  RideType rideType,  bool isLoadingRoute,  bool isSearchingAddress)  $default,) {final _that = this;
switch (_that) {
case _BookingState():
return $default(_that.destination,_that.route,_that.quote,_that.rideType,_that.isLoadingRoute,_that.isSearchingAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatLng? destination,  DrivingRoute? route,  RideQuote? quote,  RideType rideType,  bool isLoadingRoute,  bool isSearchingAddress)?  $default,) {final _that = this;
switch (_that) {
case _BookingState() when $default != null:
return $default(_that.destination,_that.route,_that.quote,_that.rideType,_that.isLoadingRoute,_that.isSearchingAddress);case _:
  return null;

}
}

}

/// @nodoc


class _BookingState extends BookingState with DiagnosticableTreeMixin {
  const _BookingState({this.destination, this.route, this.quote, this.rideType = RideType.private, this.isLoadingRoute = false, this.isSearchingAddress = false}): super._();
  

@override final  LatLng? destination;
@override final  DrivingRoute? route;
/// Null until a route is loaded.
@override final  RideQuote? quote;
@override@JsonKey() final  RideType rideType;
@override@JsonKey() final  bool isLoadingRoute;
@override@JsonKey() final  bool isSearchingAddress;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingStateCopyWith<_BookingState> get copyWith => __$BookingStateCopyWithImpl<_BookingState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'BookingState'))
    ..add(DiagnosticsProperty('destination', destination))..add(DiagnosticsProperty('route', route))..add(DiagnosticsProperty('quote', quote))..add(DiagnosticsProperty('rideType', rideType))..add(DiagnosticsProperty('isLoadingRoute', isLoadingRoute))..add(DiagnosticsProperty('isSearchingAddress', isSearchingAddress));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingState&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.route, route) || other.route == route)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.rideType, rideType) || other.rideType == rideType)&&(identical(other.isLoadingRoute, isLoadingRoute) || other.isLoadingRoute == isLoadingRoute)&&(identical(other.isSearchingAddress, isSearchingAddress) || other.isSearchingAddress == isSearchingAddress));
}


@override
int get hashCode {
    return Object.hash(runtimeType,destination,route,quote,rideType,isLoadingRoute,isSearchingAddress);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'BookingState(destination: $destination, route: $route, quote: $quote, rideType: $rideType, isLoadingRoute: $isLoadingRoute, isSearchingAddress: $isSearchingAddress)';
}


}

/// @nodoc
abstract mixin class _$BookingStateCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory _$BookingStateCopyWith(_BookingState value, $Res Function(_BookingState) _then) = __$BookingStateCopyWithImpl;
@override @useResult
$Res call({
 LatLng? destination, DrivingRoute? route, RideQuote? quote, RideType rideType, bool isLoadingRoute, bool isSearchingAddress
});


@override $DrivingRouteCopyWith<$Res>? get route;@override $RideQuoteCopyWith<$Res>? get quote;

}
/// @nodoc
class __$BookingStateCopyWithImpl<$Res>
    implements _$BookingStateCopyWith<$Res> {
  __$BookingStateCopyWithImpl(this._self, this._then);

  final _BookingState _self;
  final $Res Function(_BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destination = freezed,Object? route = freezed,Object? quote = freezed,Object? rideType = null,Object? isLoadingRoute = null,Object? isSearchingAddress = null,}) {
  return _then(_BookingState(
destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LatLng?,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as DrivingRoute?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote?,rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideType,isLoadingRoute: null == isLoadingRoute ? _self.isLoadingRoute : isLoadingRoute // ignore: cast_nullable_to_non_nullable
as bool,isSearchingAddress: null == isSearchingAddress ? _self.isSearchingAddress : isSearchingAddress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DrivingRouteCopyWith<$Res>? get route {
    if (_self.route == null) {
    return null;
  }

  return $DrivingRouteCopyWith<$Res>(_self.route!, (value) {
    return _then(_self.copyWith(route: value));
  });
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res>? get quote {
    if (_self.quote == null) {
    return null;
  }

  return $RideQuoteCopyWith<$Res>(_self.quote!, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}

// dart format on
