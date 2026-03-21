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

/// UUID v4 — used by the server for idempotent de-duplication on retry.
 String get id;/// Window start time in UTC.
 DateTime get startUtc;/// Window end time in UTC.
 DateTime get endUtc;/// Identifier of the counting session this window belongs to.
 String get sessionId;/// 1-based index of this window within [sessionId].
 int get windowIndex;/// Total number of frames processed in this window.
 int get frameCount;/// Exact total duration of missing input within this window (milliseconds).
 int get missingDurationMs;/// Mean confidence (%) across all tracked-object samples in this window.
 double get confidence;/// True when the observation window was interrupted before completion.
 bool get isPartial;/// Fraction of the window that contained valid detection data (0.0–1.0).
 double get coverageRatio;/// Average processed frames per second over covered (non-missing) time.
 double get fps;/// Per-area analytics.  One entry per configured interest area.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.windowIndex, windowIndex) || other.windowIndex == windowIndex)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.missingDurationMs, missingDurationMs) || other.missingDurationMs == missingDurationMs)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.coverageRatio, coverageRatio) || other.coverageRatio == coverageRatio)&&(identical(other.fps, fps) || other.fps == fps)&&const DeepCollectionEquality().equals(other.areas, areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startUtc,endUtc,sessionId,windowIndex,frameCount,missingDurationMs,confidence,isPartial,coverageRatio,fps,const DeepCollectionEquality().hash(areas));

@override
String toString() {
  return 'TelemetryPayload(id: $id, startUtc: $startUtc, endUtc: $endUtc, sessionId: $sessionId, windowIndex: $windowIndex, frameCount: $frameCount, missingDurationMs: $missingDurationMs, confidence: $confidence, isPartial: $isPartial, coverageRatio: $coverageRatio, fps: $fps, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $TelemetryPayloadCopyWith<$Res>  {
  factory $TelemetryPayloadCopyWith(TelemetryPayload value, $Res Function(TelemetryPayload) _then) = _$TelemetryPayloadCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startUtc, DateTime endUtc, String sessionId, int windowIndex, int frameCount, int missingDurationMs, double confidence, bool isPartial, double coverageRatio, double fps, List<AreaPayload> areas
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startUtc = null,Object? endUtc = null,Object? sessionId = null,Object? windowIndex = null,Object? frameCount = null,Object? missingDurationMs = null,Object? confidence = null,Object? isPartial = null,Object? coverageRatio = null,Object? fps = null,Object? areas = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,windowIndex: null == windowIndex ? _self.windowIndex : windowIndex // ignore: cast_nullable_to_non_nullable
as int,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,missingDurationMs: null == missingDurationMs ? _self.missingDurationMs : missingDurationMs // ignore: cast_nullable_to_non_nullable
as int,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,isPartial: null == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool,coverageRatio: null == coverageRatio ? _self.coverageRatio : coverageRatio // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime startUtc,  DateTime endUtc,  String sessionId,  int windowIndex,  int frameCount,  int missingDurationMs,  double confidence,  bool isPartial,  double coverageRatio,  double fps,  List<AreaPayload> areas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryPayload() when $default != null:
return $default(_that.id,_that.startUtc,_that.endUtc,_that.sessionId,_that.windowIndex,_that.frameCount,_that.missingDurationMs,_that.confidence,_that.isPartial,_that.coverageRatio,_that.fps,_that.areas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime startUtc,  DateTime endUtc,  String sessionId,  int windowIndex,  int frameCount,  int missingDurationMs,  double confidence,  bool isPartial,  double coverageRatio,  double fps,  List<AreaPayload> areas)  $default,) {final _that = this;
switch (_that) {
case _TelemetryPayload():
return $default(_that.id,_that.startUtc,_that.endUtc,_that.sessionId,_that.windowIndex,_that.frameCount,_that.missingDurationMs,_that.confidence,_that.isPartial,_that.coverageRatio,_that.fps,_that.areas);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime startUtc,  DateTime endUtc,  String sessionId,  int windowIndex,  int frameCount,  int missingDurationMs,  double confidence,  bool isPartial,  double coverageRatio,  double fps,  List<AreaPayload> areas)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryPayload() when $default != null:
return $default(_that.id,_that.startUtc,_that.endUtc,_that.sessionId,_that.windowIndex,_that.frameCount,_that.missingDurationMs,_that.confidence,_that.isPartial,_that.coverageRatio,_that.fps,_that.areas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelemetryPayload implements TelemetryPayload {
  const _TelemetryPayload({required this.id, required this.startUtc, required this.endUtc, required this.sessionId, required this.windowIndex, required this.frameCount, required this.missingDurationMs, required this.confidence, required this.isPartial, required this.coverageRatio, required this.fps, required final  List<AreaPayload> areas}): _areas = areas;
  factory _TelemetryPayload.fromJson(Map<String, dynamic> json) => _$TelemetryPayloadFromJson(json);

/// UUID v4 — used by the server for idempotent de-duplication on retry.
@override final  String id;
/// Window start time in UTC.
@override final  DateTime startUtc;
/// Window end time in UTC.
@override final  DateTime endUtc;
/// Identifier of the counting session this window belongs to.
@override final  String sessionId;
/// 1-based index of this window within [sessionId].
@override final  int windowIndex;
/// Total number of frames processed in this window.
@override final  int frameCount;
/// Exact total duration of missing input within this window (milliseconds).
@override final  int missingDurationMs;
/// Mean confidence (%) across all tracked-object samples in this window.
@override final  double confidence;
/// True when the observation window was interrupted before completion.
@override final  bool isPartial;
/// Fraction of the window that contained valid detection data (0.0–1.0).
@override final  double coverageRatio;
/// Average processed frames per second over covered (non-missing) time.
@override final  double fps;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.windowIndex, windowIndex) || other.windowIndex == windowIndex)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.missingDurationMs, missingDurationMs) || other.missingDurationMs == missingDurationMs)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.coverageRatio, coverageRatio) || other.coverageRatio == coverageRatio)&&(identical(other.fps, fps) || other.fps == fps)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startUtc,endUtc,sessionId,windowIndex,frameCount,missingDurationMs,confidence,isPartial,coverageRatio,fps,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'TelemetryPayload(id: $id, startUtc: $startUtc, endUtc: $endUtc, sessionId: $sessionId, windowIndex: $windowIndex, frameCount: $frameCount, missingDurationMs: $missingDurationMs, confidence: $confidence, isPartial: $isPartial, coverageRatio: $coverageRatio, fps: $fps, areas: $areas)';
}


}

