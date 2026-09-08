import 'package:ambilytics/ambilytics.dart' as ambilytics;
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/widgets.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ambilytics_analytic_service.g.dart';

@Riverpod(keepAlive: true)
class AmbilyticsAnalyticService extends _$AmbilyticsAnalyticService implements core_domain.AnalyticsService {
  @override
  void build() {}

  @override
  bool get isEnabled {
    return ambilytics.isAmbilyticsInitialized && !ambilytics.isAmbilyticsDisabled;
  }

  @override
  void setEnabled(bool enabled) {
    if (!ambilytics.isAmbilyticsInitialized) {
      return;
    }

    ambilytics.isAmbilyticsDisabled = !enabled;

    appkit.logInfo('Analytics ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  Future<void> logEvent(core_domain.AnalyticsEvent event) async {
    if (!isEnabled) {
      appkit.logDebug('[AmbilyticsAnalyticService] Skipping analytics event: ${event.name}');
      return;
    }

    try {
      ambilytics.sendEvent(name: event.name, parameters: event.parameters);
      appkit.logInfo('[AmbilyticsAnalyticService] logged: ${event.name}');
    } catch (e) {
      appkit.logWarning('[AmbilyticsAnalyticService] failed to log event: ${event.name}, error: $e');
    }
  }

  @override
  NavigatorObserver createNavigatorObserver() {
    return ambilytics.AmbilyticsObserver();
  }
}
