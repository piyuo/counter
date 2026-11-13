import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const AnalyticsState({this.lastUpdatedUtc});
  final DateTime? lastUpdatedUtc;
}
