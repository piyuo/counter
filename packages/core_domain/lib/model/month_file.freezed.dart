// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonthFile {

/// for example: year=2026, month=1, day=12
 int get year; int get month;/// 5-minute observations, to show average count  for every day in this month, 288 per day is expected.
 List<Observation> get dailyObservations;/// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
 List<Observation> get hourlyObservations;/// monthly observation, summarized from the hourly observations.
/// for example: pass-by: 225 // whole month
 Observation get monthlyObservation;
/// Create a copy of MonthFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthFileCopyWith<MonthFile> get copyWith => _$MonthFileCopyWithImpl<MonthFile>(this as MonthFile, _$identity);

  /// Serializes this MonthFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MonthFile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthFile&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&const DeepCollectionEquality().equals(other.dailyObservations, _this.dailyObservations)&&const DeepCollectionEquality().equals(other.hourlyObservations, _this.hourlyObservations)&&(identical(other.monthlyObservation, _this.monthlyObservation) || other.monthlyObservation == _this.monthlyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthFile;
  return Object.hash(runtimeType,_this.year,_this.month,const DeepCollectionEquality().hash(_this.dailyObservations),const DeepCollectionEquality().hash(_this.hourlyObservations),_this.monthlyObservation);
}



}

/// @nodoc
abstract mixin class $MonthFileCopyWith<$Res>  {
  factory $MonthFileCopyWith(MonthFile value, $Res Function(MonthFile) _then) = _$MonthFileCopyWithImpl;
@useResult
$Res call({
 int year, int month, List<Observation> dailyObservations, List<Observation> hourlyObservations, Observation monthlyObservation
});


$ObservationCopyWith<$Res> get monthlyObservation;

}
/// @nodoc
class _$MonthFileCopyWithImpl<$Res>
    implements $MonthFileCopyWith<$Res> {
  _$MonthFileCopyWithImpl(this._self, this._then);

  final MonthFile _self;
  final $Res Function(MonthFile) _then;

/// Create a copy of MonthFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? dailyObservations = null,Object? hourlyObservations = null,Object? monthlyObservation = null,}) {
  return _then(MonthFile(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,dailyObservations: null == dailyObservations ? _self.dailyObservations : dailyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,hourlyObservations: null == hourlyObservations ? _self.hourlyObservations : hourlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyObservation: null == monthlyObservation ? _self.monthlyObservation : monthlyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}
/// Create a copy of MonthFile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationCopyWith<$Res> get monthlyObservation {
  
  return $ObservationCopyWith<$Res>(_self.monthlyObservation, (value) {
    return _then(_self.copyWith(monthlyObservation: value));
  });
}
}


/// Adds pattern-matching-related methods to [MonthFile].
extension MonthFilePatterns on MonthFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthFile value)  $default,){
final _that = this;
switch (_that) {
case _MonthFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthFile value)?  $default,){
final _that = this;
switch (_that) {
case _MonthFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  List<Observation> dailyObservations,  List<Observation> hourlyObservations,  Observation monthlyObservation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthFile() when $default != null:
return $default(_that.year,_that.month,_that.dailyObservations,_that.hourlyObservations,_that.monthlyObservation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  List<Observation> dailyObservations,  List<Observation> hourlyObservations,  Observation monthlyObservation)  $default,) {final _that = this;
switch (_that) {
case _MonthFile():
return $default(_that.year,_that.month,_that.dailyObservations,_that.hourlyObservations,_that.monthlyObservation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  List<Observation> dailyObservations,  List<Observation> hourlyObservations,  Observation monthlyObservation)?  $default,) {final _that = this;
switch (_that) {
case _MonthFile() when $default != null:
return $default(_that.year,_that.month,_that.dailyObservations,_that.hourlyObservations,_that.monthlyObservation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthFile extends MonthFile {
  const _MonthFile({required this.year, required this.month, required  List<Observation> dailyObservations, required  List<Observation> hourlyObservations, required this.monthlyObservation}): _dailyObservations = dailyObservations,_hourlyObservations = hourlyObservations,super._();
  factory _MonthFile.fromJson(Map<String, dynamic> json) => _$MonthFileFromJson(json);

/// for example: year=2026, month=1, day=12
@override final  int year;
@override final  int month;
/// 5-minute observations, to show average count  for every day in this month, 288 per day is expected.
 final  List<Observation> _dailyObservations;
/// 5-minute observations, to show average count  for every day in this month, 288 per day is expected.
@override List<Observation> get dailyObservations {
  if (_dailyObservations is EqualUnmodifiableListView) return _dailyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyObservations);
}

/// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
 final  List<Observation> _hourlyObservations;
/// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
@override List<Observation> get hourlyObservations {
  if (_hourlyObservations is EqualUnmodifiableListView) return _hourlyObservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourlyObservations);
}

/// monthly observation, summarized from the hourly observations.
/// for example: pass-by: 225 // whole month
@override final  Observation monthlyObservation;

/// Create a copy of MonthFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthFileCopyWith<_MonthFile> get copyWith => __$MonthFileCopyWithImpl<_MonthFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthFileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthFile&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.dailyObservations, _dailyObservations)&&const DeepCollectionEquality().equals(other.hourlyObservations, _hourlyObservations)&&(identical(other.monthlyObservation, monthlyObservation) || other.monthlyObservation == monthlyObservation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(_dailyObservations),const DeepCollectionEquality().hash(_hourlyObservations),monthlyObservation);
}



}

/// @nodoc
abstract mixin class _$MonthFileCopyWith<$Res> implements $MonthFileCopyWith<$Res> {
  factory _$MonthFileCopyWith(_MonthFile value, $Res Function(_MonthFile) _then) = __$MonthFileCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, List<Observation> dailyObservations, List<Observation> hourlyObservations, Observation monthlyObservation
});


@override $ObservationCopyWith<$Res> get monthlyObservation;

}
/// @nodoc
class __$MonthFileCopyWithImpl<$Res>
    implements _$MonthFileCopyWith<$Res> {
  __$MonthFileCopyWithImpl(this._self, this._then);

  final _MonthFile _self;
  final $Res Function(_MonthFile) _then;

/// Create a copy of MonthFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? dailyObservations = null,Object? hourlyObservations = null,Object? monthlyObservation = null,}) {
  return _then(_MonthFile(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,dailyObservations: null == dailyObservations ? _self._dailyObservations : dailyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,hourlyObservations: null == hourlyObservations ? _self._hourlyObservations : hourlyObservations // ignore: cast_nullable_to_non_nullable
as List<Observation>,monthlyObservation: null == monthlyObservation ? _self.monthlyObservation : monthlyObservation // ignore: cast_nullable_to_non_nullable
as Observation,
  ));
}

/// Create a copy of MonthFile
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
