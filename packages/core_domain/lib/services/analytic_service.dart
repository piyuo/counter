// analytics_events.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AnalyticsEvent {
  String get name;
  Map<String, Object> get parameters => {};
}

abstract interface class AnalyticsService {
  Future<void> logEvent(AnalyticsEvent event);

  NavigatorObserver createNavigatorObserver();

  bool get isEnabled;

  void setEnabled(bool enabled);
}

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  throw UnimplementedError('analyticsServiceProvider must be overridden');
});

class AnalyticsEvents {
  AnalyticsEvents._();

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

class NewDeviceEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.newDevice;
}

class ResetEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.reset;
}

class SkipIntroEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.skipIntro;
}

class TestStartEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.testStart;
}

class TestPassEvent extends AnalyticsEvent {
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
  String get name => AnalyticsEvents.testPass;

  @override
  Map<String, Object> get parameters => {
    'frameReadTimeMS': frameReadTimeMS,
    'detectionTimeMS': detectionTimeMS,
    'reIDTimeMS': reIDTimeMS,
    'trackingTimeMS': trackingTimeMS,
  };
}

class TestFailEvent extends AnalyticsEvent {
  TestFailEvent({required this.errorMessage});

  final String errorMessage;

  @override
  String get name => AnalyticsEvents.testFail;

  @override
  Map<String, Object> get parameters => {'errorMessage': errorMessage};
}

class SelectBusinessPiyuoEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.selectBusinessPiyuo;
}

class SelectBusinessCustomEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.selectBusinessCustom;
}

class SelectPersonalPiyuoEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.selectPersonalPiyuo;
}

class SelectPersonalCustomEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.selectPersonalCustom;
}

class SelectNoDataServerEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.selectNoDataServer;
}

class VisionStartEvent extends AnalyticsEvent {
  VisionStartEvent({required this.source});

  final String source;

  @override
  String get name => AnalyticsEvents.visionStart;

  @override
  Map<String, Object> get parameters => {'source': source};
}

class VisionStopEvent extends AnalyticsEvent {
  VisionStopEvent({required this.usageDuration});
  final Duration usageDuration;

  @override
  String get name => AnalyticsEvents.visionStop;

  @override
  Map<String, Object> get parameters => {'minutes': usageDuration.inMinutes};
}

class SetSourceEvent extends AnalyticsEvent {
  SetSourceEvent({required this.source});

  final String source;

  @override
  String get name => AnalyticsEvents.setSource;

  @override
  Map<String, Object> get parameters => {'source': source};
}

class SetTargetEvent extends AnalyticsEvent {
  SetTargetEvent({required this.target});
  final String target;

  @override
  String get name => AnalyticsEvents.setTarget;
  @override
  Map<String, Object> get parameters => {'target': target};
}

class ShowTrackIdEvent extends AnalyticsEvent {
  @override
  String get name => AnalyticsEvents.showTrackId;
}

class SetDetectionParamsEvent extends AnalyticsEvent {
  SetDetectionParamsEvent({required this.params});

  final String params;

  @override
  String get name => AnalyticsEvents.setDetectionParams;

  @override
  Map<String, Object> get parameters => {'params': params};
}
