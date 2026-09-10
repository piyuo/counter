import 'package:feature_analytic/feature_analytic.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    resetAnalyticsForTesting();
    SharedPreferences.setMockInitialValues({});
  });

  test('initializes with Measurement Protocol credentials and has no native backend', () async {
    await initAnalytics(measurementId: 'G-TEST', apiSecret: 'secret', sendAppLaunch: false);

    expect(isAnalyticsInitialized, isTrue);
    expect(measurementProtocol, isNotNull);
    expect(nativeBackend, isNull);
  });

  test('fails to initialize without a native backend or Measurement Protocol credentials', () async {
    await initAnalytics(sendAppLaunch: false);

    expect(isAnalyticsInitialized, isFalse);
    expect(analyticsInitError, isNotNull);
  });

  test('falls back to Measurement Protocol when the native backend fails to init', () async {
    await initAnalytics(
      nativeBackend: _ThrowingBackend(),
      measurementId: 'G-TEST',
      apiSecret: 'secret',
      sendAppLaunch: false,
    );

    expect(isAnalyticsInitialized, isTrue);
    expect(nativeBackend, isNull);
    expect(measurementProtocol, isNotNull);
  });

  test('sendEvent rejects reserved GA4 event names', () async {
    await initAnalytics(measurementId: 'G-TEST', apiSecret: 'secret', sendAppLaunch: false);

    expect(() => sendEvent(name: 'screen_view'), throwsA(isA<AssertionError>()));
  });
}

class _ThrowingBackend extends NativeAnalyticsBackend {
  @override
  Future<void> init() async => throw StateError('native backend unavailable');

  @override
  Future<void> setUserId(String userId) async {}

  @override
  void logEvent(String name, Map<String, Object?>? parameters) {}

  @override
  NavigatorObserver? createNavigatorObserver({
    ScreenNameExtractor nameExtractor = defaultNameExtractor,
    RouteFilter routeFilter = defaultRouteFilter,
    void Function(Object error)? onError,
  }) => null;
}
