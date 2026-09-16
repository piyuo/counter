import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'analytics_backend.dart';
import 'measurement_protocol_session.dart';
import 'predefined_events.dart';

const _userIdPrefsKey = 'feature_analytic_user_id';

NativeAnalyticsBackend? _nativeBackend;
MeasurementProtocolSession? _measurementProtocol;
Object? _initError;

// Analytics can be initialized but disabled in case disabling occurs after initialization.
bool _initialized = false;
bool _disabled = true;

/// The native SDK backend (e.g. Firebase Analytics), if one was supplied to
/// [initAnalytics] and initialized successfully.
NativeAnalyticsBackend? get nativeBackend => _nativeBackend;

/// The GA4 Measurement Protocol HTTP backend, used when no [nativeBackend] is
/// available (e.g. on Windows/Linux) or as a fallback.
MeasurementProtocolSession? get measurementProtocol => _measurementProtocol;

/// Whether analytics initialization was successfully completed.
bool get isAnalyticsInitialized => _initialized;

/// If an error occurred during initialization, it's recorded here rather than thrown.
Object? get analyticsInitError => _initError;

/// Stop or resume sending events.
bool get isAnalyticsDisabled => _disabled;
set isAnalyticsDisabled(bool value) => _disabled = value;

@visibleForTesting
void setMockNativeBackend(NativeAnalyticsBackend backend) => _nativeBackend = backend;

@visibleForTesting
void setMockMeasurementProtocol(MeasurementProtocolSession session) => _measurementProtocol = session;

@visibleForTesting
void resetAnalyticsForTesting() {
  _initialized = false;
  _disabled = true;
  _nativeBackend = null;
  _measurementProtocol = null;
  _initError = null;
}

/// Prepares analytics for use. Doesn't throw errors; in debug mode failures
/// raise assertions. If initialization fails, [isAnalyticsInitialized] stays false.
///
/// [nativeBackend], if supplied, is tried first (e.g. a Firebase Analytics
/// adapter). Callers should only ever pass one in for platforms the native
/// SDK actually supports (this package never imports/depends on any such SDK
/// itself, so it stays usable on Windows, Linux, etc. with plain HTTP).
///
/// If [nativeBackend] is `null`, fails to initialize, or is not supplied,
/// [measurementId] and [apiSecret] can be used to enable the GA4 Measurement
/// Protocol HTTP fallback instead.
///
///
/// If [sendAppLaunch] is true, [PredefinedEvents.appLaunch] is sent with a
/// `platform` param once initialization succeeds.
///
/// [userId] overrides the default user identifier. If not provided, the
/// native SDK's own default is used, or (for the Measurement Protocol) a GUID
/// is generated and persisted via shared_preferences.
Future<void> initAnalytics({
  bool sendAppLaunch = true,
  NativeAnalyticsBackend? nativeBackend,
  String? measurementId,
  String? apiSecret,
  String? userId,
}) async {
  if (_initialized) return;
  _disabled = false; // init will enable analytics
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (nativeBackend != null) {
      try {
        await nativeBackend.init();
        if (userId != null) {
          await nativeBackend.setUserId(userId);
        }
        _nativeBackend = nativeBackend;
        _initialized = true;
        if (sendAppLaunch) {
          _sendAppLaunchEvent();
        }
        return;
      } catch (e) {
        // Fall back to the Measurement Protocol (pure HTTP, works everywhere).
        _initError = e;
      }
    }

    var mpUserId = userId;
    if (mpUserId == null) {
      final prefs = await SharedPreferences.getInstance();
      mpUserId = prefs.getString(_userIdPrefsKey);
      if (mpUserId == null) {
        mpUserId = const Uuid().v4();
        await prefs.setString(_userIdPrefsKey, mpUserId);
      }
    }

    if (measurementId != null && apiSecret != null) {
      _measurementProtocol = MeasurementProtocolSession(measurementId, apiSecret, mpUserId);
    }

    if (_measurementProtocol != null) {
      _initialized = true;
      if (sendAppLaunch) {
        _sendAppLaunchEvent();
      }
    } else {
      _initError ??= 'Neither a native backend nor Measurement Protocol credentials were provided.';
    }
    _disabled = false;
  } catch (e) {
    _initialized = false;
    _initError = e;
    assert(false, "Can't init analytics due to error.\n\n$e");
  }
}

void _sendAppLaunchEvent() {
  final params = {'platform': kIsWeb ? 'web' : defaultTargetPlatform.name};
  sendEvent(name: PredefinedEvents.appLaunch, parameters: params);
}

/// Sends [name] with [parameters] using the native backend if available,
/// otherwise the Measurement Protocol. Never sends the same event with both.
void sendEvent({required String name, Map<String, Object>? parameters}) {
  if (!_initialized) return;
  if (_disabled) return;

  assert(!reservedGa4Events.contains(name), '"$name" is a reserved GA4 event name');
  assert(name.isNotEmpty && name.length <= 40, 'Event name should be between 1 and 40 characters long');

  if (_nativeBackend != null) {
    _nativeBackend!.logEvent(name, parameters);
  } else {
    _measurementProtocol?.sendEvent(name, parameters);
  }
}
