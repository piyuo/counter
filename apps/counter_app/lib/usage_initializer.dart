import 'package:feature_usage/feature_usage.dart' as feature_usage;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:universal_platform/universal_platform.dart';

import 'firebase_analytics_backend.dart';
import 'firebase_options.dart';

Future<void> initializeUsage() async {
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

    await feature_usage.initUsage(
      nativeBackend: supportsFirebase
          ? FirebaseAnalyticsBackend(firebaseOptions: DefaultFirebaseOptions.currentPlatform)
          : null,
      measurementId: measurementId,
      apiSecret: apiSecret,
    );

    if (!feature_usage.isUsageInitialized) {
      appkit.logWarning(
        '[initializeUsage] initialization failed: '
        '${feature_usage.usageInitError}',
      );
      return;
    }
    final backend = feature_usage.nativeBackend != null ? 'Firebase Analytics' : 'Measurement Protocol (HTTP)';
    appkit.logDebug('[initializeUsage] using $backend.');
  } catch (error, stackTrace) {
    appkit.logWarning('[initializeUsage] initialization error: $error\n$stackTrace');
  }
}
