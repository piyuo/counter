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
 int get year;/// 5-minute observations, max 288 per day. a typical day to represent the year
/// average from fiveMinuteObservations in month summary
/// useful to compare any day with this year average.
 List<Observation> get fiveMinuteObservations;/// Day observations aggregated from the MonthSummary's daily observations.
/// there is one observation a day, 365 in a non-leap year.
/// useful for analyzing trends day by day.
 List<Observation> get dailyObservations;/// Month observations aggregated from the MonthSummary's monthly observations.
/// there is 1 observation a month, 12 in a year.
/// useful for analyzing trends month by month.
 List<Observation> get monthlyObservations;/// Yearly observation aggregated from the monthly observations.
 Observation get yearlyObservation;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YearSummary&&(identical(other.year, _this.year) || other.year == _this.year)&&const DeepCollectionEquality().equals(other.fiveMinuteObservations, _this.fiveMinuteObservations)&&const DeepCollectionEquality().equals(other.dailyObservations, _this.dailyObservations)&&const DeepCollectionEquality().equals(other.monthlyObservations, _this.monthlyObservations)&&(identical(other.yearlyObservation, _this.yearlyObservation) || other.yearlyObservation == _this.yearlyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YearSummary;
  return Object.hash(runtimeType,_this.year,const DeepCollectionEquality().hash(_this.fiveMinuteObservations),const DeepCollectionEquality().hash(_this.dailyObservations),const DeepCollectionEquality().hash(_this.monthlyObservations),_this.yearlyObservation);
}



}

