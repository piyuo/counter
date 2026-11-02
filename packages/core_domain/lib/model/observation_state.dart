import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'observation_state.freezed.dart';

enum ObservationStatus { active, inactive }

@freezed
class ObservationState with _$ObservationState {
  const ObservationState({this.liveObservation, this.status = ObservationStatus.inactive});

  final ObservationStatus status;

  final core_domain.Observation? liveObservation;
}
