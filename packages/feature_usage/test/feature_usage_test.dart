import 'package:feature_usage/feature_usage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    resetUsageForTesting();
    SharedPreferences.setMockInitialValues({});
  });

  test('initializes with Measurement Protocol credentials and has no native backend', () async {
    await initUsage(measurementId: 'G-TEST', apiSecret: 'secret', sendAppLaunch: false);

    expect(isUsageInitialized, isTrue);
    expect(measurementProtocol, isNotNull);
    expect(nativeBackend, isNull);
  });

  test('fails to initialize without a native backend or Measurement Protocol credentials', () async {
    await initUsage(sendAppLaunch: false);

    expect(isUsageInitialized, isFalse);
    expect(usageInitError, isNotNull);
  });

  test('falls back to Measurement Protocol when the native backend fails to init', () async {
    await initUsage(
      nativeBackend: _ThrowingBackend(),
      measurementId: 'G-TEST',
      apiSecret: 'secret',
      sendAppLaunch: false,
    );

    expect(isUsageInitialized, isTrue);
    expect(nativeBackend, isNull);
    expect(measurementProtocol, isNotNull);
  });

  test('sendEvent rejects reserved GA4 event names', () async {
    await initUsage(measurementId: 'G-TEST', apiSecret: 'secret', sendAppLaunch: false);

    expect(() => sendEvent(name: 'screen_view'), throwsA(isA<AssertionError>()));
  });
}

class _ThrowingBackend extends NativeUsageBackend {
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