/// @nodoc
abstract mixin class _$TelemetryPayloadCopyWith<$Res> implements $TelemetryPayloadCopyWith<$Res> {
  factory _$TelemetryPayloadCopyWith(_TelemetryPayload value, $Res Function(_TelemetryPayload) _then) = __$TelemetryPayloadCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startUtc, DateTime endUtc, String sessionId, int windowIndex, int frameCount, int missingDurationMs, double confidence, bool isPartial, double coverageRatio, double fps, List<AreaPayload> areas
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startUtc = null,Object? endUtc = null,Object? sessionId = null,Object? windowIndex = null,Object? frameCount = null,Object? missingDurationMs = null,Object? confidence = null,Object? isPartial = null,Object? coverageRatio = null,Object? fps = null,Object? areas = null,}) {
  return _then(_TelemetryPayload(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,windowIndex: null == windowIndex ? _self.windowIndex : windowIndex // ignore: cast_nullable_to_non_nullable
as int,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,missingDurationMs: null == missingDurationMs ? _self.missingDurationMs : missingDurationMs // ignore: cast_nullable_to_non_nullable
as int,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,isPartial: null == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool,coverageRatio: null == coverageRatio ? _self.coverageRatio : coverageRatio // ignore: cast_nullable_to_non_nullable
as double,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPayload>,
  ));
}


}


/// @nodoc
mixin _$AreaPayload {

/// Index matching the configured interest-area ID.
 int get id;/// Objects detected moving past the area without entering it.
 int get passBy;/// Objects that stayed within the area.
 int get stay;/// Objects that crossed the threshold into the area.
 int get entry;/// Objects that crossed the threshold out of the area.
 int get exit;/// Objects that appeared in the area.
 int get appear;/// Objects that disappeared from the area.
 int get disappear;/// Mean occupancy across discrete frame samples in this window.
///
/// This is a simple arithmetic mean (sum of sampled occupancies / number of
/// samples), with no time-weighting.
 double get occupancyAvg;/// Peak occupancy observed at any sample in the window.
 int get occupancyPeak;/// Mean dwell time in seconds across all dwell observations.
 double get dwellAvgSec;/// Peak dwell time in rounded seconds.
 int get dwellPeakSec;
/// Create a copy of AreaPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaPayloadCopyWith<AreaPayload> get copyWith => _$AreaPayloadCopyWithImpl<AreaPayload>(this as AreaPayload, _$identity);

  /// Serializes this AreaPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.occupancyAvg, occupancyAvg) || other.occupancyAvg == occupancyAvg)&&(identical(other.occupancyPeak, occupancyPeak) || other.occupancyPeak == occupancyPeak)&&(identical(other.dwellAvgSec, dwellAvgSec) || other.dwellAvgSec == dwellAvgSec)&&(identical(other.dwellPeakSec, dwellPeakSec) || other.dwellPeakSec == dwellPeakSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,passBy,stay,entry,exit,appear,disappear,occupancyAvg,occupancyPeak,dwellAvgSec,dwellPeakSec);

@override
String toString() {
  return 'AreaPayload(id: $id, passBy: $passBy, stay: $stay, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, occupancyAvg: $occupancyAvg, occupancyPeak: $occupancyPeak, dwellAvgSec: $dwellAvgSec, dwellPeakSec: $dwellPeakSec)';
}


}

