import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;

class VisionObservationEventHandler {
  VisionObservationEventHandler(this._observationService);

  final core_domain.ObservationService _observationService;

  bool _isPaused = false;
  bool _isStopped = false;

  void handleEvent(vision.VisionEvent event) {
    if (event is vision.VisionIssue) {
      _isPaused = true;
      _observationService.pause();
    } else if (event is vision.VisionStopped || event is vision.VisionFailure) {
      _isPaused = false;
      _isStopped = true;
      _observationService.stop();
    } else if (event is vision.VisionStarted && _isStopped) {
      _isStopped = false;
      _observationService.start();
    }
  }

  void handleFrame(List<vision.TrackedObject> tracks, double rotationDegrees) {
    if (_isStopped) return;

    if (_isPaused) {
      _observationService.resume();
      _isPaused = false;
    }

    _observationService.processFrame(tracks, rotationDegrees);
  }
}
