// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DayFile {

/// for example: year=2026, month=1, day=12
 int get year; int get month; int get day;/// 5-minute observations, max 288 per day. if observations are missing, the list may contain fewer entries.
 List<Observation> get fiveMinuteObservations;/// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
 List<Observation> get hourlyObservations;/// Daily observation, summarized from the hourly observations.
/// for example: pass-by: 225 // all day
 Observation get dailyObservation;
/// Create a copy of DayFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayFileCopyWith<DayFile> get copyWith => _$DayFileCopyWithImpl<DayFile>(this as DayFile, _$identity);

  /// Serializes this DayFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DayFile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayFile&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day)&&const DeepCollectionEquality().equals(other.fiveMinuteObservations, _this.fiveMinuteObservations)&&const DeepCollectionEquality().equals(other.hourlyObservations, _this.hourlyObservations)&&(identical(other.dailyObservation, _this.dailyObservation) || other.dailyObservation == _this.dailyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DayFile;
  return Object.hash(runtimeType,_this.year,_this.month,_this.day,const DeepCollectionEquality().hash(_this.fiveMinuteObservations),const DeepCollectionEquality().hash(_this.hourlyObservations),_this.dailyObservation);
}



}

/// @nodoc
abstract mixin class $DayFileCopyWith<$Res>  {
  factory $DayFileCopyWith(DayFile value, $Res Function(DayFile) _then) = _$DayFileCopyWithImpl;
@useResult
$Res call({
 int year, int month, int day, List<Observation> fiveMinuteObservations, List<Observation> hourlyObservations, Observation dailyObservation
});


$ObservationCopyWith<$Res> get dailyObservation;

}
/// @nodoc
class _$DayFileCopyWithImpl<$Res>
    implements $DayFileCopyWith<$Res> {
  _$DayFileCopyWithImpl(this._self, this._then);

  final DayFile _self;
  final $Res Function(DayFile) _then;

/// Create a copy of DayFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? day = null,Object? fiveMinuteObservations = null,Object? hourlyObservations = null,Object? dailyObservation = null,}) {
  return _then(DayFile(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,fiveMinuteObservations: null == fiveMinuteObservations ? _self.fiveMinuteObservations : fiveMinuteObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,hourlyObservations: null == hourlyObservations ? _self.hourlyObservations : hourlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyObservation: null == dailyObservation ? _self.dailyObservation : dailyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}
/// Create a copy of DayFile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get dailyObservation {
  
  return $ObservationCopyWith<$Res>(_self.dailyObservation, (value) {
    return _then(_self.copyWith(dailyObservation: value));
  });
}
}


/// Adds pattern-matching-related methods to [DayFile].
extension DayFilePatterns on DayFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayFile value)  $default,){
final _that = this;
switch (_that) {
case _DayFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayFile value)?  $default,){
final _that = this;
switch (_that) {
case _DayFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  int day,  List<Observation> fiveMinuteObservations,  List<Observation> hourlyObservations,  Observation dailyObservation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayFile() when $default != null:
return $default(_that.year,_that.month,_that.day,_that.fiveMinuteObservations,_that.hourlyObservations,_that.dailyObservation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  int day,  List<Observation> fiveMinuteObservations,  List<Observation> hourlyObservations,  Observation dailyObservation)  $default,) {final _that = this;
switch (_that) {
case _DayFile():
return $default(_that.year,_that.month,_that.day,_that.fiveMinuteObservations,_that.hourlyObservations,_that.dailyObservation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  int day,  List<Observation> fiveMinuteObservations,  List<Observation> hourlyObservations,  Observation dailyObservation)?  $default,) {final _that = this;
switch (_that) {
case _DayFile() when $default != null:
return $default(_that.year,_that.month,_that.day,_that.fiveMinuteObservations,_that.hourlyObservations,_that.dailyObservation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayFile extends DayFile {
  const _DayFile({required this.year, required this.month, required this.day, required  List<Observation> fiveMinuteObservations, required  List<Observation> hourlyObservations, required this.dailyObservation}): _fiveMinuteObservations = fiveMinuteObservations,_hourlyObservations = hourlyObservations,super._();
  factory _DayFile.fromJson(Map<String, dynamic> json) => _$DayFileFromJson(json);

/// for example: year=2026, month=1, day=12
@override final  int year;
@override final  int month;
@override final  int day;
/// 5-minute observations, max 288 per day. if observations are missing, the list may contain fewer entries.
 final  List<Observation> _fiveMinuteObservations;
/// 5-minute observations, max 288 per day. if observations are missing, the list may contain fewer entries.
@override List<Observation> get fiveMinuteObservations {
  if (_fiveMinuteObservations is EqualUnmodifiableListView) return _fiveMinuteObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fiveMinuteObservations);
}

/// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
 final  List<Observation> _hourlyObservations;
/// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
@override List<Observation> get hourlyObservations {
  if (_hourlyObservations is EqualUnmodifiableListView) return _hourlyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourlyObservations);
}

/// Daily observation, summarized from the hourly observations.
/// for example: pass-by: 225 // all day
@override final  Observation dailyObservation;

/// Create a copy of DayFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayFileCopyWith<_DayFile> get copyWith => __$DayFileCopyWithImpl<_DayFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayFileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayFile&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other.fiveMinuteObservations, _fiveMinuteObservations)&&const DeepCollectionEquality().equals(other.hourlyObservations, _hourlyObservations)&&(identical(other.dailyObservation, dailyObservation) || other.dailyObservation == dailyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,month,day,const DeepCollectionEquality().hash(_fiveMinuteObservations),const DeepCollectionEquality().hash(_hourlyObservations),dailyObservation);
}



}

/// @nodoc
abstract mixin class _$DayFileCopyWith<$Res> implements $DayFileCopyWith<$Res> {
  factory _$DayFileCopyWith(_DayFile value, $Res Function(_DayFile) _then) = __$DayFileCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, int day, List<Observation> fiveMinuteObservations, List<Observation> hourlyObservations, Observation dailyObservation
});


@override $ObservationCopyWith<$Res> get dailyObservation;

}
/// @nodoc
class __$DayFileCopyWithImpl<$Res>
    implements _$DayFileCopyWith<$Res> {
  __$DayFileCopyWithImpl(this._self, this._then);

  final _DayFile _self;
  final $Res Function(_DayFile) _then;

/// Create a copy of DayFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,Object? fiveMinuteObservations = null,Object? hourlyObservations = null,Object? dailyObservation = null,}) {
  return _then(_DayFile(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,fiveMinuteObservations: null == fiveMinuteObservations ? _self._fiveMinuteObservations : fiveMinuteObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,hourlyObservations: null == hourlyObservations ? _self._hourlyObservations : hourlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,dailyObservation: null == dailyObservation ? _self.dailyObservation : dailyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}

/// Create a copy of DayFile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get dailyObservation {
  
  return $ObservationCopyWith<$Res>(_self.dailyObservation, (value) {
    return _then(_self.copyWith(dailyObservation: value));
  });
}
}

// dart format on
