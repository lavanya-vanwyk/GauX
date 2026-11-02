// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RideState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RideState()';
}


}

/// @nodoc
class $RideStateCopyWith<$Res>  {
$RideStateCopyWith(RideState _, $Res Function(RideState) __);
}


/// Adds pattern-matching-related methods to [RideState].
extension RideStatePatterns on RideState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RideIdle value)?  idle,TResult Function( RideMatching value)?  matching,TResult Function( RideSearching value)?  searching,TResult Function( RideArriving value)?  arriving,TResult Function( RideInTransit value)?  inTransit,TResult Function( RideArrived value)?  arrived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RideIdle() when idle != null:
return idle(_that);case RideMatching() when matching != null:
return matching(_that);case RideSearching() when searching != null:
return searching(_that);case RideArriving() when arriving != null:
return arriving(_that);case RideInTransit() when inTransit != null:
return inTransit(_that);case RideArrived() when arrived != null:
return arrived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RideIdle value)  idle,required TResult Function( RideMatching value)  matching,required TResult Function( RideSearching value)  searching,required TResult Function( RideArriving value)  arriving,required TResult Function( RideInTransit value)  inTransit,required TResult Function( RideArrived value)  arrived,}){
final _that = this;
switch (_that) {
case RideIdle():
return idle(_that);case RideMatching():
return matching(_that);case RideSearching():
return searching(_that);case RideArriving():
return arriving(_that);case RideInTransit():
return inTransit(_that);case RideArrived():
return arrived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RideIdle value)?  idle,TResult? Function( RideMatching value)?  matching,TResult? Function( RideSearching value)?  searching,TResult? Function( RideArriving value)?  arriving,TResult? Function( RideInTransit value)?  inTransit,TResult? Function( RideArrived value)?  arrived,}){
final _that = this;
switch (_that) {
case RideIdle() when idle != null:
return idle(_that);case RideMatching() when matching != null:
return matching(_that);case RideSearching() when searching != null:
return searching(_that);case RideArriving() when arriving != null:
return arriving(_that);case RideInTransit() when inTransit != null:
return inTransit(_that);case RideArrived() when arrived != null:
return arrived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( RideQuote quote,  List<LatLng> route)?  matching,TResult Function( RideQuote quote,  List<LatLng> route)?  searching,TResult Function( RideQuote quote,  List<LatLng> route)?  arriving,TResult Function( RideQuote quote,  List<LatLng> route,  DriverLocation? driver)?  inTransit,TResult Function( RideQuote quote)?  arrived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RideIdle() when idle != null:
return idle();case RideMatching() when matching != null:
return matching(_that.quote,_that.route);case RideSearching() when searching != null:
return searching(_that.quote,_that.route);case RideArriving() when arriving != null:
return arriving(_that.quote,_that.route);case RideInTransit() when inTransit != null:
return inTransit(_that.quote,_that.route,_that.driver);case RideArrived() when arrived != null:
return arrived(_that.quote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( RideQuote quote,  List<LatLng> route)  matching,required TResult Function( RideQuote quote,  List<LatLng> route)  searching,required TResult Function( RideQuote quote,  List<LatLng> route)  arriving,required TResult Function( RideQuote quote,  List<LatLng> route,  DriverLocation? driver)  inTransit,required TResult Function( RideQuote quote)  arrived,}) {final _that = this;
switch (_that) {
case RideIdle():
return idle();case RideMatching():
return matching(_that.quote,_that.route);case RideSearching():
return searching(_that.quote,_that.route);case RideArriving():
return arriving(_that.quote,_that.route);case RideInTransit():
return inTransit(_that.quote,_that.route,_that.driver);case RideArrived():
return arrived(_that.quote);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( RideQuote quote,  List<LatLng> route)?  matching,TResult? Function( RideQuote quote,  List<LatLng> route)?  searching,TResult? Function( RideQuote quote,  List<LatLng> route)?  arriving,TResult? Function( RideQuote quote,  List<LatLng> route,  DriverLocation? driver)?  inTransit,TResult? Function( RideQuote quote)?  arrived,}) {final _that = this;
switch (_that) {
case RideIdle() when idle != null:
return idle();case RideMatching() when matching != null:
return matching(_that.quote,_that.route);case RideSearching() when searching != null:
return searching(_that.quote,_that.route);case RideArriving() when arriving != null:
return arriving(_that.quote,_that.route);case RideInTransit() when inTransit != null:
return inTransit(_that.quote,_that.route,_that.driver);case RideArrived() when arrived != null:
return arrived(_that.quote);case _:
  return null;

}
}

}

