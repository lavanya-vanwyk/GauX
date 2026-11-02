// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteConfig {

/// Bumped whenever the document changes. Clients can log it.
 int get version; PricingConfig get pricing; ServiceAreaConfig get serviceArea; FeatureFlags get flags;
/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteConfigCopyWith<RemoteConfig> get copyWith => _$RemoteConfigCopyWithImpl<RemoteConfig>(this as RemoteConfig, _$identity);

  /// Serializes this RemoteConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RemoteConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteConfig&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.pricing, _this.pricing) || other.pricing == _this.pricing)&&(identical(other.serviceArea, _this.serviceArea) || other.serviceArea == _this.serviceArea)&&(identical(other.flags, _this.flags) || other.flags == _this.flags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RemoteConfig;
  return Object.hash(runtimeType,_this.version,_this.pricing,_this.serviceArea,_this.flags);
}

@override
String toString() {
  final _this = this as RemoteConfig;
  return 'RemoteConfig(version: ${_this.version}, pricing: ${_this.pricing}, serviceArea: ${_this.serviceArea}, flags: ${_this.flags})';
}


}

/// @nodoc
abstract mixin class $RemoteConfigCopyWith<$Res>  {
  factory $RemoteConfigCopyWith(RemoteConfig value, $Res Function(RemoteConfig) _then) = _$RemoteConfigCopyWithImpl;
@useResult
$Res call({
 int version, PricingConfig pricing, ServiceAreaConfig serviceArea, FeatureFlags flags
});


$PricingConfigCopyWith<$Res> get pricing;$ServiceAreaConfigCopyWith<$Res> get serviceArea;$FeatureFlagsCopyWith<$Res> get flags;

}
/// @nodoc
class _$RemoteConfigCopyWithImpl<$Res>
    implements $RemoteConfigCopyWith<$Res> {
  _$RemoteConfigCopyWithImpl(this._self, this._then);

  final RemoteConfig _self;
  final $Res Function(RemoteConfig) _then;

/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? pricing = null,Object? serviceArea = null,Object? flags = null,}) {
  return _then(RemoteConfig(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pricing: null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as PricingConfig,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as ServiceAreaConfig,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as FeatureFlags,
  ));
}
/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PricingConfigCopyWith<$Res> get pricing {
  
  return $PricingConfigCopyWith<$Res>(_self.pricing, (value) {
    return _then(_self.copyWith(pricing: value));
  });
}/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceAreaConfigCopyWith<$Res> get serviceArea {
  
  return $ServiceAreaConfigCopyWith<$Res>(_self.serviceArea, (value) {
    return _then(_self.copyWith(serviceArea: value));
  });
}/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<$Res> get flags {
  
  return $FeatureFlagsCopyWith<$Res>(_self.flags, (value) {
    return _then(_self.copyWith(flags: value));
  });
}
}


