// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nominatim_place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NominatimPlaceModel {

@JsonKey(name: 'display_name') String get displayName;@JsonKey(fromJson: _parseDouble) double get lat;@JsonKey(fromJson: _parseDouble) double get lon;
/// Create a copy of NominatimPlaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NominatimPlaceModelCopyWith<NominatimPlaceModel> get copyWith => _$NominatimPlaceModelCopyWithImpl<NominatimPlaceModel>(this as NominatimPlaceModel, _$identity);

  /// Serializes this NominatimPlaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NominatimPlaceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NominatimPlaceModel&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lon, _this.lon) || other.lon == _this.lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NominatimPlaceModel;
  return Object.hash(runtimeType,_this.displayName,_this.lat,_this.lon);
}

@override
String toString() {
  final _this = this as NominatimPlaceModel;
  return 'NominatimPlaceModel(displayName: ${_this.displayName}, lat: ${_this.lat}, lon: ${_this.lon})';
}


}

/// @nodoc
abstract mixin class $NominatimPlaceModelCopyWith<$Res>  {
  factory $NominatimPlaceModelCopyWith(NominatimPlaceModel value, $Res Function(NominatimPlaceModel) _then) = _$NominatimPlaceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'display_name') String displayName,@JsonKey(fromJson: _parseDouble) double lat,@JsonKey(fromJson: _parseDouble) double lon
});




}
/// @nodoc
class _$NominatimPlaceModelCopyWithImpl<$Res>
    implements $NominatimPlaceModelCopyWith<$Res> {
  _$NominatimPlaceModelCopyWithImpl(this._self, this._then);

  final NominatimPlaceModel _self;
  final $Res Function(NominatimPlaceModel) _then;

/// Create a copy of NominatimPlaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? lat = null,Object? lon = null,}) {
  return _then(NominatimPlaceModel(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [NominatimPlaceModel].
extension NominatimPlaceModelPatterns on NominatimPlaceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NominatimPlaceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NominatimPlaceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NominatimPlaceModel value)  $default,){
final _that = this;
switch (_that) {
case _NominatimPlaceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NominatimPlaceModel value)?  $default,){
final _that = this;
switch (_that) {
case _NominatimPlaceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'display_name')  String displayName, @JsonKey(fromJson: _parseDouble)  double lat, @JsonKey(fromJson: _parseDouble)  double lon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NominatimPlaceModel() when $default != null:
return $default(_that.displayName,_that.lat,_that.lon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'display_name')  String displayName, @JsonKey(fromJson: _parseDouble)  double lat, @JsonKey(fromJson: _parseDouble)  double lon)  $default,) {final _that = this;
switch (_that) {
case _NominatimPlaceModel():
return $default(_that.displayName,_that.lat,_that.lon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'display_name')  String displayName, @JsonKey(fromJson: _parseDouble)  double lat, @JsonKey(fromJson: _parseDouble)  double lon)?  $default,) {final _that = this;
switch (_that) {
case _NominatimPlaceModel() when $default != null:
return $default(_that.displayName,_that.lat,_that.lon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NominatimPlaceModel extends NominatimPlaceModel {
  const _NominatimPlaceModel({@JsonKey(name: 'display_name') required this.displayName, @JsonKey(fromJson: _parseDouble) required this.lat, @JsonKey(fromJson: _parseDouble) required this.lon}): super._();
  factory _NominatimPlaceModel.fromJson(Map<String, dynamic> json) => _$NominatimPlaceModelFromJson(json);

@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(fromJson: _parseDouble) final  double lat;
@override@JsonKey(fromJson: _parseDouble) final  double lon;

/// Create a copy of NominatimPlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NominatimPlaceModelCopyWith<_NominatimPlaceModel> get copyWith => __$NominatimPlaceModelCopyWithImpl<_NominatimPlaceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NominatimPlaceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NominatimPlaceModel&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,displayName,lat,lon);
}

@override
String toString() {
    return 'NominatimPlaceModel(displayName: $displayName, lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class _$NominatimPlaceModelCopyWith<$Res> implements $NominatimPlaceModelCopyWith<$Res> {
  factory _$NominatimPlaceModelCopyWith(_NominatimPlaceModel value, $Res Function(_NominatimPlaceModel) _then) = __$NominatimPlaceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'display_name') String displayName,@JsonKey(fromJson: _parseDouble) double lat,@JsonKey(fromJson: _parseDouble) double lon
});




}
/// @nodoc
class __$NominatimPlaceModelCopyWithImpl<$Res>
    implements _$NominatimPlaceModelCopyWith<$Res> {
  __$NominatimPlaceModelCopyWithImpl(this._self, this._then);

  final _NominatimPlaceModel _self;
  final $Res Function(_NominatimPlaceModel) _then;

/// Create a copy of NominatimPlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? lat = null,Object? lon = null,}) {
  return _then(_NominatimPlaceModel(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
