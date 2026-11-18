// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummary {

/// for example: year=2026
 int get year;/// Typical weekday 5-minute profile for this year, averaged across the
/// available weekday profiles from each month. Missing slots are omitted.
@ObservationSeriesConverter() ObservationSeries get weekdayFiveMinuteObservation;/// Typical weekend 5-minute profile for this year, averaged across the
/// available weekend profiles from each month. Missing slots are omitted.
@ObservationSeriesConverter() ObservationSeries get weekendFiveMinuteObservation;/// Day observations aggregated from the MonthSummary's daily observations.
/// there is one observation a day, 365 in a non-leap year.
/// useful for analyzing trends day by day.
 List<Observation> get dailyTotals;/// Month observations aggregated from the MonthSummary's monthly observations.
/// there is 1 observation a month, 12 in a year.
/// useful for analyzing trends month by month.
 List<Observation> get monthlyTotals;/// Yearly observation aggregated from the monthly observations.
 Observation get yearlyTotal;
/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YearSummaryCopyWith<YearSummary> get copyWith => _$YearSummaryCopyWithImpl<YearSummary>(this as YearSummary, _$identity);

  /// Serializes this YearSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YearSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YearSummary&&(identical(other.year, _this.year) || other.year == _this.year)&&const DeepCollectionEquality().equals(other.weekdayFiveMinuteObservation, _this.weekdayFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.weekendFiveMinuteObservation, _this.weekendFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.dailyTotals, _this.dailyTotals)&&const DeepCollectionEquality().equals(other.monthlyTotals, _this.monthlyTotals)&&(identical(other.yearlyTotal, _this.yearlyTotal) || other.yearlyTotal == _this.yearlyTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YearSummary;
  return Object.hash(runtimeType,_this.year,const DeepCollectionEquality().hash(_this.weekdayFiveMinuteObservation),const DeepCollectionEquality().hash(_this.weekendFiveMinuteObservation),const DeepCollectionEquality().hash(_this.dailyTotals),const DeepCollectionEquality().hash(_this.monthlyTotals),_this.yearlyTotal);
}



}

