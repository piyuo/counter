import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:feature_analytic/feature_analytic.dart' as feature_analytic;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:universal_platform/universal_platform.dart';

import 'firebase_options.dart';

Future<void> initializeAnalytics() async {
  final measurementId = appkit.envGet('GOOGLE_ANALYTICS_MEASUREMENT_ID');
  final apiSecret = appkit.envGet('GOOGLE_ANALYTICS_API_SECRET');

  if (measurementId.isEmpty || apiSecret.isEmpty) {
    appkit.logWarning('[Analytics] Google Analytics credentials are not configured.');
    return;
  }
  try {
    // Firebase Analytics only supports Android, iOS, macOS and web; Windows and
    // Linux fall back to the pure-HTTP GA4 Measurement Protocol backend.
    final supportsFirebase = !UniversalPlatform.isWindows && !UniversalPlatform.isLinux;

    await feature_analytic.initAnalytics(
      nativeBackend: supportsFirebase
          ? core_runtime.FirebaseAnalyticsBackend(firebaseOptions: DefaultFirebaseOptions.currentPlatform)
          : null,
      measurementId: measurementId,
      apiSecret: apiSecret,
    );

    if (!feature_analytic.isAnalyticsInitialized) {
      appkit.logWarning(
        '[Analytics] initialization failed: '
        '${feature_analytic.analyticsInitError}',
      );
      return;
    }
    final backend = feature_analytic.nativeBackend != null ? 'Firebase Analytics' : 'Measurement Protocol (HTTP)';
    appkit.logInfo('[Analytics] initialized successfully using $backend.');
  } catch (error, stackTrace) {
    appkit.logWarning('[Analytics] initialization error: $error\n$stackTrace');
  }
}
