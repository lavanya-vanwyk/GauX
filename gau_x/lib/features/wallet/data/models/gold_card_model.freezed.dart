// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gold_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoldCardModel {

 double get balance; List<LedgerEntryModel> get ledger;
/// Create a copy of GoldCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoldCardModelCopyWith<GoldCardModel> get copyWith => _$GoldCardModelCopyWithImpl<GoldCardModel>(this as GoldCardModel, _$identity);

  /// Serializes this GoldCardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GoldCardModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoldCardModel&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&const DeepCollectionEquality().equals(other.ledger, _this.ledger));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GoldCardModel;
  return Object.hash(runtimeType,_this.balance,const DeepCollectionEquality().hash(_this.ledger));
}

@override
String toString() {
  final _this = this as GoldCardModel;
  return 'GoldCardModel(balance: ${_this.balance}, ledger: ${_this.ledger})';
}


}

/// @nodoc
abstract mixin class $GoldCardModelCopyWith<$Res>  {
  factory $GoldCardModelCopyWith(GoldCardModel value, $Res Function(GoldCardModel) _then) = _$GoldCardModelCopyWithImpl;
@useResult
$Res call({
 double balance, List<LedgerEntryModel> ledger
});




}
/// @nodoc
class _$GoldCardModelCopyWithImpl<$Res>
    implements $GoldCardModelCopyWith<$Res> {
  _$GoldCardModelCopyWithImpl(this._self, this._then);

  final GoldCardModel _self;
  final $Res Function(GoldCardModel) _then;

/// Create a copy of GoldCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? ledger = null,}) {
  return _then(GoldCardModel(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,ledger: null == ledger ? _self.ledger : ledger // ignore: cast_nullable_to_non_nullable
as List<LedgerEntryModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GoldCardModel].
extension GoldCardModelPatterns on GoldCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoldCardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoldCardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoldCardModel value)  $default,){
final _that = this;
switch (_that) {
case _GoldCardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoldCardModel value)?  $default,){
final _that = this;
switch (_that) {
case _GoldCardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double balance,  List<LedgerEntryModel> ledger)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoldCardModel() when $default != null:
return $default(_that.balance,_that.ledger);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double balance,  List<LedgerEntryModel> ledger)  $default,) {final _that = this;
switch (_that) {
case _GoldCardModel():
return $default(_that.balance,_that.ledger);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double balance,  List<LedgerEntryModel> ledger)?  $default,) {final _that = this;
switch (_that) {
case _GoldCardModel() when $default != null:
return $default(_that.balance,_that.ledger);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoldCardModel extends GoldCardModel {
  const _GoldCardModel({required this.balance,  List<LedgerEntryModel> ledger = const <LedgerEntryModel>[]}): _ledger = ledger,super._();
  factory _GoldCardModel.fromJson(Map<String, dynamic> json) => _$GoldCardModelFromJson(json);

@override final  double balance;
 final  List<LedgerEntryModel> _ledger;
@override@JsonKey() List<LedgerEntryModel> get ledger {
  if (_ledger is EqualUnmodifiableListView) return _ledger;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ledger);
}


/// Create a copy of GoldCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoldCardModelCopyWith<_GoldCardModel> get copyWith => __$GoldCardModelCopyWithImpl<_GoldCardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoldCardModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoldCardModel&&(identical(other.balance, balance) || other.balance == balance)&&const DeepCollectionEquality().equals(other.ledger, _ledger));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,balance,const DeepCollectionEquality().hash(_ledger));
}

@override
String toString() {
    return 'GoldCardModel(balance: $balance, ledger: $ledger)';
}


}

