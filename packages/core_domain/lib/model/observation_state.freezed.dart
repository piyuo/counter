// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ObservationState {


/// Create a copy of ObservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationStateCopyWith<ObservationState> get copyWith => _$ObservationStateCopyWithImpl<ObservationState>(this as ObservationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ObservationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.observationStartUtc, _this.observationStartUtc) || other.observationStartUtc == _this.observationStartUtc)&&(identical(other.liveObservation, _this.liveObservation) || other.liveObservation == _this.liveObservation));
}


@override
int get hashCode {
  final _this = this as ObservationState;
  return Object.hash(runtimeType,_this.status,_this.observationStartUtc,_this.liveObservation);
}

@override
String toString() {
  final _this = this as ObservationState;
  return 'ObservationState(status: ${_this.status}, observationStart: ${_this.observationStartUtc}, liveObservation: ${_this.liveObservation})';
}


}

/// @nodoc
abstract mixin class $ObservationStateCopyWith<$Res>  {
  factory $ObservationStateCopyWith(ObservationState value, $Res Function(ObservationState) _then) = _$ObservationStateCopyWithImpl;
@useResult
$Res call({
 core_domain.Observation? liveObservation, ObservationStatus status, DateTime? observationStart
});




}
/// @nodoc
class _$ObservationStateCopyWithImpl<$Res>
    implements $ObservationStateCopyWith<$Res> {
  _$ObservationStateCopyWithImpl(this._self, this._then);

  final ObservationState _self;
  final $Res Function(ObservationState) _then;

/// Create a copy of ObservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? liveObservation = freezed,Object? status = null,Object? observationStart = freezed,}) {
  return _then(ObservationState(
liveObservation: freezed == liveObservation ? _self.liveObservation : liveObservation // ignore: cast_nullable_to_non_nullable
as core_domain.Observation?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ObservationStatus,observationStartUtc: freezed == observationStart ? _self.observationStartUtc : observationStart // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ObservationState].
extension ObservationStatePatterns on ObservationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