/// @nodoc
abstract mixin class $AreaPayloadCopyWith<$Res>  {
  factory $AreaPayloadCopyWith(AreaPayload value, $Res Function(AreaPayload) _then) = _$AreaPayloadCopyWithImpl;
@useResult
$Res call({
 int id, int passBy, int stay, int entry, int exit, int appear, int disappear, double occupancyAvg, int occupancyPeak, double dwellAvgSec, int dwellPeakSec
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? passBy = null,Object? stay = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancyAvg = null,Object? occupancyPeak = null,Object? dwellAvgSec = null,Object? dwellPeakSec = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stay: null == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,occupancyAvg: null == occupancyAvg ? _self.occupancyAvg : occupancyAvg // ignore: cast_nullable_to_non_nullable
as double,occupancyPeak: null == occupancyPeak ? _self.occupancyPeak : occupancyPeak // ignore: cast_nullable_to_non_nullable
as int,dwellAvgSec: null == dwellAvgSec ? _self.dwellAvgSec : dwellAvgSec // ignore: cast_nullable_to_non_nullable
as double,dwellPeakSec: null == dwellPeakSec ? _self.dwellPeakSec : dwellPeakSec // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int passBy,  int stay,  int entry,  int exit,  int appear,  int disappear,  double occupancyAvg,  int occupancyPeak,  double dwellAvgSec,  int dwellPeakSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaPayload() when $default != null:
return $default(_that.id,_that.passBy,_that.stay,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancyAvg,_that.occupancyPeak,_that.dwellAvgSec,_that.dwellPeakSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int passBy,  int stay,  int entry,  int exit,  int appear,  int disappear,  double occupancyAvg,  int occupancyPeak,  double dwellAvgSec,  int dwellPeakSec)  $default,) {final _that = this;
switch (_that) {
case _AreaPayload():
return $default(_that.id,_that.passBy,_that.stay,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancyAvg,_that.occupancyPeak,_that.dwellAvgSec,_that.dwellPeakSec);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int passBy,  int stay,  int entry,  int exit,  int appear,  int disappear,  double occupancyAvg,  int occupancyPeak,  double dwellAvgSec,  int dwellPeakSec)?  $default,) {final _that = this;
switch (_that) {
case _AreaPayload() when $default != null:
return $default(_that.id,_that.passBy,_that.stay,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancyAvg,_that.occupancyPeak,_that.dwellAvgSec,_that.dwellPeakSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreaPayload implements AreaPayload {
  const _AreaPayload({required this.id, this.passBy = 0, this.stay = 0, this.entry = 0, this.exit = 0, this.appear = 0, this.disappear = 0, this.occupancyAvg = 0, this.occupancyPeak = 0, this.dwellAvgSec = 0, this.dwellPeakSec = 0});
  factory _AreaPayload.fromJson(Map<String, dynamic> json) => _$AreaPayloadFromJson(json);

/// Index matching the configured interest-area ID.
@override final  int id;
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
@override@JsonKey() final  double occupancyAvg;
/// Peak occupancy observed at any sample in the window.
@override@JsonKey() final  int occupancyPeak;
/// Mean dwell time in seconds across all dwell observations.
@override@JsonKey() final  double dwellAvgSec;
/// Peak dwell time in rounded seconds.
@override@JsonKey() final  int dwellPeakSec;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.occupancyAvg, occupancyAvg) || other.occupancyAvg == occupancyAvg)&&(identical(other.occupancyPeak, occupancyPeak) || other.occupancyPeak == occupancyPeak)&&(identical(other.dwellAvgSec, dwellAvgSec) || other.dwellAvgSec == dwellAvgSec)&&(identical(other.dwellPeakSec, dwellPeakSec) || other.dwellPeakSec == dwellPeakSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,passBy,stay,entry,exit,appear,disappear,occupancyAvg,occupancyPeak,dwellAvgSec,dwellPeakSec);

@override
String toString() {
  return 'AreaPayload(id: $id, passBy: $passBy, stay: $stay, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, occupancyAvg: $occupancyAvg, occupancyPeak: $occupancyPeak, dwellAvgSec: $dwellAvgSec, dwellPeakSec: $dwellPeakSec)';
}


}

/// @nodoc
abstract mixin class _$AreaPayloadCopyWith<$Res> implements $AreaPayloadCopyWith<$Res> {
  factory _$AreaPayloadCopyWith(_AreaPayload value, $Res Function(_AreaPayload) _then) = __$AreaPayloadCopyWithImpl;
@override @useResult
$Res call({
 int id, int passBy, int stay, int entry, int exit, int appear, int disappear, double occupancyAvg, int occupancyPeak, double dwellAvgSec, int dwellPeakSec
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? passBy = null,Object? stay = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancyAvg = null,Object? occupancyPeak = null,Object? dwellAvgSec = null,Object? dwellPeakSec = null,}) {
  return _then(_AreaPayload(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stay: null == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,occupancyAvg: null == occupancyAvg ? _self.occupancyAvg : occupancyAvg // ignore: cast_nullable_to_non_nullable
as double,occupancyPeak: null == occupancyPeak ? _self.occupancyPeak : occupancyPeak // ignore: cast_nullable_to_non_nullable
as int,dwellAvgSec: null == dwellAvgSec ? _self.dwellAvgSec : dwellAvgSec // ignore: cast_nullable_to_non_nullable
as double,dwellPeakSec: null == dwellPeakSec ? _self.dwellPeakSec : dwellPeakSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
