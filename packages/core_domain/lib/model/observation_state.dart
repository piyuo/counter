import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'observation_state.freezed.dart';

enum ObservationStatus { started, interrupted, stopped }

@freezed
class ObservationState with _$ObservationState {
  const ObservationState({
    required this.liveObservation,
    this.status = ObservationStatus.stopped,
    this.observationStartUtc,
  });

  /// The current live observation. This is always required and cannot be null.
  final core_domain.Observation liveObservation;

  final ObservationStatus status;

  // let user determine the observation is enough to get meaningful data
  // we currently think 20 minutes is enough
  final DateTime? observationStartUtc;

  Duration? get timeSinceObservationStart {
    if (observationStartUtc == null) return null;
    return DateTime.now().toUtc().difference(observationStartUtc!);
  }
}
