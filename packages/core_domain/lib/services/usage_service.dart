// usage_events.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UsageEvent {
  String get name;
  Map<String, Object> get parameters => {};
}

abstract interface class UsageService {
  Future<void> logEvent(UsageEvent event);

  NavigatorObserver createNavigatorObserver();

  bool get isEnabled;

  void setEnabled(bool enabled);
}

final usageServiceProvider = Provider<UsageService>((ref) {
  throw UnimplementedError('usageServiceProvider must be overridden');
});

class UsageEvents {
  UsageEvents._();

  static const newDevice = 'new_device';
  static const reset = 'reset';

  static const skipIntro = 'skip_intro';
  static const testStart = 'test_start';
  static const testPass = 'test_pass';
  static const testFail = 'test_fail';

  static const selectBusinessPiyuo = 'select_business_piyuo';
  static const selectBusinessCustom = 'select_business_custom';
  static const selectPersonalPiyuo = 'select_personal_piyuo';
  static const selectPersonalCustom = 'select_personal_custom';
  static const selectNoDataServer = 'select_local';

  static const setSource = 'set_source';
  static const visionStart = 'vision_start';
  static const visionStop = 'vision_stop';

  static const setTarget = 'set_target';
  static const setDetectionParams = 'set_detection_params';
  static const showTrackId = 'show_track_id';
}

class NewDeviceEvent extends UsageEvent {
  @override
  String get name => UsageEvents.newDevice;
}

class ResetEvent extends UsageEvent {
  @override
  String get name => UsageEvents.reset;
}

class SkipIntroEvent extends UsageEvent {
  @override
  String get name => UsageEvents.skipIntro;
}

class TestStartEvent extends UsageEvent {
  @override
  String get name => UsageEvents.testStart;
}

class TestPassEvent extends UsageEvent {
  TestPassEvent({
    required this.frameReadTimeMS,
    required this.detectionTimeMS,
    required this.reIDTimeMS,
    required this.trackingTimeMS,
  });
  final int frameReadTimeMS;
  final int detectionTimeMS;
  final int reIDTimeMS;
  final int trackingTimeMS;

  @override
  String get name => UsageEvents.testPass;

  @override
  Map<String, Object> get parameters => {
    'frameReadTimeMS': frameReadTimeMS,
    'detectionTimeMS': detectionTimeMS,
    'reIDTimeMS': reIDTimeMS,
    'trackingTimeMS': trackingTimeMS,
  };
}

class TestFailEvent extends UsageEvent {
  TestFailEvent({required this.errorMessage});

  final String errorMessage;

  @override
  String get name => UsageEvents.testFail;

  @override
  Map<String, Object> get parameters => {'errorMessage': errorMessage};
}

class SelectBusinessPiyuoEvent extends UsageEvent {
  @override
  String get name => UsageEvents.selectBusinessPiyuo;
}

class SelectBusinessCustomEvent extends UsageEvent {
  @override
  String get name => UsageEvents.selectBusinessCustom;
}

class SelectPersonalPiyuoEvent extends UsageEvent {
  @override
  String get name => UsageEvents.selectPersonalPiyuo;
}

class SelectPersonalCustomEvent extends UsageEvent {
  @override
  String get name => UsageEvents.selectPersonalCustom;
}

class SelectNoDataServerEvent extends UsageEvent {
  @override
  String get name => UsageEvents.selectNoDataServer;
}

class VisionStartEvent extends UsageEvent {
  VisionStartEvent({required this.source});

  final String source;

  @override
  String get name => UsageEvents.visionStart;

  @override
  Map<String, Object> get parameters => {'source': source};
}

class VisionStopEvent extends UsageEvent {
  VisionStopEvent({required this.usageDuration});
  final Duration usageDuration;

  @override
  String get name => UsageEvents.visionStop;

  @override
  Map<String, Object> get parameters => {'minutes': usageDuration.inMinutes};
}

class SetSourceEvent extends UsageEvent {
  SetSourceEvent({required this.source});

  final String source;

  @override
  String get name => UsageEvents.setSource;

  @override
  Map<String, Object> get parameters => {'source': source};
}

class SetTargetEvent extends UsageEvent {
  SetTargetEvent({required this.target});
  final String target;

  @override
  String get name => UsageEvents.setTarget;
  @override
  Map<String, Object> get parameters => {'target': target};
}

class ShowTrackIdEvent extends UsageEvent {
  @override
  String get name => UsageEvents.showTrackId;
}

class SetDetectionParamsEvent extends UsageEvent {
  SetDetectionParamsEvent({required this.params});

  final String params;

  @override
  String get name => UsageEvents.setDetectionParams;

  @override
  Map<String, Object> get parameters => {'params': params};
}
