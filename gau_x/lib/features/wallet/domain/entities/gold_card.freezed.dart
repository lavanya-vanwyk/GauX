// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gold_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoldCard {

 double get balance;/// Newest first.
 List<LedgerEntry> get ledger;
/// Create a copy of GoldCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoldCardCopyWith<GoldCard> get copyWith => _$GoldCardCopyWithImpl<GoldCard>(this as GoldCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoldCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoldCard&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&const DeepCollectionEquality().equals(other.ledger, _this.ledger));
}


@override
int get hashCode {
  final _this = this as GoldCard;
  return Object.hash(runtimeType,_this.balance,const DeepCollectionEquality().hash(_this.ledger));
}

@override
String toString() {
  final _this = this as GoldCard;
  return 'GoldCard(balance: ${_this.balance}, ledger: ${_this.ledger})';
}


}

/// @nodoc
abstract mixin class $GoldCardCopyWith<$Res>  {
  factory $GoldCardCopyWith(GoldCard value, $Res Function(GoldCard) _then) = _$GoldCardCopyWithImpl;
@useResult
$Res call({
 double balance, List<LedgerEntry> ledger
});




}
/// @nodoc
class _$GoldCardCopyWithImpl<$Res>
    implements $GoldCardCopyWith<$Res> {
  _$GoldCardCopyWithImpl(this._self, this._then);

  final GoldCard _self;
  final $Res Function(GoldCard) _then;

/// Create a copy of GoldCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? ledger = null,}) {
  return _then(GoldCard(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,ledger: null == ledger ? _self.ledger : ledger // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [GoldCard].
extension GoldCardPatterns on GoldCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoldCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoldCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoldCard value)  $default,){
final _that = this;
switch (_that) {
case _GoldCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoldCard value)?  $default,){
final _that = this;
switch (_that) {
case _GoldCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double balance,  List<LedgerEntry> ledger)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoldCard() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double balance,  List<LedgerEntry> ledger)  $default,) {final _that = this;
switch (_that) {
case _GoldCard():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double balance,  List<LedgerEntry> ledger)?  $default,) {final _that = this;
switch (_that) {
case _GoldCard() when $default != null:
return $default(_that.balance,_that.ledger);case _:
  return null;

}
}

}

/// @nodoc


class _GoldCard extends GoldCard {
  const _GoldCard({required this.balance,  List<LedgerEntry> ledger = const <LedgerEntry>[]}): _ledger = ledger,super._();
  

@override final  double balance;
/// Newest first.
 final  List<LedgerEntry> _ledger;
/// Newest first.
@override@JsonKey() List<LedgerEntry> get ledger {
  if (_ledger is EqualUnmodifiableListView) return _ledger;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ledger);
}


/// Create a copy of GoldCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoldCardCopyWith<_GoldCard> get copyWith => __$GoldCardCopyWithImpl<_GoldCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoldCard&&(identical(other.balance, balance) || other.balance == balance)&&const DeepCollectionEquality().equals(other.ledger, _ledger));
}


@override
int get hashCode {
    return Object.hash(runtimeType,balance,const DeepCollectionEquality().hash(_ledger));
}

@override
String toString() {
    return 'GoldCard(balance: $balance, ledger: $ledger)';
}


}

/// @nodoc
abstract mixin class _$GoldCardCopyWith<$Res> implements $GoldCardCopyWith<$Res> {
  factory _$GoldCardCopyWith(_GoldCard value, $Res Function(_GoldCard) _then) = __$GoldCardCopyWithImpl;
@override @useResult
$Res call({
 double balance, List<LedgerEntry> ledger
});




}
/// @nodoc
class __$GoldCardCopyWithImpl<$Res>
    implements _$GoldCardCopyWith<$Res> {
  __$GoldCardCopyWithImpl(this._self, this._then);

  final _GoldCard _self;
  final $Res Function(_GoldCard) _then;

/// Create a copy of GoldCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? ledger = null,}) {
  return _then(_GoldCard(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,ledger: null == ledger ? _self._ledger : ledger // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,
  ));
}


}

// dart format on
