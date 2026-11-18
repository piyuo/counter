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
 int get year; int get month;/// Typical weekday 5-minute profile for this month. Matching time slots
/// are averaged across available weekdays. Missing slots are omitted.
@ObservationSeriesConverter() ObservationSeries get weekdayFiveMinuteObservation;/// Typical weekend 5-minute profile for this month. Matching time slots
/// are averaged across available weekend days. Missing slots are omitted.
@ObservationSeriesConverter() ObservationSeries get weekendFiveMinuteObservation;/// Hourly observations aggregated from the DaySummary's hourly observations.
/// there are 24 observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends in hourly observations.
 List<Observation> get hourlyTotals;/// Day observations aggregated from the DaySummary's daily observations.
/// there is one observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends day by day.
 List<Observation> get dailyTotals;/// Monthly observation aggregated from the daily observations.
 Observation get monthlyTotal;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummary&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&const DeepCollectionEquality().equals(other.weekdayFiveMinuteObservation, _this.weekdayFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.weekendFiveMinuteObservation, _this.weekendFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.hourlyTotals, _this.hourlyTotals)&&const DeepCollectionEquality().equals(other.dailyTotals, _this.dailyTotals)&&(identical(other.monthlyTotal, _this.monthlyTotal) || other.monthlyTotal == _this.monthlyTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthSummary;
  return Object.hash(runtimeType,_this.year,_this.month,const DeepCollectionEquality().hash(_this.weekdayFiveMinuteObservation),const DeepCollectionEquality().hash(_this.weekendFiveMinuteObservation),const DeepCollectionEquality().hash(_this.hourlyTotals),const DeepCollectionEquality().hash(_this.dailyTotals),_this.monthlyTotal);
}



}