/// @nodoc


class RideIdle extends RideState {
  const RideIdle(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RideState.idle()';
}


}




/// @nodoc


class RideMatching extends RideState {
  const RideMatching({required this.quote, required  List<LatLng> route}): _route = route,super._();
  

 final  RideQuote quote;
 final  List<LatLng> _route;
 List<LatLng> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}


/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideMatchingCopyWith<RideMatching> get copyWith => _$RideMatchingCopyWithImpl<RideMatching>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideMatching&&(identical(other.quote, quote) || other.quote == quote)&&const DeepCollectionEquality().equals(other.route, _route));
}


@override
int get hashCode {
    return Object.hash(runtimeType,quote,const DeepCollectionEquality().hash(_route));
}

@override
String toString() {
    return 'RideState.matching(quote: $quote, route: $route)';
}


}

/// @nodoc
abstract mixin class $RideMatchingCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory $RideMatchingCopyWith(RideMatching value, $Res Function(RideMatching) _then) = _$RideMatchingCopyWithImpl;
@useResult
$Res call({
 RideQuote quote, List<LatLng> route
});


$RideQuoteCopyWith<$Res> get quote;

}
/// @nodoc
class _$RideMatchingCopyWithImpl<$Res>
    implements $RideMatchingCopyWith<$Res> {
  _$RideMatchingCopyWithImpl(this._self, this._then);

  final RideMatching _self;
  final $Res Function(RideMatching) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quote = null,Object? route = null,}) {
  return _then(RideMatching(
quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<LatLng>,
  ));
}

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res> get quote {
  
  return $RideQuoteCopyWith<$Res>(_self.quote, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}

/// @nodoc


class RideSearching extends RideState {
  const RideSearching({required this.quote, required  List<LatLng> route}): _route = route,super._();
  

 final  RideQuote quote;
 final  List<LatLng> _route;
 List<LatLng> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}


/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideSearchingCopyWith<RideSearching> get copyWith => _$RideSearchingCopyWithImpl<RideSearching>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideSearching&&(identical(other.quote, quote) || other.quote == quote)&&const DeepCollectionEquality().equals(other.route, _route));
}


@override
int get hashCode {
    return Object.hash(runtimeType,quote,const DeepCollectionEquality().hash(_route));
}

@override
String toString() {
    return 'RideState.searching(quote: $quote, route: $route)';
}


}

/// @nodoc
abstract mixin class $RideSearchingCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory $RideSearchingCopyWith(RideSearching value, $Res Function(RideSearching) _then) = _$RideSearchingCopyWithImpl;
@useResult
$Res call({
 RideQuote quote, List<LatLng> route
});


$RideQuoteCopyWith<$Res> get quote;

}
/// @nodoc
class _$RideSearchingCopyWithImpl<$Res>
    implements $RideSearchingCopyWith<$Res> {
  _$RideSearchingCopyWithImpl(this._self, this._then);

  final RideSearching _self;
  final $Res Function(RideSearching) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quote = null,Object? route = null,}) {
  return _then(RideSearching(
quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<LatLng>,
  ));
}

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res> get quote {
  
  return $RideQuoteCopyWith<$Res>(_self.quote, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}

/// @nodoc


class RideArriving extends RideState {
  const RideArriving({required this.quote, required  List<LatLng> route}): _route = route,super._();
  

 final  RideQuote quote;
 final  List<LatLng> _route;
 List<LatLng> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}


/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideArrivingCopyWith<RideArriving> get copyWith => _$RideArrivingCopyWithImpl<RideArriving>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideArriving&&(identical(other.quote, quote) || other.quote == quote)&&const DeepCollectionEquality().equals(other.route, _route));
}


@override
int get hashCode {
    return Object.hash(runtimeType,quote,const DeepCollectionEquality().hash(_route));
}

@override
String toString() {
    return 'RideState.arriving(quote: $quote, route: $route)';
}


}

