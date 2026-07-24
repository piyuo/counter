// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelemetryPayload {

/// Identifier of the counting session this observation window belongs to.
 String get session;/// Sequential number of this observation window within the session.
///
/// Starts at 1.
 int get sequence;/// Beginning of the observation window in UTC.
///
/// This is the canonical timestamp used for synchronization,
/// upload ordering, and auditing.
 DateTime get startUtc;/// Beginning of the same observation window expressed using the
/// site's business clock.
///
/// This timestamp is used for reports, grouping by business day,
/// and business-hour analysis.
 DateTime get startBusiness;/// businessDate MUST equal the date portion of [startBusiness].
///
/// It is stored separately because it is queried frequently and because
/// payloads for the same business day are typically grouped into a single file.
///
/// Example:
/// 2026-06-24
 String get businessDate;/// Total number of frames processed in this window.
 int get frameCount;/// Exact total duration of missing input within this window (seconds).
 int get missingSec;/// Mean confidence (%) across all tracked-object samples in this window.
@RoundedDouble2() double get confidence;/// True when the observation window was interrupted before completion.
 bool get isPartial;/// Fraction of the window that contained valid detection data (0.0–1.0).
@RoundedDouble2() double get coverage;/// Average processed frames per second over covered (non-missing) time.
@RoundedDouble2() double get fps;/// Per-area analytics.  One entry per configured interest area.
 List<AreaPayload> get areas;
/// Create a copy of TelemetryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryPayloadCopyWith<TelemetryPayload> get copyWith => _$TelemetryPayloadCopyWithImpl<TelemetryPayload>(this as TelemetryPayload, _$identity);

  /// Serializes this TelemetryPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryPayload&&(identical(other.session, session) || other.session == session)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.startBusiness, startBusiness) || other.startBusiness == startBusiness)&&(identical(other.businessDate, businessDate) || other.businessDate == businessDate)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.missingSec, missingSec) || other.missingSec == missingSec)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.coverage, coverage) || other.coverage == coverage)&&(identical(other.fps, fps) || other.fps == fps)&&const DeepCollectionEquality().equals(other.areas, areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,sequence,startUtc,startBusiness,businessDate,frameCount,missingSec,confidence,isPartial,coverage,fps,const DeepCollectionEquality().hash(areas));

@override
String toString() {
  return 'TelemetryPayload(session: $session, sequence: $sequence, startUtc: $startUtc, startBusiness: $startBusiness, businessDate: $businessDate, frameCount: $frameCount, missingSec: $missingSec, confidence: $confidence, isPartial: $isPartial, coverage: $coverage, fps: $fps, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $TelemetryPayloadCopyWith<$Res>  {
  factory $TelemetryPayloadCopyWith(TelemetryPayload value, $Res Function(TelemetryPayload) _then) = _$TelemetryPayloadCopyWithImpl;
@useResult
$Res call({
 String session, int sequence, DateTime startUtc, DateTime startBusiness, String businessDate, int frameCount, int missingSec,@RoundedDouble2() double confidence, bool isPartial,@RoundedDouble2() double coverage,@RoundedDouble2() double fps, List<AreaPayload> areas
});




}
/// @nodoc
class _$TelemetryPayloadCopyWithImpl<$Res>
    implements $TelemetryPayloadCopyWith<$Res> {
  _$TelemetryPayloadCopyWithImpl(this._self, this._then);

  final TelemetryPayload _self;
  final $Res Function(TelemetryPayload) _then;

/// Create a copy of TelemetryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? sequence = null,Object? startUtc = null,Object? startBusiness = null,Object? businessDate = null,Object? frameCount = null,Object? missingSec = null,Object? confidence = null,Object? isPartial = null,Object? coverage = null,Object? fps = null,Object? areas = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as String,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,startBusiness: null == startBusiness ? _self.startBusiness : startBusiness // ignore: cast_nullable_to_non_nullable
as DateTime,businessDate: null == businessDate ? _self.businessDate : businessDate // ignore: cast_nullable_to_non_nullable
as String,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,missingSec: null == missingSec ? _self.missingSec : missingSec // ignore: cast_nullable_to_non_nullable
as int,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,isPartial: null == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool,coverage: null == coverage ? _self.coverage : coverage // ignore: cast_nullable_to_non_nullable
as double,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPayload>,
  ));
}

}


