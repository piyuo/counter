import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

/// Rounds [value] to [places] decimal places.
///
/// Returns 0 for NaN or infinity so serialization never throws.
double _round(double value, int places) {
  if (!value.isFinite) return 0;
  final factor = pow(10, places).toDouble();
  return (value * factor).round() / factor;
}

/// Writes a double rounded to 2 decimals (for example, 0.92 instead of
/// 0.9222222222). Reading accepts any number.
///
/// Use it only on derived fields (ratios and averages). Do not use it on
/// sums or counts, which are the source of truth.
class RoundedDouble implements JsonConverter<double, dynamic> {
  const RoundedDouble();

  @override
  double fromJson(dynamic json) => (json as num).toDouble();

  @override
  double toJson(double value) => _round(value, 2);
}
