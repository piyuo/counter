// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ObservationPayload {

/// Aggregation interval represented by this observation.
///
/// Determines which of [hour] and [minute] are used (see the table on
/// [year]).
 String get granularity;/// Identifies the date represented by this observation.
///
/// Business (local wall-clock) date. See "Time basis and DST" at the top
/// of this file.
///
/// Components that do not apply to the [granularity] are -1:
///
/// - minutes5: year=2026, month=06, day=24, hour=23, minute=05
/// - hour:     year=2026, month=06, day=24, hour=23, minute=-1
/// - day:      year=2026, month=06, day=24, hour=-1, minute=-1
/// - month:    year=2026, month=06, day=-1, hour=-1, minute=-1
/// - year:     year=2026, month=-1, day=-1, hour=-1, minute=-1
 int get year; int get month; int get day; int get hour; int get minute; int get id;/// String form of the business date. The format depends on [granularity]:
///
/// - minutes5, hour, day: `2026-08-26`
/// - month: `2026-08`
/// - year: `2026`
 String get businessDate;/// Whether the business-local date falls on Saturday or Sunday.
 bool get isWeekend;/// Mean confidence as a ratio in the range 0.0-1.0, or 0 when there are
/// no samples.
///
/// confidenceRatio = confidenceRatioSum / confidenceSampleCount
///
/// The sum and count remain the source of truth; this field is included
/// for convenience.
@RoundedDouble() double get confidenceRatio;/// Expected duration, in seconds, of this observation's period.
///
/// For example, a 5-minute window has 300 expected seconds.
///
/// Additive across child observations.
 int get expectedSeconds;/// Number of seconds with valid detection data in this observation.
///
/// For example, a 5-minute window has a maximum of 300 covered seconds,
/// minus any time when detection data was missing.
///
/// Additive across child observations.
/// Slots with few contributors look as strong as well-sampled ones.
/// A slot present in 1 of 30 days is averaged over that one day, with no signal that it’s thin.
/// You could weight by coveredSeconds to know how well-sampled a slot is.
 int get coveredSeconds;/// Fraction of the observation period that contained valid detection
/// data, in the range 0.0-1.0, or 0 when [expectedSeconds] is 0.
///
/// coverageRatio = coveredSeconds / expectedSeconds
///
/// For aggregated observations, sum the seconds first, then divide.
/// Do not average the ratios of child observations. The seconds remain
/// the source of truth; this field is included for convenience.
@RoundedDouble() double get coverageRatio;/// Per-area analytics.
///
/// One entry exists for each configured interest area, including the
/// global area.
 List<ActivityPayload> get areas;/// Total number of frames processed during this observation.
///
/// Additive across child observations.
 int get frameCount;
/// Create a copy of ObservationPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationPayloadCopyWith<ObservationPayload> get copyWith => _$ObservationPayloadCopyWithImpl<ObservationPayload>(this as ObservationPayload, _$identity);

  /// Serializes this ObservationPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ObservationPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationPayload&&(identical(other.granularity, _this.granularity) || other.granularity == _this.granularity)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.businessDate, _this.businessDate) || other.businessDate == _this.businessDate)&&(identical(other.isWeekend, _this.isWeekend) || other.isWeekend == _this.isWeekend)&&(identical(other.confidenceRatio, _this.confidenceRatio) || other.confidenceRatio == _this.confidenceRatio)&&(identical(other.expectedSeconds, _this.expectedSeconds) || other.expectedSeconds == _this.expectedSeconds)&&(identical(other.coveredSeconds, _this.coveredSeconds) || other.coveredSeconds == _this.coveredSeconds)&&(identical(other.coverageRatio, _this.coverageRatio) || other.coverageRatio == _this.coverageRatio)&&const DeepCollectionEquality().equals(other.areas, _this.areas)&&(identical(other.frameCount, _this.frameCount) || other.frameCount == _this.frameCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ObservationPayload;
  return Object.hash(runtimeType,_this.granularity,_this.year,_this.month,_this.day,_this.hour,_this.minute,_this.id,_this.businessDate,_this.isWeekend,_this.confidenceRatio,_this.expectedSeconds,_this.coveredSeconds,_this.coverageRatio,const DeepCollectionEquality().hash(_this.areas),_this.frameCount);
}

