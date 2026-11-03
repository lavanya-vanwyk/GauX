// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StationSelection implements DiagnosticableTreeMixin {

 List<GautrainStation> get stations; GautrainStation get selected; StationSource get source;
/// Create a copy of StationSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationSelectionCopyWith<StationSelection> get copyWith => _$StationSelectionCopyWithImpl<StationSelection>(this as StationSelection, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as StationSelection;
  properties
    ..add(DiagnosticsProperty('type', 'StationSelection'))
    ..add(DiagnosticsProperty('stations', _this.stations))..add(DiagnosticsProperty('selected', _this.selected))..add(DiagnosticsProperty('source', _this.source));
}

@override
bool operator ==(Object other) {
  final _this = this as StationSelection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationSelection&&const DeepCollectionEquality().equals(other.stations, _this.stations)&&(identical(other.selected, _this.selected) || other.selected == _this.selected)&&(identical(other.source, _this.source) || other.source == _this.source));
}


@override
int get hashCode {
  final _this = this as StationSelection;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.stations),_this.selected,_this.source);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as StationSelection;
  return 'StationSelection(stations: ${_this.stations}, selected: ${_this.selected}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $StationSelectionCopyWith<$Res>  {
  factory $StationSelectionCopyWith(StationSelection value, $Res Function(StationSelection) _then) = _$StationSelectionCopyWithImpl;
@useResult
$Res call({
 List<GautrainStation> stations, GautrainStation selected, StationSource source
});


$GautrainStationCopyWith<$Res> get selected;

}
/// @nodoc
class _$StationSelectionCopyWithImpl<$Res>
    implements $StationSelectionCopyWith<$Res> {
  _$StationSelectionCopyWithImpl(this._self, this._then);

  final StationSelection _self;
  final $Res Function(StationSelection) _then;

/// Create a copy of StationSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stations = null,Object? selected = null,Object? source = null,}) {
  return _then(StationSelection(
stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<GautrainStation>,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as GautrainStation,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as StationSource,
  ));
}
/// Create a copy of StationSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GautrainStationCopyWith<$Res> get selected {
  
  return $GautrainStationCopyWith<$Res>(_self.selected, (value) {
    return _then(_self.copyWith(selected: value));
  });
}
}


/// Adds pattern-matching-related methods to [StationSelection].
extension StationSelectionPatterns on StationSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationSelection value)  $default,){
final _that = this;
switch (_that) {
case _StationSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationSelection value)?  $default,){
final _that = this;
switch (_that) {
case _StationSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GautrainStation> stations,  GautrainStation selected,  StationSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationSelection() when $default != null:
return $default(_that.stations,_that.selected,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GautrainStation> stations,  GautrainStation selected,  StationSource source)  $default,) {final _that = this;
switch (_that) {
case _StationSelection():
return $default(_that.stations,_that.selected,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GautrainStation> stations,  GautrainStation selected,  StationSource source)?  $default,) {final _that = this;
switch (_that) {
case _StationSelection() when $default != null:
return $default(_that.stations,_that.selected,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _StationSelection with DiagnosticableTreeMixin implements StationSelection {
  const _StationSelection({required  List<GautrainStation> stations, required this.selected, required this.source}): _stations = stations;
  

 final  List<GautrainStation> _stations;
@override List<GautrainStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

@override final  GautrainStation selected;
@override final  StationSource source;

/// Create a copy of StationSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationSelectionCopyWith<_StationSelection> get copyWith => __$StationSelectionCopyWithImpl<_StationSelection>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'StationSelection'))
    ..add(DiagnosticsProperty('stations', stations))..add(DiagnosticsProperty('selected', selected))..add(DiagnosticsProperty('source', source));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationSelection&&const DeepCollectionEquality().equals(other.stations, _stations)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_stations),selected,source);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'StationSelection(stations: $stations, selected: $selected, source: $source)';
}


}

/// @nodoc
abstract mixin class _$StationSelectionCopyWith<$Res> implements $StationSelectionCopyWith<$Res> {
  factory _$StationSelectionCopyWith(_StationSelection value, $Res Function(_StationSelection) _then) = __$StationSelectionCopyWithImpl;
@override @useResult
$Res call({
 List<GautrainStation> stations, GautrainStation selected, StationSource source
});


@override $GautrainStationCopyWith<$Res> get selected;

}
/// @nodoc
class __$StationSelectionCopyWithImpl<$Res>
    implements _$StationSelectionCopyWith<$Res> {
  __$StationSelectionCopyWithImpl(this._self, this._then);

  final _StationSelection _self;
  final $Res Function(_StationSelection) _then;

/// Create a copy of StationSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stations = null,Object? selected = null,Object? source = null,}) {
  return _then(_StationSelection(
stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<GautrainStation>,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as GautrainStation,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as StationSource,
  ));
}

/// Create a copy of StationSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GautrainStationCopyWith<$Res> get selected {
  
  return $GautrainStationCopyWith<$Res>(_self.selected, (value) {
    return _then(_self.copyWith(selected: value));
  });
}
}

// dart format on
