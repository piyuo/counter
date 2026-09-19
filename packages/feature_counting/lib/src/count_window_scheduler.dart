// TOC
// - Thresholds
// - State & helpers
// - Callbacks
// - Constructor
// - Lifecycle (dispose, getters)
// - Public API — control (reset, onSourceStarted, ensureWindowActive)
// - Private — window management

import 'clock_jump_detector.dart';
import 'window_boundary_timer.dart';

// Callbacks
typedef CountWindowCallback = void Function(DateTime startUtc, DateTime startBusiness, Duration missingDuration);

/// Drives 5-minute pedestrian-counting windows aligned to the wall clock
/// (e.g. 4:00–4:05, 4:05–4:10, …) and tracks missing coverage so that the
/// backend can apply accurate statistical corrections.
///
/// ### Window lifecycle
/// Each window is opened via [onWindowStart] and closed by [onWindowEnd] when
/// the 5-minute wall-clock boundary is crossed.
///
/// ### Missing-duration accounting
/// The scheduler reports coverage loss at the start of a window via the
/// `missingDuration` argument on [onWindowStart]:  i.e. how far into the window the first frame was delayed.
/// Additional in-window missing time (gaps between frames) is derived by the
/// notifier via [FrameGapTracker].
///
/// ### 24/7 robustness
/// [ClockJumpDetector] runs its own periodic timer (every 5 s) to compare the
/// wall clock against the monotonic clock. NTP corrections, host sleep/wake, or
/// DST changes are detected autonomously and the window state is reset safely.
///
/// ### Architecture
/// Internally uses composition with [ClockJumpDetector] and
/// [WindowBoundaryTimer]. In-window missing-duration tracking is handled by
/// the owning notifier via [FrameGapTracker].
class CountWindowScheduler {
  // Thresholds

  /// Gaps between consecutive windows smaller than this are considered seamless
  /// continuations (e.g. a frame arriving 1 second late).
  static const Duration _partialWindowTolerance = Duration(seconds: 2);

  /// Minimum divergence between the wall clock and the monotonic clock that
  /// is treated as a clock jump rather than normal drift.
  static const Duration _clockJumpThreshold = Duration(minutes: 1);

  // State & helpers

  final DateTime Function() _now;

  /// Detects clock jumps between wall-clock and monotonic-clock.
  late final ClockJumpDetector _clockJumpDetector;

  /// Manages the 5-minute boundary timer.
  late final WindowBoundaryTimer _boundaryTimer;

  /// Start of the currently open window in local time; null when no window is active.
  ///
  /// INVARIANT: This field always stores local time, never UTC.
  DateTime? _windowStartLocal;

  /// End of the currently open window in local time; null when no window is active.
  DateTime? get _windowEndLocal => _windowStartLocal?.add(const Duration(minutes: 5));

  DateTime? get windowStartUtc => _windowStartLocal?.toUtc();

  DateTime? get windowEndUtc => _windowEndLocal?.toUtc();

  /// Called when a new 5-minute window opens.
  ///
  /// - [startUtc] — the UTC start of the new window
  /// - [startBusiness] — the business-time start of the new window
  /// - [missingDuration] — how long this window had been running before the
  ///   first frame arrived (zero for the first window, for seamless rollovers,
  ///   or when the source restarts exactly at a boundary). Represents coverage
  ///   loss at the start of the window: `nowUtc − startUtc`.
  final CountWindowCallback onWindowStart;

  /// Called when the current window closes cleanly at the 5-minute boundary.
  /// The caller should finalize and persist the window data.
  final CountWindowCallback onWindowEnd;

  // Constructor & static clock

  CountWindowScheduler({
    required this.onWindowStart,
    required this.onWindowEnd,
    DateTime Function()? nowProvider,
    Duration Function()? monotonicNowProvider,
  }) : _now = nowProvider ?? (() => DateTime.now()) {
    _clockJumpDetector = ClockJumpDetector(
      nowProvider: _now,
      monotonicNow: monotonicNowProvider,
      threshold: _clockJumpThreshold,
      onJumpDetected: _onClockJumpDetected,
    );
    _boundaryTimer = WindowBoundaryTimer(now: _now, onBoundaryTick: _onBoundaryTick);
  }