/// @nodoc
abstract mixin class _$GoldCardModelCopyWith<$Res> implements $GoldCardModelCopyWith<$Res> {
  factory _$GoldCardModelCopyWith(_GoldCardModel value, $Res Function(_GoldCardModel) _then) = __$GoldCardModelCopyWithImpl;
@override @useResult
$Res call({
 double balance, List<LedgerEntryModel> ledger
});




}
/// @nodoc
class __$GoldCardModelCopyWithImpl<$Res>
    implements _$GoldCardModelCopyWith<$Res> {
  __$GoldCardModelCopyWithImpl(this._self, this._then);

  final _GoldCardModel _self;
  final $Res Function(_GoldCardModel) _then;

/// Create a copy of GoldCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? ledger = null,}) {
  return _then(_GoldCardModel(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,ledger: null == ledger ? _self._ledger : ledger // ignore: cast_nullable_to_non_nullable
as List<LedgerEntryModel>,
  ));
}


}


/// @nodoc
mixin _$LedgerEntryModel {

 String get description; double get amount; DateTime get timestamp;
/// Create a copy of LedgerEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerEntryModelCopyWith<LedgerEntryModel> get copyWith => _$LedgerEntryModelCopyWithImpl<LedgerEntryModel>(this as LedgerEntryModel, _$identity);

  /// Serializes this LedgerEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LedgerEntryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerEntryModel&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LedgerEntryModel;
  return Object.hash(runtimeType,_this.description,_this.amount,_this.timestamp);
}

@override
String toString() {
  final _this = this as LedgerEntryModel;
  return 'LedgerEntryModel(description: ${_this.description}, amount: ${_this.amount}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $LedgerEntryModelCopyWith<$Res>  {
  factory $LedgerEntryModelCopyWith(LedgerEntryModel value, $Res Function(LedgerEntryModel) _then) = _$LedgerEntryModelCopyWithImpl;
@useResult
$Res call({
 String description, double amount, DateTime timestamp
});




}
/// @nodoc
class _$LedgerEntryModelCopyWithImpl<$Res>
    implements $LedgerEntryModelCopyWith<$Res> {
  _$LedgerEntryModelCopyWithImpl(this._self, this._then);

  final LedgerEntryModel _self;
  final $Res Function(LedgerEntryModel) _then;

/// Create a copy of LedgerEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? amount = null,Object? timestamp = null,}) {
  return _then(LedgerEntryModel(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerEntryModel].
extension LedgerEntryModelPatterns on LedgerEntryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerEntryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _LedgerEntryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerEntryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  double amount,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerEntryModel() when $default != null:
return $default(_that.description,_that.amount,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  double amount,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _LedgerEntryModel():
return $default(_that.description,_that.amount,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  double amount,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _LedgerEntryModel() when $default != null:
return $default(_that.description,_that.amount,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LedgerEntryModel extends LedgerEntryModel {
  const _LedgerEntryModel({required this.description, required this.amount, required this.timestamp}): super._();
  factory _LedgerEntryModel.fromJson(Map<String, dynamic> json) => _$LedgerEntryModelFromJson(json);

@override final  String description;
@override final  double amount;
@override final  DateTime timestamp;

/// Create a copy of LedgerEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerEntryModelCopyWith<_LedgerEntryModel> get copyWith => __$LedgerEntryModelCopyWithImpl<_LedgerEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LedgerEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerEntryModel&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,description,amount,timestamp);
}

@override
String toString() {
    return 'LedgerEntryModel(description: $description, amount: $amount, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$LedgerEntryModelCopyWith<$Res> implements $LedgerEntryModelCopyWith<$Res> {
  factory _$LedgerEntryModelCopyWith(_LedgerEntryModel value, $Res Function(_LedgerEntryModel) _then) = __$LedgerEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String description, double amount, DateTime timestamp
});




}
/// @nodoc
class __$LedgerEntryModelCopyWithImpl<$Res>
    implements _$LedgerEntryModelCopyWith<$Res> {
  __$LedgerEntryModelCopyWithImpl(this._self, this._then);

  final _LedgerEntryModel _self;
  final $Res Function(_LedgerEntryModel) _then;

/// Create a copy of LedgerEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? amount = null,Object? timestamp = null,}) {
  return _then(_LedgerEntryModel(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
