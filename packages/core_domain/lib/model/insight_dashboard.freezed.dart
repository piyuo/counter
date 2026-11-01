// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InsightDashboard {


/// Create a copy of InsightDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightDashboardCopyWith<InsightDashboard> get copyWith => _$InsightDashboardCopyWithImpl<InsightDashboard>(this as InsightDashboard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InsightDashboard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsightDashboard&&(identical(other.businessDate, _this.businessDate) || other.businessDate == _this.businessDate)&&(identical(other.comparisonPeriod, _this.comparisonPeriod) || other.comparisonPeriod == _this.comparisonPeriod)&&(identical(other.recentHourObservation, _this.recentHourObservation) || other.recentHourObservation == _this.recentHourObservation)&&(identical(other.comparisonRecentHourObservation, _this.comparisonRecentHourObservation) || other.comparisonRecentHourObservation == _this.comparisonRecentHourObservation)&&const DeepCollectionEquality().equals(other.todaySeries, _this.todaySeries)&&const DeepCollectionEquality().equals(other.comparisonSeries, _this.comparisonSeries)&&(identical(other.comparisonTypicalDay, _this.comparisonTypicalDay) || other.comparisonTypicalDay == _this.comparisonTypicalDay));
}


@override
int get hashCode {
  final _this = this as InsightDashboard;
  return Object.hash(runtimeType,_this.businessDate,_this.comparisonPeriod,_this.recentHourObservation,_this.comparisonRecentHourObservation,const DeepCollectionEquality().hash(_this.todaySeries),const DeepCollectionEquality().hash(_this.comparisonSeries),_this.comparisonTypicalDay);
}

@override
String toString() {
  final _this = this as InsightDashboard;
  return 'InsightDashboard(businessDate: ${_this.businessDate}, comparisonPeriod: ${_this.comparisonPeriod}, recentHourObservation: ${_this.recentHourObservation}, comparisonRecentHourObservation: ${_this.comparisonRecentHourObservation}, todaySeries: ${_this.todaySeries}, comparisonSeries: ${_this.comparisonSeries}, comparisonTypicalDay: ${_this.comparisonTypicalDay})';
}


}

/// @nodoc
abstract mixin class $InsightDashboardCopyWith<$Res>  {
  factory $InsightDashboardCopyWith(InsightDashboard value, $Res Function(InsightDashboard) _then) = _$InsightDashboardCopyWithImpl;
@useResult
$Res call({
 String businessDate, TrafficComparisonPeriod comparisonPeriod, Observation? recentHourObservation, Observation? comparisonRecentHourObservation, ObservationSeries? todaySeries, ObservationSeries? comparisonSeries, Observation? comparisonTypicalDay
});




}
/// @nodoc
class _$InsightDashboardCopyWithImpl<$Res>
    implements $InsightDashboardCopyWith<$Res> {
  _$InsightDashboardCopyWithImpl(this._self, this._then);

  final InsightDashboard _self;
  final $Res Function(InsightDashboard) _then;

/// Create a copy of InsightDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessDate = null,Object? comparisonPeriod = null,Object? recentHourObservation = freezed,Object? comparisonRecentHourObservation = freezed,Object? todaySeries = freezed,Object? comparisonSeries = freezed,Object? comparisonTypicalDay = freezed,}) {
  return _then(InsightDashboard(
businessDate: null == businessDate ? _self.businessDate : businessDate // ignore: cast_nullable_to_non_nullable
as String,comparisonPeriod: null == comparisonPeriod ? _self.comparisonPeriod : comparisonPeriod // ignore: cast_nullable_to_non_nullable
as TrafficComparisonPeriod,recentHourObservation: freezed == recentHourObservation ? _self.recentHourObservation : recentHourObservation // ignore: cast_nullable_to_non_nullable
as Observation?,comparisonRecentHourObservation: freezed == comparisonRecentHourObservation ? _self.comparisonRecentHourObservation : comparisonRecentHourObservation // ignore: cast_nullable_to_non_nullable
as Observation?,todaySeries: freezed == todaySeries ? _self.todaySeries : todaySeries // ignore: cast_nullable_to_non_nullable
as ObservationSeries?,comparisonSeries: freezed == comparisonSeries ? _self.comparisonSeries : comparisonSeries // ignore: cast_nullable_to_non_nullable
as ObservationSeries?,comparisonTypicalDay: freezed == comparisonTypicalDay ? _self.comparisonTypicalDay : comparisonTypicalDay // ignore: cast_nullable_to_non_nullable
as Observation?,
  ));
}

}


/// Adds pattern-matching-related methods to [InsightDashboard].
extension InsightDashboardPatterns on InsightDashboard {
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
