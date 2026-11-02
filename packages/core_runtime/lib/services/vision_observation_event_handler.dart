import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;

class VisionObservationEventHandler {
  VisionObservationEventHandler(this._observationService);

  final core_domain.ObservationService _observationService;

  bool _isPaused = false;

  void handleEvent(vision.VisionEvent event) {
    if (event is vision.VisionStopped || event is vision.VisionFailure || event is vision.VisionIssue) {
      _isPaused = true;
      _observationService.pause();
    }
  }

  void handleFrame(List<vision.TrackedObject> tracks, double rotationDegrees) {
    if (_isPaused) {
      _observationService.resume();
      _isPaused = false;
    }

    _observationService.processFrame(tracks, rotationDegrees);
  }
}
