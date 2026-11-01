import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const AnalyticsState({this.observations = const []});

  /// Finalized 5-minute observations received from ObservationNotifier.
  final List<core_domain.Observation> observations;
}
