// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gautrain_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GautrainStation {

 String get id; String get name; LatLng get location;
/// Create a copy of GautrainStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GautrainStationCopyWith<GautrainStation> get copyWith => _$GautrainStationCopyWithImpl<GautrainStation>(this as GautrainStation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GautrainStation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GautrainStation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.location, _this.location) || other.location == _this.location));
}


@override
int get hashCode {
  final _this = this as GautrainStation;
  return Object.hash(runtimeType,_this.id,_this.name,_this.location);
}

@override
String toString() {
  final _this = this as GautrainStation;
  return 'GautrainStation(id: ${_this.id}, name: ${_this.name}, location: ${_this.location})';
}


}

/// @nodoc
abstract mixin class $GautrainStationCopyWith<$Res>  {
  factory $GautrainStationCopyWith(GautrainStation value, $Res Function(GautrainStation) _then) = _$GautrainStationCopyWithImpl;
@useResult
$Res call({
 String id, String name, LatLng location
});




}
/// @nodoc
class _$GautrainStationCopyWithImpl<$Res>
    implements $GautrainStationCopyWith<$Res> {
  _$GautrainStationCopyWithImpl(this._self, this._then);

  final GautrainStation _self;
  final $Res Function(GautrainStation) _then;

/// Create a copy of GautrainStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,}) {
  return _then(GautrainStation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}

}


/// Adds pattern-matching-related methods to [GautrainStation].
extension GautrainStationPatterns on GautrainStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GautrainStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GautrainStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GautrainStation value)  $default,){
final _that = this;
switch (_that) {
case _GautrainStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GautrainStation value)?  $default,){
final _that = this;
switch (_that) {
case _GautrainStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  LatLng location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GautrainStation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  LatLng location)  $default,) {final _that = this;
switch (_that) {
case _GautrainStation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  LatLng location)?  $default,) {final _that = this;
switch (_that) {
case _GautrainStation() when $default != null:
return $default(_that.id,_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _GautrainStation implements GautrainStation {
  const _GautrainStation({required this.id, required this.name, required this.location});
  

@override final  String id;
@override final  String name;
@override final  LatLng location;

/// Create a copy of GautrainStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GautrainStationCopyWith<_GautrainStation> get copyWith => __$GautrainStationCopyWithImpl<_GautrainStation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GautrainStation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,location);
}

@override
String toString() {
    return 'GautrainStation(id: $id, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$GautrainStationCopyWith<$Res> implements $GautrainStationCopyWith<$Res> {
  factory _$GautrainStationCopyWith(_GautrainStation value, $Res Function(_GautrainStation) _then) = __$GautrainStationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, LatLng location
});




}
/// @nodoc
class __$GautrainStationCopyWithImpl<$Res>
    implements _$GautrainStationCopyWith<$Res> {
  __$GautrainStationCopyWithImpl(this._self, this._then);

  final _GautrainStation _self;
  final $Res Function(_GautrainStation) _then;

/// Create a copy of GautrainStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,}) {
  return _then(_GautrainStation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}


}

// dart format on