@override
String toString() {
  final _this = this as ObservationPayload;
  return 'ObservationPayload(granularity: ${_this.granularity}, year: ${_this.year}, month: ${_this.month}, day: ${_this.day}, hour: ${_this.hour}, minute: ${_this.minute}, id: ${_this.id}, businessDate: ${_this.businessDate}, isWeekend: ${_this.isWeekend}, confidenceRatio: ${_this.confidenceRatio}, expectedSeconds: ${_this.expectedSeconds}, coveredSeconds: ${_this.coveredSeconds}, coverageRatio: ${_this.coverageRatio}, areas: ${_this.areas}, frameCount: ${_this.frameCount})';
}


}

/// @nodoc
abstract mixin class $ObservationPayloadCopyWith<$Res>  {
  factory $ObservationPayloadCopyWith(ObservationPayload value, $Res Function(ObservationPayload) _then) = _$ObservationPayloadCopyWithImpl;
@useResult
$Res call({
 String granularity, int year, int month, int day, int hour, int minute, int id, String businessDate, bool isWeekend,@RoundedDouble() double confidenceRatio, int expectedSeconds, int coveredSeconds,@RoundedDouble() double coverageRatio, List<ActivityPayload> areas, int frameCount
});




}
/// @nodoc
class _$ObservationPayloadCopyWithImpl<$Res>
    implements $ObservationPayloadCopyWith<$Res> {
  _$ObservationPayloadCopyWithImpl(this._self, this._then);

  final ObservationPayload _self;
  final $Res Function(ObservationPayload) _then;

/// Create a copy of ObservationPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? granularity = null,Object? year = null,Object? month = null,Object? day = null,Object? hour = null,Object? minute = null,Object? id = null,Object? businessDate = null,Object? isWeekend = null,Object? confidenceRatio = null,Object? expectedSeconds = null,Object? coveredSeconds = null,Object? coverageRatio = null,Object? areas = null,Object? frameCount = null,}) {
  return _then(ObservationPayload(
granularity: null == granularity ? _self.granularity : granularity // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,businessDate: null == businessDate ? _self.businessDate : businessDate // ignore: cast_nullable_to_non_nullable
as String,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,confidenceRatio: null == confidenceRatio ? _self.confidenceRatio : confidenceRatio // ignore: cast_nullable_to_non_nullable
as double,expectedSeconds: null == expectedSeconds ? _self.expectedSeconds : expectedSeconds // ignore: cast_nullable_to_non_nullable
as int,coveredSeconds: null == coveredSeconds ? _self.coveredSeconds : coveredSeconds // ignore: cast_nullable_to_non_nullable
as int,coverageRatio: null == coverageRatio ? _self.coverageRatio : coverageRatio // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<ActivityPayload>,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ObservationPayload].
extension ObservationPayloadPatterns on ObservationPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObservationPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObservationPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObservationPayload value)  $default,){
final _that = this;
switch (_that) {
case _ObservationPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObservationPayload value)?  $default,){
final _that = this;
switch (_that) {
case _ObservationPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String granularity,  int year,  int month,  int day,  int hour,  int minute,  int id,  String businessDate,  bool isWeekend, @RoundedDouble()  double confidenceRatio,  int expectedSeconds,  int coveredSeconds, @RoundedDouble()  double coverageRatio,  List<ActivityPayload> areas,  int frameCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationPayload() when $default != null:
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.id,_that.businessDate,_that.isWeekend,_that.confidenceRatio,_that.expectedSeconds,_that.coveredSeconds,_that.coverageRatio,_that.areas,_that.frameCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String granularity,  int year,  int month,  int day,  int hour,  int minute,  int id,  String businessDate,  bool isWeekend, @RoundedDouble()  double confidenceRatio,  int expectedSeconds,  int coveredSeconds, @RoundedDouble()  double coverageRatio,  List<ActivityPayload> areas,  int frameCount)  $default,) {final _that = this;
switch (_that) {
case _ObservationPayload():
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.id,_that.businessDate,_that.isWeekend,_that.confidenceRatio,_that.expectedSeconds,_that.coveredSeconds,_that.coverageRatio,_that.areas,_that.frameCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String granularity,  int year,  int month,  int day,  int hour,  int minute,  int id,  String businessDate,  bool isWeekend, @RoundedDouble()  double confidenceRatio,  int expectedSeconds,  int coveredSeconds, @RoundedDouble()  double coverageRatio,  List<ActivityPayload> areas,  int frameCount)?  $default,) {final _that = this;
switch (_that) {
case _ObservationPayload() when $default != null:
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.id,_that.businessDate,_that.isWeekend,_that.confidenceRatio,_that.expectedSeconds,_that.coveredSeconds,_that.coverageRatio,_that.areas,_that.frameCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ObservationPayload extends ObservationPayload {
  const _ObservationPayload({this.granularity = '', required this.year, required this.month, required this.day, required this.hour, required this.minute, required this.id, this.businessDate = '', this.isWeekend = false, @RoundedDouble() this.confidenceRatio = 0, this.expectedSeconds = 0, this.coveredSeconds = 0, @RoundedDouble() this.coverageRatio = 0, required  List<ActivityPayload> areas, required this.frameCount}): _areas = areas,super._();
  factory _ObservationPayload.fromJson(Map<String, dynamic> json) => _$ObservationPayloadFromJson(json);

/// Aggregation interval represented by this observation.
///
/// Determines which of [hour] and [minute] are used (see the table on
/// [year]).
@override@JsonKey() final  String granularity;
/// Identifies the date represented by this observation.
///
/// Business (local wall-clock) date. See "Time basis and DST" at the top
/// of this file.
///
/// Components that do not apply to the [granularity] are -1:
///
/// - minutes5: year=2026, month=06, day=24, hour=23, minute=05
/// - hour:     year=2026, month=06, day=24, hour=23, minute=-1
/// - day:      year=2026, month=06, day=24, hour=-1, minute=-1
/// - month:    year=2026, month=06, day=-1, hour=-1, minute=-1
/// - year:     year=2026, month=-1, day=-1, hour=-1, minute=-1
@override final  int year;
@override final  int month;
@override final  int day;
@override final  int hour;
@override final  int minute;
@override final  int id;
/// String form of the business date. The format depends on [granularity]:
///
/// - minutes5, hour, day: `2026-08-26`
/// - month: `2026-08`
/// - year: `2026`
@override@JsonKey() final  String businessDate;
/// Whether the business-local date falls on Saturday or Sunday.
@override@JsonKey() final  bool isWeekend;
/// Mean confidence as a ratio in the range 0.0-1.0, or 0 when there are
/// no samples.
///
/// confidenceRatio = confidenceRatioSum / confidenceSampleCount
///
/// The sum and count remain the source of truth; this field is included
/// for convenience.
@override@JsonKey()@RoundedDouble() final  double confidenceRatio;
/// Expected duration, in seconds, of this observation's period.
///
/// For example, a 5-minute window has 300 expected seconds.
///
/// Additive across child observations.
@override@JsonKey() final  int expectedSeconds;
/// Number of seconds with valid detection data in this observation.
///
/// For example, a 5-minute window has a maximum of 300 covered seconds,
/// minus any time when detection data was missing.
///
/// Additive across child observations.
/// Slots with few contributors look as strong as well-sampled ones.
/// A slot present in 1 of 30 days is averaged over that one day, with no signal that it’s thin.
/// You could weight by coveredSeconds to know how well-sampled a slot is.
@override@JsonKey() final  int coveredSeconds;
/// Fraction of the observation period that contained valid detection
/// data, in the range 0.0-1.0, or 0 when [expectedSeconds] is 0.
///
/// coverageRatio = coveredSeconds / expectedSeconds
///
/// For aggregated observations, sum the seconds first, then divide.
/// Do not average the ratios of child observations. The seconds remain
/// the source of truth; this field is included for convenience.
@override@JsonKey()@RoundedDouble() final  double coverageRatio;
/// Per-area analytics.
///
/// One entry exists for each configured interest area, including the
/// global area.
 final  List<ActivityPayload> _areas;
/// Per-area analytics.
///
/// One entry exists for each configured interest area, including the
/// global area.
@override List<ActivityPayload> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

/// Total number of frames processed during this observation.
///
/// Additive across child observations.
@override final  int frameCount;

/// Create a copy of ObservationPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationPayloadCopyWith<_ObservationPayload> get copyWith => __$ObservationPayloadCopyWithImpl<_ObservationPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservationPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationPayload&&(identical(other.granularity, granularity) || other.granularity == granularity)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.id, id) || other.id == id)&&(identical(other.businessDate, businessDate) || other.businessDate == businessDate)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&(identical(other.confidenceRatio, confidenceRatio) || other.confidenceRatio == confidenceRatio)&&(identical(other.expectedSeconds, expectedSeconds) || other.expectedSeconds == expectedSeconds)&&(identical(other.coveredSeconds, coveredSeconds) || other.coveredSeconds == coveredSeconds)&&(identical(other.coverageRatio, coverageRatio) || other.coverageRatio == coverageRatio)&&const DeepCollectionEquality().equals(other.areas, _areas)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,granularity,year,month,day,hour,minute,id,businessDate,isWeekend,confidenceRatio,expectedSeconds,coveredSeconds,coverageRatio,const DeepCollectionEquality().hash(_areas),frameCount);
}

@override
String toString() {
    return 'ObservationPayload(granularity: $granularity, year: $year, month: $month, day: $day, hour: $hour, minute: $minute, id: $id, businessDate: $businessDate, isWeekend: $isWeekend, confidenceRatio: $confidenceRatio, expectedSeconds: $expectedSeconds, coveredSeconds: $coveredSeconds, coverageRatio: $coverageRatio, areas: $areas, frameCount: $frameCount)';
}


}

/// @nodoc
abstract mixin class _$ObservationPayloadCopyWith<$Res> implements $ObservationPayloadCopyWith<$Res> {
  factory _$ObservationPayloadCopyWith(_ObservationPayload value, $Res Function(_ObservationPayload) _then) = __$ObservationPayloadCopyWithImpl;
@override @useResult
$Res call({
 String granularity, int year, int month, int day, int hour, int minute, int id, String businessDate, bool isWeekend,@RoundedDouble() double confidenceRatio, int expectedSeconds, int coveredSeconds,@RoundedDouble() double coverageRatio, List<ActivityPayload> areas, int frameCount
});




}
/// @nodoc
class __$ObservationPayloadCopyWithImpl<$Res>
    implements _$ObservationPayloadCopyWith<$Res> {
  __$ObservationPayloadCopyWithImpl(this._self, this._then);

  final _ObservationPayload _self;
  final $Res Function(_ObservationPayload) _then;

/// Create a copy of ObservationPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? granularity = null,Object? year = null,Object? month = null,Object? day = null,Object? hour = null,Object? minute = null,Object? id = null,Object? businessDate = null,Object? isWeekend = null,Object? confidenceRatio = null,Object? expectedSeconds = null,Object? coveredSeconds = null,Object? coverageRatio = null,Object? areas = null,Object? frameCount = null,}) {
  return _then(_ObservationPayload(
granularity: null == granularity ? _self.granularity : granularity // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,businessDate: null == businessDate ? _self.businessDate : businessDate // ignore: cast_nullable_to_non_nullable
as String,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,confidenceRatio: null == confidenceRatio ? _self.confidenceRatio : confidenceRatio // ignore: cast_nullable_to_non_nullable
as double,expectedSeconds: null == expectedSeconds ? _self.expectedSeconds : expectedSeconds // ignore: cast_nullable_to_non_nullable
as int,coveredSeconds: null == coveredSeconds ? _self.coveredSeconds : coveredSeconds // ignore: cast_nullable_to_non_nullable
as int,coverageRatio: null == coverageRatio ? _self.coverageRatio : coverageRatio // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<ActivityPayload>,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