/// @nodoc
abstract mixin class $YearSummaryCopyWith<$Res>  {
  factory $YearSummaryCopyWith(YearSummary value, $Res Function(YearSummary) _then) = _$YearSummaryCopyWithImpl;
@useResult
$Res call({
 int year,@ObservationSeriesConverter() ObservationSeries weekdayFiveMinuteObservation,@ObservationSeriesConverter() ObservationSeries weekendFiveMinuteObservation, List<Observation> dailyTotals, List<Observation> monthlyTotals, Observation yearlyTotal
});


$ObservationCopyWith<$Res> get yearlyTotal;

}
/// @nodoc
class _$YearSummaryCopyWithImpl<$Res>
    implements $YearSummaryCopyWith<$Res> {
  _$YearSummaryCopyWithImpl(this._self, this._then);

  final YearSummary _self;
  final $Res Function(YearSummary) _then;

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? weekdayFiveMinuteObservation = null,Object? weekendFiveMinuteObservation = null,Object? dailyTotals = null,Object? monthlyTotals = null,Object? yearlyTotal = null,}) {
  return _then(YearSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,weekdayFiveMinuteObservation: null == weekdayFiveMinuteObservation ? _self.weekdayFiveMinuteObservation : weekdayFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,weekendFiveMinuteObservation: null == weekendFiveMinuteObservation ? _self.weekendFiveMinuteObservation : weekendFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,dailyTotals: null == dailyTotals ? _self.dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyTotals: null == monthlyTotals ? _self.monthlyTotals : monthlyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,yearlyTotal: null == yearlyTotal ? _self.yearlyTotal : yearlyTotal // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}
/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get yearlyTotal {
  
  return $ObservationCopyWith<$Res>(_self.yearlyTotal, (value) {
    return _then(_self.copyWith(yearlyTotal: value));
  });
}
}


/// Adds pattern-matching-related methods to [YearSummary].
extension YearSummaryPatterns on YearSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YearSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YearSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YearSummary value)  $default,){
final _that = this;
switch (_that) {
case _YearSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YearSummary value)?  $default,){
final _that = this;
switch (_that) {
case _YearSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year, @ObservationSeriesConverter()  ObservationSeries weekdayFiveMinuteObservation, @ObservationSeriesConverter()  ObservationSeries weekendFiveMinuteObservation,  List<Observation> dailyTotals,  List<Observation> monthlyTotals,  Observation yearlyTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YearSummary() when $default != null:
return $default(_that.year,_that.weekdayFiveMinuteObservation,_that.weekendFiveMinuteObservation,_that.dailyTotals,_that.monthlyTotals,_that.yearlyTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year, @ObservationSeriesConverter()  ObservationSeries weekdayFiveMinuteObservation, @ObservationSeriesConverter()  ObservationSeries weekendFiveMinuteObservation,  List<Observation> dailyTotals,  List<Observation> monthlyTotals,  Observation yearlyTotal)  $default,) {final _that = this;
switch (_that) {
case _YearSummary():
return $default(_that.year,_that.weekdayFiveMinuteObservation,_that.weekendFiveMinuteObservation,_that.dailyTotals,_that.monthlyTotals,_that.yearlyTotal);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year, @ObservationSeriesConverter()  ObservationSeries weekdayFiveMinuteObservation, @ObservationSeriesConverter()  ObservationSeries weekendFiveMinuteObservation,  List<Observation> dailyTotals,  List<Observation> monthlyTotals,  Observation yearlyTotal)?  $default,) {final _that = this;
switch (_that) {
case _YearSummary() when $default != null:
return $default(_that.year,_that.weekdayFiveMinuteObservation,_that.weekendFiveMinuteObservation,_that.dailyTotals,_that.monthlyTotals,_that.yearlyTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YearSummary extends YearSummary {
  const _YearSummary({required this.year, @ObservationSeriesConverter() required this.weekdayFiveMinuteObservation, @ObservationSeriesConverter() required this.weekendFiveMinuteObservation, required  List<Observation> dailyTotals, required  List<Observation> monthlyTotals, required this.yearlyTotal}): _dailyTotals = dailyTotals,_monthlyTotals = monthlyTotals,super._();
  factory _YearSummary.fromJson(Map<String, dynamic> json) => _$YearSummaryFromJson(json);

/// for example: year=2026
@override final  int year;
/// Typical weekday 5-minute profile for this year, averaged across the
/// available weekday profiles from each month. Missing slots are omitted.
@override@ObservationSeriesConverter() final  ObservationSeries weekdayFiveMinuteObservation;
/// Typical weekend 5-minute profile for this year, averaged across the
/// available weekend profiles from each month. Missing slots are omitted.
@override@ObservationSeriesConverter() final  ObservationSeries weekendFiveMinuteObservation;
/// Day observations aggregated from the MonthSummary's daily observations.
/// there is one observation a day, 365 in a non-leap year.
/// useful for analyzing trends day by day.
 final  List<Observation> _dailyTotals;
/// Day observations aggregated from the MonthSummary's daily observations.
/// there is one observation a day, 365 in a non-leap year.
/// useful for analyzing trends day by day.
@override List<Observation> get dailyTotals {
  if (_dailyTotals is EqualUnmodifiableListView) return _dailyTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyTotals);
}

/// Month observations aggregated from the MonthSummary's monthly observations.
/// there is 1 observation a month, 12 in a year.
/// useful for analyzing trends month by month.
 final  List<Observation> _monthlyTotals;
/// Month observations aggregated from the MonthSummary's monthly observations.
/// there is 1 observation a month, 12 in a year.
/// useful for analyzing trends month by month.
@override List<Observation> get monthlyTotals {
  if (_monthlyTotals is EqualUnmodifiableListView) return _monthlyTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyTotals);
}

/// Yearly observation aggregated from the monthly observations.
@override final  Observation yearlyTotal;

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YearSummaryCopyWith<_YearSummary> get copyWith => __$YearSummaryCopyWithImpl<_YearSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YearSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YearSummary&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.weekdayFiveMinuteObservation, weekdayFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.weekendFiveMinuteObservation, weekendFiveMinuteObservation)&&const DeepCollectionEquality().equals(other.dailyTotals, _dailyTotals)&&const DeepCollectionEquality().equals(other.monthlyTotals, _monthlyTotals)&&(identical(other.yearlyTotal, yearlyTotal) || other.yearlyTotal == yearlyTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,const DeepCollectionEquality().hash(weekdayFiveMinuteObservation),const DeepCollectionEquality().hash(weekendFiveMinuteObservation),const DeepCollectionEquality().hash(_dailyTotals),const DeepCollectionEquality().hash(_monthlyTotals),yearlyTotal);
}



}

/// @nodoc
abstract mixin class _$YearSummaryCopyWith<$Res> implements $YearSummaryCopyWith<$Res> {
  factory _$YearSummaryCopyWith(_YearSummary value, $Res Function(_YearSummary) _then) = __$YearSummaryCopyWithImpl;
@override @useResult
$Res call({
 int year,@ObservationSeriesConverter() ObservationSeries weekdayFiveMinuteObservation,@ObservationSeriesConverter() ObservationSeries weekendFiveMinuteObservation, List<Observation> dailyTotals, List<Observation> monthlyTotals, Observation yearlyTotal
});


@override $ObservationCopyWith<$Res> get yearlyTotal;

}
/// @nodoc
class __$YearSummaryCopyWithImpl<$Res>
    implements _$YearSummaryCopyWith<$Res> {
  __$YearSummaryCopyWithImpl(this._self, this._then);

  final _YearSummary _self;
  final $Res Function(_YearSummary) _then;

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? weekdayFiveMinuteObservation = null,Object? weekendFiveMinuteObservation = null,Object? dailyTotals = null,Object? monthlyTotals = null,Object? yearlyTotal = null,}) {
  return _then(_YearSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,weekdayFiveMinuteObservation: null == weekdayFiveMinuteObservation ? _self.weekdayFiveMinuteObservation : weekdayFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,weekendFiveMinuteObservation: null == weekendFiveMinuteObservation ? _self.weekendFiveMinuteObservation : weekendFiveMinuteObservation // ignore: cast_nullable_to_non_nullable
as ObservationSeries,dailyTotals: null == dailyTotals ? _self._dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyTotals: null == monthlyTotals ? _self._monthlyTotals : monthlyTotals // ignore: cast_nullable_to_non_nullable
as List<Observation>,yearlyTotal: null == yearlyTotal ? _self.yearlyTotal : yearlyTotal // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get yearlyTotal {
  
  return $ObservationCopyWith<$Res>(_self.yearlyTotal, (value) {
    return _then(_self.copyWith(yearlyTotal: value));
  });
}
}

// dart format on
