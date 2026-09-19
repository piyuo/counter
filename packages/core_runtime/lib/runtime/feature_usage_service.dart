import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_usage/feature_usage.dart' as feature_usage;
import 'package:flutter/widgets.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_usage_service.g.dart';

@Riverpod(keepAlive: true)
class FeatureUsageService extends _$FeatureUsageService implements core_domain.UsageService {
  @override
  void build() {}

  @override
  bool get isEnabled {
    return feature_usage.isUsageInitialized && !feature_usage.isUsageDisabled;
  }

  @override
  void setEnabled(bool enabled) {
    if (!feature_usage.isUsageInitialized) {
      return;
    }

    feature_usage.isUsageDisabled = !enabled;

    appkit.logInfo('Usage ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  Future<void> logEvent(core_domain.UsageEvent event) async {
    if (!isEnabled) {
      appkit.logDebug('[FeatureUsageService] Skipping usage event: ${event.name}');
      return;
    }

    try {
      feature_usage.sendEvent(name: event.name, parameters: event.parameters);
      appkit.logInfo('[FeatureUsageService] logged: ${event.name}');
    } catch (e) {
      appkit.logWarning('[FeatureUsageService] failed to log event: ${event.name}, error: $e');
    }
  }

  @override
  NavigatorObserver createNavigatorObserver() {
    return feature_usage.FeatureUsageObserver();
  }
}