/// @nodoc
abstract mixin class $MonthSummaryCopyWith<$Res>  {
  factory $MonthSummaryCopyWith(MonthSummary value, $Res Function(MonthSummary) _then) = _$MonthSummaryCopyWithImpl;
@useResult
$Res call({
 int year, int month,@ObservationSeriesConverter() ObservationSeries weekdayFiveMinuteObservation,@ObservationSeriesConverter() ObservationSeries weekendFiveMinuteObservation, List<Observation> hourlyTotals, List<Observation> dailyTotals, Observation monthlyTotal
});


$ObservationCopyWith<$Res> get monthlyTotal;

}
/// @nodoc
class _$MonthSummaryCopyWithImpl<$Res>
    implements $MonthSummaryCopyWith<$Res> {
  _$MonthSummaryCopyWithImpl(this._self, this._then);

  final MonthSummary _self;
  final $Res Function(MonthSummary) _then;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? weekdayFiveMinuteObservation = null,Object? weekendFiveMinuteObservation = null,Object? hourlyTotals = null,Object? dailyTotals = null,Object? monthlyTotal = null,}) {
  return _then(MonthSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,weekdayFiveMinuteObservation: null == weekdayFiveMinuteObservation ? _self.weekdayFiveMinuteObservation : weekdayFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,weekendFiveMinuteObservation: null == weekendFiveMinuteObservation ? _self.weekendFiveMinuteObservation : weekendFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,hourlyTotals: null == hourlyTotals ? _self.hourlyTotals : hourlyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyTotals: null == dailyTotals ? _self.dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyTotal: null == monthlyTotal ? _self.monthlyTotal : monthlyTotal // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}
/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get monthlyTotal {
  
  return $ObservationCopyWith<$Res>(_self.monthlyTotal, (value) {
    return _then(_self.copyWith(monthlyTotal: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month, @ObservationSeriesConverter()  ObservationSeries weekdayFiveMinuteObservation, @ObservationSeriesConverter()  ObservationSeries weekendFiveMinuteObservation,  List<Observation> hourlyTotals,  List<Observation> dailyTotals,  Observation monthlyTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.year,_that.month,_that.weekdayFiveMinuteObservation,_that.weekendFiveMinuteObservation,_that.hourlyTotals,_that.dailyTotals,_that.monthlyTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month, @ObservationSeriesConverter()  ObservationSeries weekdayFiveMinuteObservation, @ObservationSeriesConverter()  ObservationSeries weekendFiveMinuteObservation,  List<Observation> hourlyTotals,  List<Observation> dailyTotals,  Observation monthlyTotal)  $default,) {final _that = this;
switch (_that) {
case _MonthSummary():
return $default(_that.year,_that.month,_that.weekdayFiveMinuteObservation,_that.weekendFiveMinuteObservation,_that.hourlyTotals,_that.dailyTotals,_that.monthlyTotal);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month, @ObservationSeriesConverter()  ObservationSeries weekdayFiveMinuteObservation, @ObservationSeriesConverter()  ObservationSeries weekendFiveMinuteObservation,  List<Observation> hourlyTotals,  List<Observation> dailyTotals,  Observation monthlyTotal)?  $default,) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.year,_that.month,_that.weekdayFiveMinuteObservation,_that.weekendFiveMinuteObservation,_that.hourlyTotals,_that.dailyTotals,_that.monthlyTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthSummary extends MonthSummary {
  const _MonthSummary({required this.year, required this.month, @ObservationSeriesConverter() required this.weekdayFiveMinuteObservation, @ObservationSeriesConverter() required this.weekendFiveMinuteObservation, required  List<Observation> hourlyTotals, required  List<Observation> dailyTotals, required this.monthlyTotal}): _hourlyTotals = hourlyTotals,_dailyTotals = dailyTotals,super._();
  factory _MonthSummary.fromJson(Map<String, dynamic> json) => _$MonthSummaryFromJson(json);

/// for example: year=2026, month=1
@override final  int year;
@override final  int month;
/// Typical weekday 5-minute profile for this month. Matching time slots
/// are averaged across available weekdays. Missing slots are omitted.
@override@ObservationSeriesConverter() final  ObservationSeries weekdayFiveMinuteObservation;
/// Typical weekend 5-minute profile for this month. Matching time slots
/// are averaged across available weekend days. Missing slots are omitted.
@override@ObservationSeriesConverter() final  ObservationSeries weekendFiveMinuteObservation;
/// Hourly observations aggregated from the DaySummary's hourly observations.
/// there are 24 observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends in hourly observations.
 final  List<Observation> _hourlyTotals;
/// Hourly observations aggregated from the DaySummary's hourly observations.
/// there are 24 observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends in hourly observations.
@override List<Observation> get hourlyTotals {
  if (_hourlyTotals is EqualUnmodifiableListView) return _hourlyTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourlyTotals);
}

/// Day observations aggregated from the DaySummary's daily observations.
/// there is one observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends day by day.
 final  List<Observation> _dailyTotals;
/// Day observations aggregated from the DaySummary's daily observations.
/// there is one observation a day, multiplied by the number of days in the month.
/// useful for analyzing monthly trends day by day.
@override List<Observation> get dailyTotals {
  if (_dailyTotals is EqualUnmodifiableListView) return _dailyTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyTotals);
}

/// Monthly observation aggregated from the daily observations.
@override final  Observation monthlyTotal;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthSummary&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.weekdayFiveMinuteObservation, weekdayFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.weekendFiveMinuteObservation, weekendFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.hourlyTotals, _hourlyTotals)&&const DeepCollectionEquality().equals(other.dailyTotals, _dailyTotals)&&(identical(other.monthlyTotal, monthlyTotal) || other.monthlyTotal == monthlyTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(weekdayFiveMinuteObservation),const DeepCollectionEquality().hash(weekendFiveMinuteObservation),const DeepCollectionEquality().hash(_hourlyTotals),const DeepCollectionEquality().hash(_dailyTotals),monthlyTotal);
}



}

/// @nodoc
abstract mixin class _$MonthSummaryCopyWith<$Res> implements $MonthSummaryCopyWith<$Res> {
  factory _$MonthSummaryCopyWith(_MonthSummary value, $Res Function(_MonthSummary) _then) = __$MonthSummaryCopyWithImpl;
@override @useResult
$Res call({
 int year, int month,@ObservationSeriesConverter() ObservationSeries weekdayFiveMinuteObservation,@ObservationSeriesConverter() ObservationSeries weekendFiveMinuteObservation, List<Observation> hourlyTotals, List<Observation> dailyTotals, Observation monthlyTotal
});


@override $ObservationCopyWith<$Res> get monthlyTotal;

}
/// @nodoc
class __$MonthSummaryCopyWithImpl<$Res>
    implements _$MonthSummaryCopyWith<$Res> {
  __$MonthSummaryCopyWithImpl(this._self, this._then);

  final _MonthSummary _self;
  final $Res Function(_MonthSummary) _then;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? weekdayFiveMinuteObservation = null,Object? weekendFiveMinuteObservation = null,Object? hourlyTotals = null,Object? dailyTotals = null,Object? monthlyTotal = null,}) {
  return _then(_MonthSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,weekdayFiveMinuteObservation: null == weekdayFiveMinuteObservation ? _self.weekdayFiveMinuteObservation : weekdayFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,weekendFiveMinuteObservation: null == weekendFiveMinuteObservation ? _self.weekendFiveMinuteObservation : weekendFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,hourlyTotals: null == hourlyTotals ? _self._hourlyTotals : hourlyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyTotals: null == dailyTotals ? _self._dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyTotal: null == monthlyTotal ? _self.monthlyTotal : monthlyTotal // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get monthlyTotal {
  
  return $ObservationCopyWith<$Res>(_self.monthlyTotal, (value) {
    return _then(_self.copyWith(monthlyTotal: value));
  });
}
}

// dart format on
