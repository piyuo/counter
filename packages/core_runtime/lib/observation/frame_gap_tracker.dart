// TOC
// 1. FrameGapTracker

const Duration kFrameGapJitterThreshold = Duration(seconds: 3);

/// Tracks elapsed wall-clock time between processed frames.
class FrameGapTracker {
  FrameGapTracker({this.jitterThreshold = kFrameGapJitterThreshold});

  final Duration jitterThreshold;

  DateTime? _lastFrameAt;

  DateTime? get lastFrameAt => _lastFrameAt;

  /// Advances the baseline when [at] is later than the last observed frame.
  ///
  /// Use this when elapsed time has already been charged as missing-at-start.
  void advanceTo(DateTime at) {
    final last = _lastFrameAt;
    if (last != null && at.isAfter(last)) _lastFrameAt = at;
  }

  /// Returns frame elapsed time split by the same jitter policy used by coverage.
  ({DateTime? previousFrameAt, Duration elapsedDuration, Duration validDuration, Duration missingDuration})
  consumeFrameTiming(DateTime now) {
    final previousFrameAt = _lastFrameAt;
    _lastFrameAt = now;

    if (previousFrameAt == null) {
      return (
        previousFrameAt: null,
        elapsedDuration: Duration.zero,
        validDuration: Duration.zero,
        missingDuration: Duration.zero,
      );
    }

    final elapsedDuration = now.difference(previousFrameAt);
    if (elapsedDuration <= Duration.zero) {
      return (
        previousFrameAt: previousFrameAt,
        elapsedDuration: elapsedDuration,
        validDuration: Duration.zero,
        missingDuration: Duration.zero,
      );
    }
    if (elapsedDuration >= jitterThreshold) {
      return (
        previousFrameAt: previousFrameAt,
        elapsedDuration: elapsedDuration,
        validDuration: Duration.zero,
        missingDuration: elapsedDuration,
      );
    }

    return (
      previousFrameAt: previousFrameAt,
      elapsedDuration: elapsedDuration,
      validDuration: elapsedDuration,
      missingDuration: Duration.zero,
    );
  }

  /// Returns the elapsed gap since the last observed frame-like timestamp.
  ///
  /// Tiny gaps are treated as normal jitter and ignored.
  Duration consumeGap(DateTime now, {bool ignoreJitterThreshold = false}) {
    final interval = consumeFrameTiming(now);
    if (interval.previousFrameAt == null) {
      return Duration.zero;
    }
    return ignoreJitterThreshold ? interval.elapsedDuration : interval.missingDuration;
  }

  void reset() {
    _lastFrameAt = null;
  }
}
