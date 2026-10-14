// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonthSummary {

/// for example: year=2026, month=1
 int get year; int get month;/// 5-minute observations, max 288 per day. a typical day to represent the month
/// average from fiveMinuteObservations in day summary
/// useful to compare any day with this month average.
 List<Observation> get fiveMinuteObservations;/// Hourly observations aggregated from the DaySummary's hourly observations.
/// there are 24 observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends in hourly observations.
 List<Observation> get hourlyObservations;/// Day observations aggregated from the DaySummary's daily observations.
/// there is one observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends day by day.
 List<Observation> get dailyObservations;/// Monthly observation aggregated from the daily observations.
 Observation get monthlyObservation;
/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthSummaryCopyWith<MonthSummary> get copyWith => _$MonthSummaryCopyWithImpl<MonthSummary>(this as MonthSummary, _$identity);

  /// Serializes this MonthSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MonthSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummary&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&const DeepCollectionEquality().equals(other.fiveMinuteObservations, _this.fiveMinuteObservations)&&const DeepCollectionEquality().equals(other.hourlyObservations, _this.hourlyObservations)&&const DeepCollectionEquality().equals(other.dailyObservations, _this.dailyObservations)&&(identical(other.monthlyObservation, _this.monthlyObservation) || other.monthlyObservation == _this.monthlyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthSummary;
  return Object.hash(runtimeType,_this.year,_this.month,const DeepCollectionEquality().hash(_this.fiveMinuteObservations),const DeepCollectionEquality().hash(_this.hourlyObservations),const DeepCollectionEquality().hash(_this.dailyObservations),_this.monthlyObservation);
}



}

/// @nodoc
abstract mixin class $MonthSummaryCopyWith<$Res>  {
  factory $MonthSummaryCopyWith(MonthSummary value, $Res Function(MonthSummary) _then) = _$MonthSummaryCopyWithImpl;
@useResult
$Res call({
 int year, int month, List<Observation> fiveMinuteObservations, List<Observation> hourlyObservations, List<Observation> dailyObservations, Observation monthlyObservation
});


$ObservationCopyWith<$Res> get monthlyObservation;

}
/// @nodoc
class _$MonthSummaryCopyWithImpl<$Res>
    implements $MonthSummaryCopyWith<$Res> {
  _$MonthSummaryCopyWithImpl(this._self, this._then);

  final MonthSummary _self;
  final $Res Function(MonthSummary) _then;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? fiveMinuteObservations = null,Object? hourlyObservations = null,Object? dailyObservations = null,Object? monthlyObservation = null,}) {
  return _then(MonthSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,fiveMinuteObservations: null == fiveMinuteObservations ? _self.fiveMinuteObservations : fiveMinuteObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,hourlyObservations: null == hourlyObservations ? _self.hourlyObservations : hourlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyObservations: null == dailyObservations ? _self.dailyObservations : dailyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyObservation: null == monthlyObservation ? _self.monthlyObservation : monthlyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}
/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get monthlyObservation {
  
  return $ObservationCopyWith<$Res>(_self.monthlyObservation, (value) {
    return _then(_self.copyWith(monthlyObservation: value));
  });
}
}