/// Adds pattern-matching-related methods to [RemoteConfig].
extension RemoteConfigPatterns on RemoteConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteConfig value)  $default,){
final _that = this;
switch (_that) {
case _RemoteConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  PricingConfig pricing,  ServiceAreaConfig serviceArea,  FeatureFlags flags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteConfig() when $default != null:
return $default(_that.version,_that.pricing,_that.serviceArea,_that.flags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  PricingConfig pricing,  ServiceAreaConfig serviceArea,  FeatureFlags flags)  $default,) {final _that = this;
switch (_that) {
case _RemoteConfig():
return $default(_that.version,_that.pricing,_that.serviceArea,_that.flags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  PricingConfig pricing,  ServiceAreaConfig serviceArea,  FeatureFlags flags)?  $default,) {final _that = this;
switch (_that) {
case _RemoteConfig() when $default != null:
return $default(_that.version,_that.pricing,_that.serviceArea,_that.flags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteConfig implements RemoteConfig {
  const _RemoteConfig({this.version = 1, this.pricing = const PricingConfig(), this.serviceArea = const ServiceAreaConfig(), this.flags = const FeatureFlags()});
  factory _RemoteConfig.fromJson(Map<String, dynamic> json) => _$RemoteConfigFromJson(json);

/// Bumped whenever the document changes. Clients can log it.
@override@JsonKey() final  int version;
@override@JsonKey() final  PricingConfig pricing;
@override@JsonKey() final  ServiceAreaConfig serviceArea;
@override@JsonKey() final  FeatureFlags flags;

/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteConfigCopyWith<_RemoteConfig> get copyWith => __$RemoteConfigCopyWithImpl<_RemoteConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteConfig&&(identical(other.version, version) || other.version == version)&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.flags, flags) || other.flags == flags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,version,pricing,serviceArea,flags);
}

@override
String toString() {
    return 'RemoteConfig(version: $version, pricing: $pricing, serviceArea: $serviceArea, flags: $flags)';
}


}

/// @nodoc
abstract mixin class _$RemoteConfigCopyWith<$Res> implements $RemoteConfigCopyWith<$Res> {
  factory _$RemoteConfigCopyWith(_RemoteConfig value, $Res Function(_RemoteConfig) _then) = __$RemoteConfigCopyWithImpl;
@override @useResult
$Res call({
 int version, PricingConfig pricing, ServiceAreaConfig serviceArea, FeatureFlags flags
});


@override $PricingConfigCopyWith<$Res> get pricing;@override $ServiceAreaConfigCopyWith<$Res> get serviceArea;@override $FeatureFlagsCopyWith<$Res> get flags;

}
/// @nodoc
class __$RemoteConfigCopyWithImpl<$Res>
    implements _$RemoteConfigCopyWith<$Res> {
  __$RemoteConfigCopyWithImpl(this._self, this._then);

  final _RemoteConfig _self;
  final $Res Function(_RemoteConfig) _then;

/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? pricing = null,Object? serviceArea = null,Object? flags = null,}) {
  return _then(_RemoteConfig(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pricing: null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as PricingConfig,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as ServiceAreaConfig,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as FeatureFlags,
  ));
}

/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PricingConfigCopyWith<$Res> get pricing {
  
  return $PricingConfigCopyWith<$Res>(_self.pricing, (value) {
    return _then(_self.copyWith(pricing: value));
  });
}/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceAreaConfigCopyWith<$Res> get serviceArea {
  
  return $ServiceAreaConfigCopyWith<$Res>(_self.serviceArea, (value) {
    return _then(_self.copyWith(serviceArea: value));
  });
}/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<$Res> get flags {
  
  return $FeatureFlagsCopyWith<$Res>(_self.flags, (value) {
    return _then(_self.copyWith(flags: value));
  });
}
}


/// @nodoc
mixin _$PricingConfig {

 double get privateBaseFare; double get privatePerKm; double get poolFlatFare; double get averageMetersPerMinute;
/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingConfigCopyWith<PricingConfig> get copyWith => _$PricingConfigCopyWithImpl<PricingConfig>(this as PricingConfig, _$identity);

  /// Serializes this PricingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PricingConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingConfig&&(identical(other.privateBaseFare, _this.privateBaseFare) || other.privateBaseFare == _this.privateBaseFare)&&(identical(other.privatePerKm, _this.privatePerKm) || other.privatePerKm == _this.privatePerKm)&&(identical(other.poolFlatFare, _this.poolFlatFare) || other.poolFlatFare == _this.poolFlatFare)&&(identical(other.averageMetersPerMinute, _this.averageMetersPerMinute) || other.averageMetersPerMinute == _this.averageMetersPerMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PricingConfig;
  return Object.hash(runtimeType,_this.privateBaseFare,_this.privatePerKm,_this.poolFlatFare,_this.averageMetersPerMinute);
}

@override
String toString() {
  final _this = this as PricingConfig;
  return 'PricingConfig(privateBaseFare: ${_this.privateBaseFare}, privatePerKm: ${_this.privatePerKm}, poolFlatFare: ${_this.poolFlatFare}, averageMetersPerMinute: ${_this.averageMetersPerMinute})';
}


}