/// @nodoc
abstract mixin class $YearSummaryCopyWith<$Res>  {
  factory $YearSummaryCopyWith(YearSummary value, $Res Function(YearSummary) _then) = _$YearSummaryCopyWithImpl;
@useResult
$Res call({
 int year, List<Observation> fiveMinuteObservations, List<Observation> dailyObservations, List<Observation> monthlyObservations, Observation yearlyObservation
});


$ObservationCopyWith<$Res> get yearlyObservation;

}
/// @nodoc
class _$YearSummaryCopyWithImpl<$Res>
    implements $YearSummaryCopyWith<$Res> {
  _$YearSummaryCopyWithImpl(this._self, this._then);

  final YearSummary _self;
  final $Res Function(YearSummary) _then;

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? fiveMinuteObservations = null,Object? dailyObservations = null,Object? monthlyObservations = null,Object? yearlyObservation = null,}) {
  return _then(YearSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,fiveMinuteObservations: null == fiveMinuteObservations ? _self.fiveMinuteObservations : fiveMinuteObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyObservations: null == dailyObservations ? _self.dailyObservations : dailyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyObservations: null == monthlyObservations ? _self.monthlyObservations : monthlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,yearlyObservation: null == yearlyObservation ? _self.yearlyObservation : yearlyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}
/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get yearlyObservation {
  
  return $ObservationCopyWith<$Res>(_self.yearlyObservation, (value) {
    return _then(_self.copyWith(yearlyObservation: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  List<Observation> fiveMinuteObservations,  List<Observation> dailyObservations,  List<Observation> monthlyObservations,  Observation yearlyObservation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YearSummary() when $default != null:
return $default(_that.year,_that.fiveMinuteObservations,_that.dailyObservations,_that.monthlyObservations,_that.yearlyObservation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  List<Observation> fiveMinuteObservations,  List<Observation> dailyObservations,  List<Observation> monthlyObservations,  Observation yearlyObservation)  $default,) {final _that = this;
switch (_that) {
case _YearSummary():
return $default(_that.year,_that.fiveMinuteObservations,_that.dailyObservations,_that.monthlyObservations,_that.yearlyObservation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  List<Observation> fiveMinuteObservations,  List<Observation> dailyObservations,  List<Observation> monthlyObservations,  Observation yearlyObservation)?  $default,) {final _that = this;
switch (_that) {
case _YearSummary() when $default != null:
return $default(_that.year,_that.fiveMinuteObservations,_that.dailyObservations,_that.monthlyObservations,_that.yearlyObservation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YearSummary extends YearSummary {
  const _YearSummary({required this.year, required  List<Observation> fiveMinuteObservations, required  List<Observation> dailyObservations, required  List<Observation> monthlyObservations, required this.yearlyObservation}): _fiveMinuteObservations = fiveMinuteObservations,_dailyObservations = dailyObservations,_monthlyObservations = monthlyObservations,super._();
  factory _YearSummary.fromJson(Map<String, dynamic> json) => _$YearSummaryFromJson(json);

/// for example: year=2026
@override final  int year;
/// 5-minute observations, max 288 per day. a typical day to represent the year
/// average from fiveMinuteObservations in month summary
/// useful to compare any day with this year average.
 final  List<Observation> _fiveMinuteObservations;
/// 5-minute observations, max 288 per day. a typical day to represent the year
/// average from fiveMinuteObservations in month summary
/// useful to compare any day with this year average.
@override List<Observation> get fiveMinuteObservations {
  if (_fiveMinuteObservations is EqualUnmodifiableListView) return _fiveMinuteObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fiveMinuteObservations);
}

/// Day observations aggregated from the MonthSummary's daily observations.
/// there is one observation a day, 365 in a non-leap year.
/// useful for analyzing trends day by day.
 final  List<Observation> _dailyObservations;
/// Day observations aggregated from the MonthSummary's daily observations.
/// there is one observation a day, 365 in a non-leap year.
/// useful for analyzing trends day by day.
@override List<Observation> get dailyObservations {
  if (_dailyObservations is EqualUnmodifiableListView) return _dailyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyObservations);
}

/// Month observations aggregated from the MonthSummary's monthly observations.
/// there is 1 observation a month, 12 in a year.
/// useful for analyzing trends month by month.
 final  List<Observation> _monthlyObservations;
/// Month observations aggregated from the MonthSummary's monthly observations.
/// there is 1 observation a month, 12 in a year.
/// useful for analyzing trends month by month.
@override List<Observation> get monthlyObservations {
  if (_monthlyObservations is EqualUnmodifiableListView) return _monthlyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyObservations);
}

/// Yearly observation aggregated from the monthly observations.
@override final  Observation yearlyObservation;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YearSummary&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.fiveMinuteObservations, _fiveMinuteObservations)&&const DeepCollectionEquality().equals(other.dailyObservations, _dailyObservations)&&const DeepCollectionEquality().equals(other.monthlyObservations, _monthlyObservations)&&(identical(other.yearlyObservation, yearlyObservation) || other.yearlyObservation == yearlyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,const DeepCollectionEquality().hash(_fiveMinuteObservations),const DeepCollectionEquality().hash(_dailyObservations),const DeepCollectionEquality().hash(_monthlyObservations),yearlyObservation);
}



}

/// @nodoc
abstract mixin class _$YearSummaryCopyWith<$Res> implements $YearSummaryCopyWith<$Res> {
  factory _$YearSummaryCopyWith(_YearSummary value, $Res Function(_YearSummary) _then) = __$YearSummaryCopyWithImpl;
@override @useResult
$Res call({
 int year, List<Observation> fiveMinuteObservations, List<Observation> dailyObservations, List<Observation> monthlyObservations, Observation yearlyObservation
});


@override $ObservationCopyWith<$Res> get yearlyObservation;

}
/// @nodoc
class __$YearSummaryCopyWithImpl<$Res>
    implements _$YearSummaryCopyWith<$Res> {
  __$YearSummaryCopyWithImpl(this._self, this._then);

  final _YearSummary _self;
  final $Res Function(_YearSummary) _then;

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? fiveMinuteObservations = null,Object? dailyObservations = null,Object? monthlyObservations = null,Object? yearlyObservation = null,}) {
  return _then(_YearSummary(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,fiveMinuteObservations: null == fiveMinuteObservations ? _self._fiveMinuteObservations : fiveMinuteObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyObservations: null == dailyObservations ? _self._dailyObservations : dailyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyObservations: null == monthlyObservations ? _self._monthlyObservations : monthlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,yearlyObservation: null == yearlyObservation ? _self.yearlyObservation : yearlyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}

/// Create a copy of YearSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get yearlyObservation {
  
  return $ObservationCopyWith<$Res>(_self.yearlyObservation, (value) {
    return _then(_self.copyWith(yearlyObservation: value));
  });
}
}

// dart format on