  /// Cancels timers. Must be called when the owning object is disposed.
  void dispose() {
    _clockJumpDetector.dispose();
    _boundaryTimer.dispose();
  }

  void start() {
    _boundaryTimer.scheduleNext();
  }

  /// Clears all window state without affecting the scheduler timer.
  /// Useful when the user resets the counting session.
  void reset() {
    _clockJumpDetector.reset();
    _windowStartLocal = null;
  }

  /// Called when the video source (re)starts.
  ///
  /// This is a lifecycle signal, but its effect is intentionally idempotent:
  /// it just ensures there is an active window for the current wall-clock time.
  void onSourceStarted() {
    ensureWindowActive();
  }

  /// Ensures there is an active counting window for the current wall-clock time.
  ///
  /// The notifier uses this from frame processing so windows are opened lazily
  /// even if the first frame arrives after a reset or other local state change.
  /// This complements [WindowBoundaryTimer] rather than replacing it: the timer
  /// proactively rolls windows at 5-minute boundaries, while this method lets
  /// the first frame after a reset, delayed timer tick, or event-loop stall
  /// synchronize the active window immediately to the current wall clock.
  /// Coverage loss since this window opened is reported as `missingDuration`
  /// in [onWindowStart].
  void ensureWindowActive() {
    _ensureWindow(_now());
  }

  /// Debug-only helper that forces the current window to close immediately.
  ///
  /// Calls [onWindowEnd] if a window is active, then clears the active window
  /// state so the caller can reopen a fresh window via [ensureWindowActive].
  void debugForceWindowEnd() {
    if (_windowStartLocal == null || _windowEndLocal == null) return;
    onWindowEnd(_windowStartLocal!.toUtc(), _windowStartLocal!, getMissingAtStart(_now()));
    _windowStartLocal = null;
  }

  // Private — window management

  /// Opens a new window if [now] falls outside the current window (or no window
  /// is open). Snaps the start time to the nearest 5-minute boundary and
  /// computes [missingAtStart] as `now − windowStart` (coverage loss at
  /// the start of the new window).
  void _ensureWindow(DateTime now) {
    if (_windowStartLocal == null ||
        now.isBefore(_windowStartLocal!) ||
        now.isAfter(_windowEndLocal!) ||
        now.isAtSameMomentAs(_windowEndLocal!)) {
      if (_windowStartLocal != null) {
        onWindowEnd(_windowStartLocal!.toUtc(), _windowStartLocal!, getMissingAtStart(now));
      }
      // Store as local time to maintain the invariant that _windowStartLocal is always local
      _windowStartLocal = createStartLocal(now);
      onWindowStart(_windowStartLocal!.toUtc(), _windowStartLocal!, getMissingAtStart(now));
    }
  }

  Duration getMissingAtStart(DateTime now) {
    if (_windowStartLocal == null) {
      return Duration.zero;
    }
    final gap = now.difference(_windowStartLocal!);
    if (gap > _partialWindowTolerance) {
      return gap;
    }
    return Duration.zero;
  }

  /// Callback fired by [ClockJumpDetector] when a wall/monotonic divergence
  /// exceeds [_clockJumpThreshold]. Rolls the window forward from [now] so
  /// counting can continue without losing the data already in the active window.
  void _onClockJumpDetected(DateTime now) {
    _ensureWindow(now);
  }

  /// Callback fired at each 5-minute wall-clock boundary. Reports accumulated
  /// missing duration for any active warning and rolls the window forward.
  void _onBoundaryTick() {
    _ensureWindow(_now());
  }

  static DateTime createStartLocal(DateTime now) {
    final local = now.toLocal();
    final minute = local.minute - (local.minute % 5);
    return DateTime(local.year, local.month, local.day, local.hour, minute);
  }
}
