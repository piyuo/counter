// TOC
// 1. FrameGapTracker

/// Tracks elapsed wall-clock time between processed frames.
class FrameGapTracker {
  FrameGapTracker({this.jitterThreshold = const Duration(seconds: 3)});

  final Duration jitterThreshold;

  DateTime? _lastFrameAt;

  /// Returns the elapsed gap since the last observed frame-like timestamp.
  ///
  /// Tiny gaps are treated as normal jitter and ignored.
  Duration consumeGap(DateTime now, {bool ignoreJitterThreshold = false}) {
    final lastFrameAt = _lastFrameAt;
    _lastFrameAt = now;

    if (lastFrameAt == null) {
      return Duration.zero;
    }

    final gap = now.difference(lastFrameAt);
    if (!ignoreJitterThreshold && gap < jitterThreshold) {
      return Duration.zero;
    }

    return gap;
  }

  void reset() {
    _lastFrameAt = null;
  }
}