/// Adds pattern-matching-related methods to [TelemetryPayload].
extension TelemetryPayloadPatterns on TelemetryPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetryPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetryPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetryPayload value)  $default,){
final _that = this;
switch (_that) {
case _TelemetryPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetryPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetryPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String session,  int sequence,  DateTime startUtc,  DateTime startBusiness,  String businessDate,  int frameCount,  int missingSec, @RoundedDouble2()  double confidence,  bool isPartial, @RoundedDouble2()  double coverage, @RoundedDouble2()  double fps,  List<AreaPayload> areas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryPayload() when $default != null:
return $default(_that.session,_that.sequence,_that.startUtc,_that.startBusiness,_that.businessDate,_that.frameCount,_that.missingSec,_that.confidence,_that.isPartial,_that.coverage,_that.fps,_that.areas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String session,  int sequence,  DateTime startUtc,  DateTime startBusiness,  String businessDate,  int frameCount,  int missingSec, @RoundedDouble2()  double confidence,  bool isPartial, @RoundedDouble2()  double coverage, @RoundedDouble2()  double fps,  List<AreaPayload> areas)  $default,) {final _that = this;
switch (_that) {
case _TelemetryPayload():
return $default(_that.session,_that.sequence,_that.startUtc,_that.startBusiness,_that.businessDate,_that.frameCount,_that.missingSec,_that.confidence,_that.isPartial,_that.coverage,_that.fps,_that.areas);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String session,  int sequence,  DateTime startUtc,  DateTime startBusiness,  String businessDate,  int frameCount,  int missingSec, @RoundedDouble2()  double confidence,  bool isPartial, @RoundedDouble2()  double coverage, @RoundedDouble2()  double fps,  List<AreaPayload> areas)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryPayload() when $default != null:
return $default(_that.session,_that.sequence,_that.startUtc,_that.startBusiness,_that.businessDate,_that.frameCount,_that.missingSec,_that.confidence,_that.isPartial,_that.coverage,_that.fps,_that.areas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelemetryPayload implements TelemetryPayload {
  const _TelemetryPayload({required this.session, required this.sequence, required this.startUtc, required this.startBusiness, required this.businessDate, required this.frameCount, required this.missingSec, @RoundedDouble2() required this.confidence, required this.isPartial, @RoundedDouble2() required this.coverage, @RoundedDouble2() required this.fps, required final  List<AreaPayload> areas}): _areas = areas;
  factory _TelemetryPayload.fromJson(Map<String, dynamic> json) => _$TelemetryPayloadFromJson(json);

/// Identifier of the counting session this observation window belongs to.
@override final  String session;
/// Sequential number of this observation window within the session.
///
/// Starts at 1.
@override final  int sequence;
/// Beginning of the observation window in UTC.
///
/// This is the canonical timestamp used for synchronization,
/// upload ordering, and auditing.
@override final  DateTime startUtc;
/// Beginning of the same observation window expressed using the
/// site's business clock.
///
/// This timestamp is used for reports, grouping by business day,
/// and business-hour analysis.
@override final  DateTime startBusiness;
/// businessDate MUST equal the date portion of [startBusiness].
///
/// It is stored separately because it is queried frequently and because
/// payloads for the same business day are typically grouped into a single file.
///
/// Example:
/// 2026-06-24
@override final  String businessDate;
/// Total number of frames processed in this window.
@override final  int frameCount;
/// Exact total duration of missing input within this window (seconds).
@override final  int missingSec;
/// Mean confidence (%) across all tracked-object samples in this window.
@override@RoundedDouble2() final  double confidence;
/// True when the observation window was interrupted before completion.
@override final  bool isPartial;
/// Fraction of the window that contained valid detection data (0.0–1.0).
@override@RoundedDouble2() final  double coverage;
/// Average processed frames per second over covered (non-missing) time.
@override@RoundedDouble2() final  double fps;
/// Per-area analytics.  One entry per configured interest area.
 final  List<AreaPayload> _areas;
/// Per-area analytics.  One entry per configured interest area.
@override List<AreaPayload> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


/// Create a copy of TelemetryPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryPayloadCopyWith<_TelemetryPayload> get copyWith => __$TelemetryPayloadCopyWithImpl<_TelemetryPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelemetryPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryPayload&&(identical(other.session, session) || other.session == session)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.startBusiness, startBusiness) || other.startBusiness == startBusiness)&&(identical(other.businessDate, businessDate) || other.businessDate == businessDate)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.missingSec, missingSec) || other.missingSec == missingSec)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.coverage, coverage) || other.coverage == coverage)&&(identical(other.fps, fps) || other.fps == fps)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,sequence,startUtc,startBusiness,businessDate,frameCount,missingSec,confidence,isPartial,coverage,fps,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'TelemetryPayload(session: $session, sequence: $sequence, startUtc: $startUtc, startBusiness: $startBusiness, businessDate: $businessDate, frameCount: $frameCount, missingSec: $missingSec, confidence: $confidence, isPartial: $isPartial, coverage: $coverage, fps: $fps, areas: $areas)';
}


}

/// @nodoc
abstract mixin class _$TelemetryPayloadCopyWith<$Res> implements $TelemetryPayloadCopyWith<$Res> {
  factory _$TelemetryPayloadCopyWith(_TelemetryPayload value, $Res Function(_TelemetryPayload) _then) = __$TelemetryPayloadCopyWithImpl;
@override @useResult
$Res call({
 String session, int sequence, DateTime startUtc, DateTime startBusiness, String businessDate, int frameCount, int missingSec,@RoundedDouble2() double confidence, bool isPartial,@RoundedDouble2() double coverage,@RoundedDouble2() double fps, List<AreaPayload> areas
});




}
/// @nodoc
class __$TelemetryPayloadCopyWithImpl<$Res>
    implements _$TelemetryPayloadCopyWith<$Res> {
  __$TelemetryPayloadCopyWithImpl(this._self, this._then);

  final _TelemetryPayload _self;
  final $Res Function(_TelemetryPayload) _then;

/// Create a copy of TelemetryPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? sequence = null,Object? startUtc = null,Object? startBusiness = null,Object? businessDate = null,Object? frameCount = null,Object? missingSec = null,Object? confidence = null,Object? isPartial = null,Object? coverage = null,Object? fps = null,Object? areas = null,}) {
  return _then(_TelemetryPayload(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as String,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,startBusiness: null == startBusiness ? _self.startBusiness : startBusiness // ignore: cast_nullable_to_non_nullable
as DateTime,businessDate: null == businessDate ? _self.businessDate : businessDate // ignore: cast_nullable_to_non_nullable
as String,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,missingSec: null == missingSec ? _self.missingSec : missingSec // ignore: cast_nullable_to_non_nullable
as int,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,isPartial: null == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool,coverage: null == coverage ? _self.coverage : coverage // ignore: cast_nullable_to_non_nullable
as double,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPayload>,
  ));
}


}


/// @nodoc
mixin _$AreaPayload {

/// Index matching the configured interest-area ID.
 int get areaId;/// Name of the configured interest area.
 String get areaName;/// Objects detected moving past the area without entering it.
 int get passBy;/// Objects that stayed within the area.
 int get stay;/// Objects that crossed the threshold into the area.
 int get entry;/// Objects that crossed the threshold out of the area.
 int get exit;/// Objects that appeared in the area.
 int get appear;/// Objects that disappeared from the area.
 int get disappear;/// Mean occupancy across discrete frame samples in this window.
///
/// This is a simple arithmetic mean (sum of sampled occupancies / number of
/// samples), with no time-weighting.
@RoundedDouble2() double get avgOccupancy;/// Max occupancy observed at any sample in the window.
 int get maxOccupancy;/// Mean dwell time in seconds across all dwell observations.
@RoundedDouble2() double get avgDwellSec;/// Maximum observed dwell time in rounded seconds.
 double get maxDwellSec;
/// Create a copy of AreaPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaPayloadCopyWith<AreaPayload> get copyWith => _$AreaPayloadCopyWithImpl<AreaPayload>(this as AreaPayload, _$identity);

  /// Serializes this AreaPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaPayload&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.avgOccupancy, avgOccupancy) || other.avgOccupancy == avgOccupancy)&&(identical(other.maxOccupancy, maxOccupancy) || other.maxOccupancy == maxOccupancy)&&(identical(other.avgDwellSec, avgDwellSec) || other.avgDwellSec == avgDwellSec)&&(identical(other.maxDwellSec, maxDwellSec) || other.maxDwellSec == maxDwellSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,areaId,areaName,passBy,stay,entry,exit,appear,disappear,avgOccupancy,maxOccupancy,avgDwellSec,maxDwellSec);

@override
String toString() {
  return 'AreaPayload(areaId: $areaId, areaName: $areaName, passBy: $passBy, stay: $stay, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, avgOccupancy: $avgOccupancy, maxOccupancy: $maxOccupancy, avgDwellSec: $avgDwellSec, maxDwellSec: $maxDwellSec)';
}


}

/// @nodoc
abstract mixin class $AreaPayloadCopyWith<$Res>  {
  factory $AreaPayloadCopyWith(AreaPayload value, $Res Function(AreaPayload) _then) = _$AreaPayloadCopyWithImpl;
@useResult
$Res call({
 int areaId, String areaName, int passBy, int stay, int entry, int exit, int appear, int disappear,@RoundedDouble2() double avgOccupancy, int maxOccupancy,@RoundedDouble2() double avgDwellSec, double maxDwellSec
});




}
/// @nodoc
class _$AreaPayloadCopyWithImpl<$Res>
    implements $AreaPayloadCopyWith<$Res> {
  _$AreaPayloadCopyWithImpl(this._self, this._then);

  final AreaPayload _self;
  final $Res Function(AreaPayload) _then;

/// Create a copy of AreaPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stay = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? avgOccupancy = null,Object? maxOccupancy = null,Object? avgDwellSec = null,Object? maxDwellSec = null,}) {
  return _then(_self.copyWith(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stay: null == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,avgOccupancy: null == avgOccupancy ? _self.avgOccupancy : avgOccupancy // ignore: cast_nullable_to_non_nullable
as double,maxOccupancy: null == maxOccupancy ? _self.maxOccupancy : maxOccupancy // ignore: cast_nullable_to_non_nullable
as int,avgDwellSec: null == avgDwellSec ? _self.avgDwellSec : avgDwellSec // ignore: cast_nullable_to_non_nullable
as double,maxDwellSec: null == maxDwellSec ? _self.maxDwellSec : maxDwellSec // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AreaPayload].
extension AreaPayloadPatterns on AreaPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AreaPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AreaPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AreaPayload value)  $default,){
final _that = this;
switch (_that) {
case _AreaPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AreaPayload value)?  $default,){
final _that = this;
switch (_that) {
case _AreaPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int areaId,  String areaName,  int passBy,  int stay,  int entry,  int exit,  int appear,  int disappear, @RoundedDouble2()  double avgOccupancy,  int maxOccupancy, @RoundedDouble2()  double avgDwellSec,  double maxDwellSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaPayload() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stay,_that.entry,_that.exit,_that.appear,_that.disappear,_that.avgOccupancy,_that.maxOccupancy,_that.avgDwellSec,_that.maxDwellSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int areaId,  String areaName,  int passBy,  int stay,  int entry,  int exit,  int appear,  int disappear, @RoundedDouble2()  double avgOccupancy,  int maxOccupancy, @RoundedDouble2()  double avgDwellSec,  double maxDwellSec)  $default,) {final _that = this;
switch (_that) {
case _AreaPayload():
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stay,_that.entry,_that.exit,_that.appear,_that.disappear,_that.avgOccupancy,_that.maxOccupancy,_that.avgDwellSec,_that.maxDwellSec);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int areaId,  String areaName,  int passBy,  int stay,  int entry,  int exit,  int appear,  int disappear, @RoundedDouble2()  double avgOccupancy,  int maxOccupancy, @RoundedDouble2()  double avgDwellSec,  double maxDwellSec)?  $default,) {final _that = this;
switch (_that) {
case _AreaPayload() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stay,_that.entry,_that.exit,_that.appear,_that.disappear,_that.avgOccupancy,_that.maxOccupancy,_that.avgDwellSec,_that.maxDwellSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreaPayload implements AreaPayload {
  const _AreaPayload({this.areaId = 0, this.areaName = '', this.passBy = 0, this.stay = 0, this.entry = 0, this.exit = 0, this.appear = 0, this.disappear = 0, @RoundedDouble2() this.avgOccupancy = 0, this.maxOccupancy = 0, @RoundedDouble2() this.avgDwellSec = 0, this.maxDwellSec = 0});
  factory _AreaPayload.fromJson(Map<String, dynamic> json) => _$AreaPayloadFromJson(json);

/// Index matching the configured interest-area ID.
@override@JsonKey() final  int areaId;
/// Name of the configured interest area.
@override@JsonKey() final  String areaName;
/// Objects detected moving past the area without entering it.
@override@JsonKey() final  int passBy;
/// Objects that stayed within the area.
@override@JsonKey() final  int stay;
/// Objects that crossed the threshold into the area.
@override@JsonKey() final  int entry;
/// Objects that crossed the threshold out of the area.
@override@JsonKey() final  int exit;
/// Objects that appeared in the area.
@override@JsonKey() final  int appear;
/// Objects that disappeared from the area.
@override@JsonKey() final  int disappear;
/// Mean occupancy across discrete frame samples in this window.
///
/// This is a simple arithmetic mean (sum of sampled occupancies / number of
/// samples), with no time-weighting.
@override@JsonKey()@RoundedDouble2() final  double avgOccupancy;
/// Max occupancy observed at any sample in the window.
@override@JsonKey() final  int maxOccupancy;
/// Mean dwell time in seconds across all dwell observations.
@override@JsonKey()@RoundedDouble2() final  double avgDwellSec;
/// Maximum observed dwell time in rounded seconds.
@override@JsonKey() final  double maxDwellSec;

/// Create a copy of AreaPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaPayloadCopyWith<_AreaPayload> get copyWith => __$AreaPayloadCopyWithImpl<_AreaPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaPayload&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.avgOccupancy, avgOccupancy) || other.avgOccupancy == avgOccupancy)&&(identical(other.maxOccupancy, maxOccupancy) || other.maxOccupancy == maxOccupancy)&&(identical(other.avgDwellSec, avgDwellSec) || other.avgDwellSec == avgDwellSec)&&(identical(other.maxDwellSec, maxDwellSec) || other.maxDwellSec == maxDwellSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,areaId,areaName,passBy,stay,entry,exit,appear,disappear,avgOccupancy,maxOccupancy,avgDwellSec,maxDwellSec);

@override
String toString() {
  return 'AreaPayload(areaId: $areaId, areaName: $areaName, passBy: $passBy, stay: $stay, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, avgOccupancy: $avgOccupancy, maxOccupancy: $maxOccupancy, avgDwellSec: $avgDwellSec, maxDwellSec: $maxDwellSec)';
}


}

/// @nodoc
abstract mixin class _$AreaPayloadCopyWith<$Res> implements $AreaPayloadCopyWith<$Res> {
  factory _$AreaPayloadCopyWith(_AreaPayload value, $Res Function(_AreaPayload) _then) = __$AreaPayloadCopyWithImpl;
@override @useResult
$Res call({
 int areaId, String areaName, int passBy, int stay, int entry, int exit, int appear, int disappear,@RoundedDouble2() double avgOccupancy, int maxOccupancy,@RoundedDouble2() double avgDwellSec, double maxDwellSec
});




}
/// @nodoc
class __$AreaPayloadCopyWithImpl<$Res>
    implements _$AreaPayloadCopyWith<$Res> {
  __$AreaPayloadCopyWithImpl(this._self, this._then);

  final _AreaPayload _self;
  final $Res Function(_AreaPayload) _then;

/// Create a copy of AreaPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stay = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? avgOccupancy = null,Object? maxOccupancy = null,Object? avgDwellSec = null,Object? maxDwellSec = null,}) {
  return _then(_AreaPayload(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stay: null == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,avgOccupancy: null == avgOccupancy ? _self.avgOccupancy : avgOccupancy // ignore: cast_nullable_to_non_nullable
as double,maxOccupancy: null == maxOccupancy ? _self.maxOccupancy : maxOccupancy // ignore: cast_nullable_to_non_nullable
as int,avgDwellSec: null == avgDwellSec ? _self.avgDwellSec : avgDwellSec // ignore: cast_nullable_to_non_nullable
as double,maxDwellSec: null == maxDwellSec ? _self.maxDwellSec : maxDwellSec // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
