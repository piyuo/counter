// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window_count_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
/// - Emits live [WindowCountState] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [CountWindowAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [CountWindowAggregator.snapshot()] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [CountWindowAggregator.StateMetrics] maintains sample-average occupancy
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - [areaContains] inverse-rotates points before testing containment

@ProviderFor(WindowCountNotifier)
final windowCountProvider = WindowCountNotifierProvider._();

/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
/// - Emits live [WindowCountState] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [CountWindowAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [CountWindowAggregator.snapshot()] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [CountWindowAggregator.StateMetrics] maintains sample-average occupancy
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - [areaContains] inverse-rotates points before testing containment
final class WindowCountNotifierProvider
    extends $NotifierProvider<WindowCountNotifier, WindowCountState> {
  /// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
  ///
  /// **Responsibilities:**
  /// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
  /// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
  /// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
  /// - Emits live [WindowCountState] snapshots (throttled to 1/sec) on every frame
  /// - Emits finalized window snapshots on [snapshots] when windows close
  ///
  /// **Data Flow:**
  /// 1. [processFrame] receives tracked objects and areas
  /// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
  /// 3. Rotation is applied to normalize object centers to screen coordinates
  /// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
  /// 5. Occupancy/dwell samples are accumulated in [CountWindowAggregator]
  /// 6. Live state is broadcast (throttled to 1/sec)
  /// 7. On window close, [CountWindowAggregator.snapshot()] is emitted on [snapshots]
  ///
  /// **Occupancy Averaging:**
  /// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
  /// - [CountWindowAggregator.StateMetrics] maintains sample-average occupancy
  /// - Missing gaps still affect coverage via [FrameGapTracker]
  ///
  /// **Rotation Handling:**
  /// - AI models report tracked object centers in the *rotated image* space
  /// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
  /// - [areaContains] inverse-rotates points before testing containment
  WindowCountNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'windowCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$windowCountNotifierHash();

  @$internal
  @override
  WindowCountNotifier create() => WindowCountNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WindowCountState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WindowCountState>(value),
    );
  }
}

String _$windowCountNotifierHash() =>
    r'59c91f0079b302a41b57ec9a082c098bfa69bacb';

/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
/// - Emits live [WindowCountState] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [CountWindowAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [CountWindowAggregator.snapshot()] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [CountWindowAggregator.StateMetrics] maintains sample-average occupancy
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - [areaContains] inverse-rotates points before testing containment

abstract class _$WindowCountNotifier extends $Notifier<WindowCountState> {
  WindowCountState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<WindowCountState, WindowCountState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<WindowCountState, WindowCountState>,
        WindowCountState,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
