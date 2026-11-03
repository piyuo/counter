import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'observation_state.freezed.dart';

enum ObservationStatus { live, interrupted, stopped }

@freezed
class ObservationState with _$ObservationState {
  const ObservationState({this.liveObservation, this.status = ObservationStatus.stopped, this.observationStartUtc});

  final ObservationStatus status;

  // let user determine the observation is enough to get meaningful data
  // we currently think 20 minutes is enough
  final DateTime? observationStartUtc;

  final core_domain.Observation? liveObservation;

  Duration? get observationDuration {
    if (observationStartUtc == null) return null;
    return DateTime.now().toUtc().difference(observationStartUtc!);
  }
}