/// @nodoc
abstract mixin class $PricingConfigCopyWith<$Res>  {
  factory $PricingConfigCopyWith(PricingConfig value, $Res Function(PricingConfig) _then) = _$PricingConfigCopyWithImpl;
@useResult
$Res call({
 double privateBaseFare, double privatePerKm, double poolFlatFare, double averageMetersPerMinute
});




}
/// @nodoc
class _$PricingConfigCopyWithImpl<$Res>
    implements $PricingConfigCopyWith<$Res> {
  _$PricingConfigCopyWithImpl(this._self, this._then);

  final PricingConfig _self;
  final $Res Function(PricingConfig) _then;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? privateBaseFare = null,Object? privatePerKm = null,Object? poolFlatFare = null,Object? averageMetersPerMinute = null,}) {
  return _then(PricingConfig(
privateBaseFare: null == privateBaseFare ? _self.privateBaseFare : privateBaseFare // ignore: cast_nullable_to_non_nullable
as double,privatePerKm: null == privatePerKm ? _self.privatePerKm : privatePerKm // ignore: cast_nullable_to_non_nullable
as double,poolFlatFare: null == poolFlatFare ? _self.poolFlatFare : poolFlatFare // ignore: cast_nullable_to_non_nullable
as double,averageMetersPerMinute: null == averageMetersPerMinute ? _self.averageMetersPerMinute : averageMetersPerMinute // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingConfig].
extension PricingConfigPatterns on PricingConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingConfig value)  $default,){
final _that = this;
switch (_that) {
case _PricingConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double privateBaseFare,  double privatePerKm,  double poolFlatFare,  double averageMetersPerMinute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.privateBaseFare,_that.privatePerKm,_that.poolFlatFare,_that.averageMetersPerMinute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double privateBaseFare,  double privatePerKm,  double poolFlatFare,  double averageMetersPerMinute)  $default,) {final _that = this;
switch (_that) {
case _PricingConfig():
return $default(_that.privateBaseFare,_that.privatePerKm,_that.poolFlatFare,_that.averageMetersPerMinute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double privateBaseFare,  double privatePerKm,  double poolFlatFare,  double averageMetersPerMinute)?  $default,) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.privateBaseFare,_that.privatePerKm,_that.poolFlatFare,_that.averageMetersPerMinute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingConfig implements PricingConfig {
  const _PricingConfig({this.privateBaseFare = 10.0, this.privatePerKm = 12.0, this.poolFlatFare = 25.0, this.averageMetersPerMinute = 400.0});
  factory _PricingConfig.fromJson(Map<String, dynamic> json) => _$PricingConfigFromJson(json);

@override@JsonKey() final  double privateBaseFare;
@override@JsonKey() final  double privatePerKm;
@override@JsonKey() final  double poolFlatFare;
@override@JsonKey() final  double averageMetersPerMinute;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingConfigCopyWith<_PricingConfig> get copyWith => __$PricingConfigCopyWithImpl<_PricingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingConfig&&(identical(other.privateBaseFare, privateBaseFare) || other.privateBaseFare == privateBaseFare)&&(identical(other.privatePerKm, privatePerKm) || other.privatePerKm == privatePerKm)&&(identical(other.poolFlatFare, poolFlatFare) || other.poolFlatFare == poolFlatFare)&&(identical(other.averageMetersPerMinute, averageMetersPerMinute) || other.averageMetersPerMinute == averageMetersPerMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,privateBaseFare,privatePerKm,poolFlatFare,averageMetersPerMinute);
}

@override
String toString() {
    return 'PricingConfig(privateBaseFare: $privateBaseFare, privatePerKm: $privatePerKm, poolFlatFare: $poolFlatFare, averageMetersPerMinute: $averageMetersPerMinute)';
}


}

/// @nodoc
abstract mixin class _$PricingConfigCopyWith<$Res> implements $PricingConfigCopyWith<$Res> {
  factory _$PricingConfigCopyWith(_PricingConfig value, $Res Function(_PricingConfig) _then) = __$PricingConfigCopyWithImpl;
@override @useResult
$Res call({
 double privateBaseFare, double privatePerKm, double poolFlatFare, double averageMetersPerMinute
});




}
/// @nodoc
class __$PricingConfigCopyWithImpl<$Res>
    implements _$PricingConfigCopyWith<$Res> {
  __$PricingConfigCopyWithImpl(this._self, this._then);

  final _PricingConfig _self;
  final $Res Function(_PricingConfig) _then;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? privateBaseFare = null,Object? privatePerKm = null,Object? poolFlatFare = null,Object? averageMetersPerMinute = null,}) {
  return _then(_PricingConfig(
privateBaseFare: null == privateBaseFare ? _self.privateBaseFare : privateBaseFare // ignore: cast_nullable_to_non_nullable
as double,privatePerKm: null == privatePerKm ? _self.privatePerKm : privatePerKm // ignore: cast_nullable_to_non_nullable
as double,poolFlatFare: null == poolFlatFare ? _self.poolFlatFare : poolFlatFare // ignore: cast_nullable_to_non_nullable
as double,averageMetersPerMinute: null == averageMetersPerMinute ? _self.averageMetersPerMinute : averageMetersPerMinute // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ServiceAreaConfig {

/// Destinations further than this from the origin station are refused.
 double get radiusMeters;
/// Create a copy of ServiceAreaConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceAreaConfigCopyWith<ServiceAreaConfig> get copyWith => _$ServiceAreaConfigCopyWithImpl<ServiceAreaConfig>(this as ServiceAreaConfig, _$identity);

  /// Serializes this ServiceAreaConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServiceAreaConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceAreaConfig&&(identical(other.radiusMeters, _this.radiusMeters) || other.radiusMeters == _this.radiusMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServiceAreaConfig;
  return Object.hash(runtimeType,_this.radiusMeters);
}

@override
String toString() {
  final _this = this as ServiceAreaConfig;
  return 'ServiceAreaConfig(radiusMeters: ${_this.radiusMeters})';
}


}

/// @nodoc
abstract mixin class $ServiceAreaConfigCopyWith<$Res>  {
  factory $ServiceAreaConfigCopyWith(ServiceAreaConfig value, $Res Function(ServiceAreaConfig) _then) = _$ServiceAreaConfigCopyWithImpl;
@useResult
$Res call({
 double radiusMeters
});




}
/// @nodoc
class _$ServiceAreaConfigCopyWithImpl<$Res>
    implements $ServiceAreaConfigCopyWith<$Res> {
  _$ServiceAreaConfigCopyWithImpl(this._self, this._then);

  final ServiceAreaConfig _self;
  final $Res Function(ServiceAreaConfig) _then;

/// Create a copy of ServiceAreaConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? radiusMeters = null,}) {
  return _then(ServiceAreaConfig(
radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceAreaConfig].
extension ServiceAreaConfigPatterns on ServiceAreaConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceAreaConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceAreaConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceAreaConfig value)  $default,){
final _that = this;
switch (_that) {
case _ServiceAreaConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceAreaConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceAreaConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double radiusMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceAreaConfig() when $default != null:
return $default(_that.radiusMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double radiusMeters)  $default,) {final _that = this;
switch (_that) {
case _ServiceAreaConfig():
return $default(_that.radiusMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double radiusMeters)?  $default,) {final _that = this;
switch (_that) {
case _ServiceAreaConfig() when $default != null:
return $default(_that.radiusMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceAreaConfig implements ServiceAreaConfig {
  const _ServiceAreaConfig({this.radiusMeters = 5000.0});
  factory _ServiceAreaConfig.fromJson(Map<String, dynamic> json) => _$ServiceAreaConfigFromJson(json);

/// Destinations further than this from the origin station are refused.
@override@JsonKey() final  double radiusMeters;

/// Create a copy of ServiceAreaConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceAreaConfigCopyWith<_ServiceAreaConfig> get copyWith => __$ServiceAreaConfigCopyWithImpl<_ServiceAreaConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceAreaConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceAreaConfig&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,radiusMeters);
}

@override
String toString() {
    return 'ServiceAreaConfig(radiusMeters: $radiusMeters)';
}


}

/// @nodoc
abstract mixin class _$ServiceAreaConfigCopyWith<$Res> implements $ServiceAreaConfigCopyWith<$Res> {
  factory _$ServiceAreaConfigCopyWith(_ServiceAreaConfig value, $Res Function(_ServiceAreaConfig) _then) = __$ServiceAreaConfigCopyWithImpl;
@override @useResult
$Res call({
 double radiusMeters
});




}
/// @nodoc
class __$ServiceAreaConfigCopyWithImpl<$Res>
    implements _$ServiceAreaConfigCopyWith<$Res> {
  __$ServiceAreaConfigCopyWithImpl(this._self, this._then);

  final _ServiceAreaConfig _self;
  final $Res Function(_ServiceAreaConfig) _then;

/// Create a copy of ServiceAreaConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? radiusMeters = null,}) {
  return _then(_ServiceAreaConfig(
radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$FeatureFlags {

/// When false, riders can't book new rides (e.g. during an incident).
 bool get bookingEnabled; bool get poolEnabled; bool get sosEnabled; bool get topUpEnabled;/// Shown to riders while [bookingEnabled] is false.
 String get bookingDisabledMessage;
/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<FeatureFlags> get copyWith => _$FeatureFlagsCopyWithImpl<FeatureFlags>(this as FeatureFlags, _$identity);

  /// Serializes this FeatureFlags to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeatureFlags;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlags&&(identical(other.bookingEnabled, _this.bookingEnabled) || other.bookingEnabled == _this.bookingEnabled)&&(identical(other.poolEnabled, _this.poolEnabled) || other.poolEnabled == _this.poolEnabled)&&(identical(other.sosEnabled, _this.sosEnabled) || other.sosEnabled == _this.sosEnabled)&&(identical(other.topUpEnabled, _this.topUpEnabled) || other.topUpEnabled == _this.topUpEnabled)&&(identical(other.bookingDisabledMessage, _this.bookingDisabledMessage) || other.bookingDisabledMessage == _this.bookingDisabledMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeatureFlags;
  return Object.hash(runtimeType,_this.bookingEnabled,_this.poolEnabled,_this.sosEnabled,_this.topUpEnabled,_this.bookingDisabledMessage);
}

@override
String toString() {
  final _this = this as FeatureFlags;
  return 'FeatureFlags(bookingEnabled: ${_this.bookingEnabled}, poolEnabled: ${_this.poolEnabled}, sosEnabled: ${_this.sosEnabled}, topUpEnabled: ${_this.topUpEnabled}, bookingDisabledMessage: ${_this.bookingDisabledMessage})';
}


}

/// @nodoc
abstract mixin class $FeatureFlagsCopyWith<$Res>  {
  factory $FeatureFlagsCopyWith(FeatureFlags value, $Res Function(FeatureFlags) _then) = _$FeatureFlagsCopyWithImpl;
@useResult
$Res call({
 bool bookingEnabled, bool poolEnabled, bool sosEnabled, bool topUpEnabled, String bookingDisabledMessage
});




}
/// @nodoc
class _$FeatureFlagsCopyWithImpl<$Res>
    implements $FeatureFlagsCopyWith<$Res> {
  _$FeatureFlagsCopyWithImpl(this._self, this._then);

  final FeatureFlags _self;
  final $Res Function(FeatureFlags) _then;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingEnabled = null,Object? poolEnabled = null,Object? sosEnabled = null,Object? topUpEnabled = null,Object? bookingDisabledMessage = null,}) {
  return _then(FeatureFlags(
bookingEnabled: null == bookingEnabled ? _self.bookingEnabled : bookingEnabled // ignore: cast_nullable_to_non_nullable
as bool,poolEnabled: null == poolEnabled ? _self.poolEnabled : poolEnabled // ignore: cast_nullable_to_non_nullable
as bool,sosEnabled: null == sosEnabled ? _self.sosEnabled : sosEnabled // ignore: cast_nullable_to_non_nullable
as bool,topUpEnabled: null == topUpEnabled ? _self.topUpEnabled : topUpEnabled // ignore: cast_nullable_to_non_nullable
as bool,bookingDisabledMessage: null == bookingDisabledMessage ? _self.bookingDisabledMessage : bookingDisabledMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeatureFlags].
extension FeatureFlagsPatterns on FeatureFlags {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeatureFlags value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeatureFlags value)  $default,){
final _that = this;
switch (_that) {
case _FeatureFlags():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeatureFlags value)?  $default,){
final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool bookingEnabled,  bool poolEnabled,  bool sosEnabled,  bool topUpEnabled,  String bookingDisabledMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
return $default(_that.bookingEnabled,_that.poolEnabled,_that.sosEnabled,_that.topUpEnabled,_that.bookingDisabledMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool bookingEnabled,  bool poolEnabled,  bool sosEnabled,  bool topUpEnabled,  String bookingDisabledMessage)  $default,) {final _that = this;
switch (_that) {
case _FeatureFlags():
return $default(_that.bookingEnabled,_that.poolEnabled,_that.sosEnabled,_that.topUpEnabled,_that.bookingDisabledMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool bookingEnabled,  bool poolEnabled,  bool sosEnabled,  bool topUpEnabled,  String bookingDisabledMessage)?  $default,) {final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
return $default(_that.bookingEnabled,_that.poolEnabled,_that.sosEnabled,_that.topUpEnabled,_that.bookingDisabledMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeatureFlags implements FeatureFlags {
  const _FeatureFlags({this.bookingEnabled = true, this.poolEnabled = true, this.sosEnabled = true, this.topUpEnabled = true, this.bookingDisabledMessage = ''});
  factory _FeatureFlags.fromJson(Map<String, dynamic> json) => _$FeatureFlagsFromJson(json);

/// When false, riders can't book new rides (e.g. during an incident).
@override@JsonKey() final  bool bookingEnabled;
@override@JsonKey() final  bool poolEnabled;
@override@JsonKey() final  bool sosEnabled;
@override@JsonKey() final  bool topUpEnabled;
/// Shown to riders while [bookingEnabled] is false.
@override@JsonKey() final  String bookingDisabledMessage;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagsCopyWith<_FeatureFlags> get copyWith => __$FeatureFlagsCopyWithImpl<_FeatureFlags>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeatureFlagsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlags&&(identical(other.bookingEnabled, bookingEnabled) || other.bookingEnabled == bookingEnabled)&&(identical(other.poolEnabled, poolEnabled) || other.poolEnabled == poolEnabled)&&(identical(other.sosEnabled, sosEnabled) || other.sosEnabled == sosEnabled)&&(identical(other.topUpEnabled, topUpEnabled) || other.topUpEnabled == topUpEnabled)&&(identical(other.bookingDisabledMessage, bookingDisabledMessage) || other.bookingDisabledMessage == bookingDisabledMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,bookingEnabled,poolEnabled,sosEnabled,topUpEnabled,bookingDisabledMessage);
}

@override
String toString() {
    return 'FeatureFlags(bookingEnabled: $bookingEnabled, poolEnabled: $poolEnabled, sosEnabled: $sosEnabled, topUpEnabled: $topUpEnabled, bookingDisabledMessage: $bookingDisabledMessage)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagsCopyWith<$Res> implements $FeatureFlagsCopyWith<$Res> {
  factory _$FeatureFlagsCopyWith(_FeatureFlags value, $Res Function(_FeatureFlags) _then) = __$FeatureFlagsCopyWithImpl;
@override @useResult
$Res call({
 bool bookingEnabled, bool poolEnabled, bool sosEnabled, bool topUpEnabled, String bookingDisabledMessage
});




}
/// @nodoc
class __$FeatureFlagsCopyWithImpl<$Res>
    implements _$FeatureFlagsCopyWith<$Res> {
  __$FeatureFlagsCopyWithImpl(this._self, this._then);

  final _FeatureFlags _self;
  final $Res Function(_FeatureFlags) _then;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingEnabled = null,Object? poolEnabled = null,Object? sosEnabled = null,Object? topUpEnabled = null,Object? bookingDisabledMessage = null,}) {
  return _then(_FeatureFlags(
bookingEnabled: null == bookingEnabled ? _self.bookingEnabled : bookingEnabled // ignore: cast_nullable_to_non_nullable
as bool,poolEnabled: null == poolEnabled ? _self.poolEnabled : poolEnabled // ignore: cast_nullable_to_non_nullable
as bool,sosEnabled: null == sosEnabled ? _self.sosEnabled : sosEnabled // ignore: cast_nullable_to_non_nullable
as bool,topUpEnabled: null == topUpEnabled ? _self.topUpEnabled : topUpEnabled // ignore: cast_nullable_to_non_nullable
as bool,bookingDisabledMessage: null == bookingDisabledMessage ? _self.bookingDisabledMessage : bookingDisabledMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
