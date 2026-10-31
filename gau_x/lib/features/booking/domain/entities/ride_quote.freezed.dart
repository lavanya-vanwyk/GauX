// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RideQuote {

 RideType get rideType; double get distanceKm; int get etaMinutes; double get fare;
/// Create a copy of RideQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideQuoteCopyWith<RideQuote> get copyWith => _$RideQuoteCopyWithImpl<RideQuote>(this as RideQuote, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RideQuote;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideQuote&&(identical(other.rideType, _this.rideType) || other.rideType == _this.rideType)&&(identical(other.distanceKm, _this.distanceKm) || other.distanceKm == _this.distanceKm)&&(identical(other.etaMinutes, _this.etaMinutes) || other.etaMinutes == _this.etaMinutes)&&(identical(other.fare, _this.fare) || other.fare == _this.fare));
}


@override
int get hashCode {
  final _this = this as RideQuote;
  return Object.hash(runtimeType,_this.rideType,_this.distanceKm,_this.etaMinutes,_this.fare);
}

@override
String toString() {
  final _this = this as RideQuote;
  return 'RideQuote(rideType: ${_this.rideType}, distanceKm: ${_this.distanceKm}, etaMinutes: ${_this.etaMinutes}, fare: ${_this.fare})';
}


}

/// @nodoc
abstract mixin class $RideQuoteCopyWith<$Res>  {
  factory $RideQuoteCopyWith(RideQuote value, $Res Function(RideQuote) _then) = _$RideQuoteCopyWithImpl;
@useResult
$Res call({
 RideType rideType, double distanceKm, int etaMinutes, double fare
});




}
/// @nodoc
class _$RideQuoteCopyWithImpl<$Res>
    implements $RideQuoteCopyWith<$Res> {
  _$RideQuoteCopyWithImpl(this._self, this._then);

  final RideQuote _self;
  final $Res Function(RideQuote) _then;

/// Create a copy of RideQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rideType = null,Object? distanceKm = null,Object? etaMinutes = null,Object? fare = null,}) {
  return _then(RideQuote(
rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideType,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,etaMinutes: null == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RideQuote].
extension RideQuotePatterns on RideQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideQuote value)  $default,){
final _that = this;
switch (_that) {
case _RideQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideQuote value)?  $default,){
final _that = this;
switch (_that) {
case _RideQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RideType rideType,  double distanceKm,  int etaMinutes,  double fare)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideQuote() when $default != null:
return $default(_that.rideType,_that.distanceKm,_that.etaMinutes,_that.fare);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RideType rideType,  double distanceKm,  int etaMinutes,  double fare)  $default,) {final _that = this;
switch (_that) {
case _RideQuote():
return $default(_that.rideType,_that.distanceKm,_that.etaMinutes,_that.fare);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RideType rideType,  double distanceKm,  int etaMinutes,  double fare)?  $default,) {final _that = this;
switch (_that) {
case _RideQuote() when $default != null:
return $default(_that.rideType,_that.distanceKm,_that.etaMinutes,_that.fare);case _:
  return null;

}
}

}

/// @nodoc


class _RideQuote implements RideQuote {
  const _RideQuote({required this.rideType, required this.distanceKm, required this.etaMinutes, required this.fare});
  

@override final  RideType rideType;
@override final  double distanceKm;
@override final  int etaMinutes;
@override final  double fare;

/// Create a copy of RideQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideQuoteCopyWith<_RideQuote> get copyWith => __$RideQuoteCopyWithImpl<_RideQuote>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideQuote&&(identical(other.rideType, rideType) || other.rideType == rideType)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.etaMinutes, etaMinutes) || other.etaMinutes == etaMinutes)&&(identical(other.fare, fare) || other.fare == fare));
}


@override
int get hashCode {
    return Object.hash(runtimeType,rideType,distanceKm,etaMinutes,fare);
}

@override
String toString() {
    return 'RideQuote(rideType: $rideType, distanceKm: $distanceKm, etaMinutes: $etaMinutes, fare: $fare)';
}


}

/// @nodoc
abstract mixin class _$RideQuoteCopyWith<$Res> implements $RideQuoteCopyWith<$Res> {
  factory _$RideQuoteCopyWith(_RideQuote value, $Res Function(_RideQuote) _then) = __$RideQuoteCopyWithImpl;
@override @useResult
$Res call({
 RideType rideType, double distanceKm, int etaMinutes, double fare
});




}
/// @nodoc
class __$RideQuoteCopyWithImpl<$Res>
    implements _$RideQuoteCopyWith<$Res> {
  __$RideQuoteCopyWithImpl(this._self, this._then);

  final _RideQuote _self;
  final $Res Function(_RideQuote) _then;

/// Create a copy of RideQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rideType = null,Object? distanceKm = null,Object? etaMinutes = null,Object? fare = null,}) {
  return _then(_RideQuote(
rideType: null == rideType ? _self.rideType : rideType // ignore: cast_nullable_to_non_nullable
as RideType,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,etaMinutes: null == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
