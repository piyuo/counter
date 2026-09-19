/// Cross-platform analytics with a pluggable native backend (e.g. Firebase
/// Analytics) plus a built-in GA4 Measurement Protocol HTTP fallback.
///
/// This package has no dependency on any Firebase package, so it's safe to
/// use on every platform, including Windows and Linux.
library;

export 'src/feature_usage_controller.dart';
export 'src/feature_usage_observer.dart';
export 'src/measurement_protocol_session.dart';
export 'src/predefined_events.dart';
export 'src/usage_backend.dart';
