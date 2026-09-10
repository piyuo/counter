import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_analytic/feature_analytic.dart' as feature_analytic;
import 'package:flutter/widgets.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_analytic_service.g.dart';

@Riverpod(keepAlive: true)
class FeatureAnalyticService extends _$FeatureAnalyticService implements core_domain.AnalyticsService {
  @override
  void build() {}

  @override
  bool get isEnabled {
    return feature_analytic.isAnalyticsInitialized && !feature_analytic.isAnalyticsDisabled;
  }

  @override
  void setEnabled(bool enabled) {
    if (!feature_analytic.isAnalyticsInitialized) {
      return;
    }

    feature_analytic.isAnalyticsDisabled = !enabled;

    appkit.logInfo('Analytics ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  Future<void> logEvent(core_domain.AnalyticsEvent event) async {
    if (!isEnabled) {
      appkit.logDebug('[FeatureAnalyticService] Skipping analytics event: ${event.name}');
      return;
    }

    try {
      feature_analytic.sendEvent(name: event.name, parameters: event.parameters);
      appkit.logInfo('[FeatureAnalyticService] logged: ${event.name}');
    } catch (e) {
      appkit.logWarning('[FeatureAnalyticService] failed to log event: ${event.name}, error: $e');
    }
  }

  @override
  NavigatorObserver createNavigatorObserver() {
    return feature_analytic.FeatureAnalyticObserver();
  }
}
