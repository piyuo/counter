import 'package:core_domain/core_domain.dart' as core_domain;

class AnalyticsState {
  const AnalyticsState({this.observations = const []});

  /// Finalized 5-minute observations received from ObservationNotifier.
  final List<core_domain.Observation> observations;

  AnalyticsState copyWith({List<core_domain.Observation>? observations}) {
    return AnalyticsState(observations: observations ?? this.observations);
  }
}