/// @nodoc
abstract mixin class $RideArrivingCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory $RideArrivingCopyWith(RideArriving value, $Res Function(RideArriving) _then) = _$RideArrivingCopyWithImpl;
@useResult
$Res call({
 RideQuote quote, List<LatLng> route
});


$RideQuoteCopyWith<$Res> get quote;

}
/// @nodoc
class _$RideArrivingCopyWithImpl<$Res>
    implements $RideArrivingCopyWith<$Res> {
  _$RideArrivingCopyWithImpl(this._self, this._then);

  final RideArriving _self;
  final $Res Function(RideArriving) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quote = null,Object? route = null,}) {
  return _then(RideArriving(
quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<LatLng>,
  ));
}

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res> get quote {
  
  return $RideQuoteCopyWith<$Res>(_self.quote, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}

/// @nodoc


class RideInTransit extends RideState {
  const RideInTransit({required this.quote, required  List<LatLng> route, this.driver}): _route = route,super._();
  

 final  RideQuote quote;
 final  List<LatLng> _route;
 List<LatLng> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}

 final  DriverLocation? driver;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideInTransitCopyWith<RideInTransit> get copyWith => _$RideInTransitCopyWithImpl<RideInTransit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideInTransit&&(identical(other.quote, quote) || other.quote == quote)&&const DeepCollectionEquality().equals(other.route, _route)&&(identical(other.driver, driver) || other.driver == driver));
}


@override
int get hashCode {
    return Object.hash(runtimeType,quote,const DeepCollectionEquality().hash(_route),driver);
}

@override
String toString() {
    return 'RideState.inTransit(quote: $quote, route: $route, driver: $driver)';
}


}

/// @nodoc
abstract mixin class $RideInTransitCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory $RideInTransitCopyWith(RideInTransit value, $Res Function(RideInTransit) _then) = _$RideInTransitCopyWithImpl;
@useResult
$Res call({
 RideQuote quote, List<LatLng> route, DriverLocation? driver
});


$RideQuoteCopyWith<$Res> get quote;$DriverLocationCopyWith<$Res>? get driver;

}
/// @nodoc
class _$RideInTransitCopyWithImpl<$Res>
    implements $RideInTransitCopyWith<$Res> {
  _$RideInTransitCopyWithImpl(this._self, this._then);

  final RideInTransit _self;
  final $Res Function(RideInTransit) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quote = null,Object? route = null,Object? driver = freezed,}) {
  return _then(RideInTransit(
quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<LatLng>,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverLocation?,
  ));
}

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res> get quote {
  
  return $RideQuoteCopyWith<$Res>(_self.quote, (value) {
    return _then(_self.copyWith(quote: value));
  });
}/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverLocationCopyWith<$Res>? get driver {
    if (_self.driver == null) {
    return null;
  }

  return $DriverLocationCopyWith<$Res>(_self.driver!, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}

/// @nodoc


class RideArrived extends RideState {
  const RideArrived({required this.quote}): super._();
  

 final  RideQuote quote;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideArrivedCopyWith<RideArrived> get copyWith => _$RideArrivedCopyWithImpl<RideArrived>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RideArrived&&(identical(other.quote, quote) || other.quote == quote));
}


@override
int get hashCode {
    return Object.hash(runtimeType,quote);
}

@override
String toString() {
    return 'RideState.arrived(quote: $quote)';
}


}

/// @nodoc
abstract mixin class $RideArrivedCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory $RideArrivedCopyWith(RideArrived value, $Res Function(RideArrived) _then) = _$RideArrivedCopyWithImpl;
@useResult
$Res call({
 RideQuote quote
});


$RideQuoteCopyWith<$Res> get quote;

}
/// @nodoc
class _$RideArrivedCopyWithImpl<$Res>
    implements $RideArrivedCopyWith<$Res> {
  _$RideArrivedCopyWithImpl(this._self, this._then);

  final RideArrived _self;
  final $Res Function(RideArrived) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quote = null,}) {
  return _then(RideArrived(
quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as RideQuote,
  ));
}

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<$Res> get quote {
  
  return $RideQuoteCopyWith<$Res>(_self.quote, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}

// dart format on