/// Adds pattern-matching-related methods to [MonthSummary].
extension MonthSummaryPatterns on MonthSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthSummary value)  $default,){
final _that = this;
switch (_that) {
case _MonthSummary():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  List<Observation> fiveMinuteObservations,  List<Observation> hourlyObservations,  List<Observation> dailyObservations,  Observation monthlyObservation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.year,_that.month,_that.fiveMinuteObservations,_that.hourlyObservations,_that.dailyObservations,_that.monthlyObservation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  List<Observation> fiveMinuteObservations,  List<Observation> hourlyObservations,  List<Observation> dailyObservations,  Observation monthlyObservation)  $default,) {final _that = this;
switch (_that) {
case _MonthSummary():
return $default(_that.year,_that.month,_that.fiveMinuteObservations,_that.hourlyObservations,_that.dailyObservations,_that.monthlyObservation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  List<Observation> fiveMinuteObservations,  List<Observation> hourlyObservations,  List<Observation> dailyObservations,  Observation monthlyObservation)?  $default,) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.year,_that.month,_that.fiveMinuteObservations,_that.hourlyObservations,_that.dailyObservations,_that.monthlyObservation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthSummary extends MonthSummary {
  const _MonthSummary({required this.year, required this.month, required  List<Observation> fiveMinuteObservations, required  List<Observation> hourlyObservations, required  List<Observation> dailyObservations, required this.monthlyObservation}): _fiveMinuteObservations = fiveMinuteObservations,_hourlyObservations = hourlyObservations,_dailyObservations = dailyObservations,super._();
  factory _MonthSummary.fromJson(Map<String, dynamic> json) => _$MonthSummaryFromJson(json);

/// for example: year=2026, month=1
@override final  int year;
@override final  int month;
/// 5-minute observations, max 288 per day. a typical day to represent the month
/// average from fiveMinuteObservations in day summary
/// useful to compare any day with this month average.
 final  List<Observation> _fiveMinuteObservations;
/// 5-minute observations, max 288 per day. a typical day to represent the month
/// average from fiveMinuteObservations in day summary
/// useful to compare any day with this month average.
@override List<Observation> get fiveMinuteObservations {
  if (_fiveMinuteObservations is EqualUnmodifiableListView) return _fiveMinuteObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fiveMinuteObservations);
}

/// Hourly observations aggregated from the DaySummary's hourly observations.
/// there are 24 observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends in hourly observations.
 final  List<Observation> _hourlyObservations;
/// Hourly observations aggregated from the DaySummary's hourly observations.
/// there are 24 observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends in hourly observations.
@override List<Observation> get hourlyObservations {
  if (_hourlyObservations is EqualUnmodifiableListView) return _hourlyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourlyObservations);
}

/// Day observations aggregated from the DaySummary's daily observations.
/// there is one observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends day by day.
 final  List<Observation> _dailyObservations;
/// Day observations aggregated from the DaySummary's daily observations.
/// there is one observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends day by day.
@override List<Observation> get dailyObservations {
  if (_dailyObservations is EqualUnmodifiableListView) return _dailyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyObservations);
}

/// Monthly observation aggregated from the daily observations.
@override final  Observation monthlyObservation;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthSummaryCopyWith<_MonthSummary> get copyWith => __$MonthSummaryCopyWithImpl<_MonthSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthSummary&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.fiveMinuteObservations, _fiveMinuteObservations)&&const DeepCollectionEquality().equals(other.hourlyObservations, _hourlyObservations)&&const DeepCollectionEquality().equals(other.dailyObservations, _dailyObservations)&&(identical(other.monthlyObservation, monthlyObservation) || other.monthlyObservation == monthlyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(_fiveMinuteObservations),const DeepCollectionEquality().hash(_hourlyObservations),const DeepCollectionEquality().hash(_dailyObservations),monthlyObservation);
}



}

/// @nodoc
abstract mixin class _$MonthSummaryCopyWith<$Res> implements $MonthSummaryCopyWith<$Res> {
  factory _$MonthSummaryCopyWith(_MonthSummary value, $Res Function(_MonthSummary) _then) = __$MonthSummaryCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, List<Observation> fiveMinuteObservations, List<Observation> hourlyObservations, List<Observation> dailyObservations, Observation monthlyObservation
});


@override $ObservationCopyWith<$Res> get monthlyObservation;

}
/// @nodoc
class __$MonthSummaryCopyWithImpl<$Res>
    implements _$MonthSummaryCopyWith<$Res> {
  __$MonthSummaryCopyWithImpl(this._self, this._then);

  final _MonthSummary _self;
  final $Res Function(_MonthSummary) _then;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? fiveMinuteObservations = null,Object? hourlyObservations = null,Object? dailyObservations = null,Object? monthlyObservation = null,}) {
  return _then(_MonthSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,fiveMinuteObservations: null == fiveMinuteObservations ? _self._fiveMinuteObservations : fiveMinuteObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,hourlyObservations: null == hourlyObservations ? _self._hourlyObservations : hourlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyObservations: null == dailyObservations ? _self._dailyObservations : dailyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyObservation: null == monthlyObservation ? _self.monthlyObservation : monthlyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get monthlyObservation {
  
  return $ObservationCopyWith<$Res>(_self.monthlyObservation, (value) {
    return _then(_self.copyWith(monthlyObservation: value));
  });
}
}

// dart format on
