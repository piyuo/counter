import 'package:ambilytics/ambilytics.dart' as ambilytics;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

import 'firebase_options.dart';

Future<void> initializeAnalytics() async {
  final measurementId = appkit.envGet('GOOGLE_ANALYTICS_MEASUREMENT_ID');
  final apiSecret = appkit.envGet('GOOGLE_ANALYTICS_API_SECRET');

  if (measurementId.isEmpty || apiSecret.isEmpty) {
    appkit.logWarning('[Analytics] Google Analytics credentials are not configured.');
    return;
  }
  try {
    await ambilytics.initAnalytics(
      disableAnalytics: true,
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      measurementId: measurementId,
      apiSecret: apiSecret,
    );

    if (!ambilytics.isAmbilyticsInitialized) {
      appkit.logWarning(
        '[Analytics] initialization failed: '
        '${ambilytics.initError}',
      );
      return;
    }
    appkit.logInfo('[Analytics] initialized successfully.');
  } catch (error, stackTrace) {
    appkit.logWarning('[Analytics] initialization error: $error\n$stackTrace');
  }
}
