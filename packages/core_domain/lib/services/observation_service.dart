import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'observation_service.g.dart';

/// the vision vision service will send every frame to this observation service.
/// It processes these frames and emits observation states in 5-minute window aligned to wall clock.
abstract class ObservationService {
  /// snapshots emits when 5-minutes window finalized..
  Stream<core_domain.ObservationState> get snapshots;

  /// Starts the observation service and begins processing frames.
  void start();

  /// Stops the observation service and releases any resources.
  void stop();

  /// Processes a single frame of tracked objects.
  void processFrame<T>(List<T> tracks, double rotationDegrees);

  /// notifies the source  is paused. no further frames will be processed until resumed.
  void pause();

  /// notifies the source is resumed. frames will be processed again.
  void resume();

  /// Sets the threshold durations for stay and disappear events.
  void setThresholdSeconds({int? stayThresholdSeconds, int? disappearThresholdSeconds});
}

@riverpod
ObservationService observationService(Ref ref) {
  throw UnimplementedError('observationServiceProvider must be overridden');
}
