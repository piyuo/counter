// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation_notifier.dart';

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
/// - Emits live [ObservationState] snapshots (throttled to 1/sec) on every frame
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

@ProviderFor(ObservationNotifier)
final observationProvider = ObservationNotifierProvider._();

/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
/// - Emits live [ObservationState] snapshots (throttled to 1/sec) on every frame
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
final class ObservationNotifierProvider
    extends
        $NotifierProvider<ObservationNotifier, core_domain.ObservationState> {
  /// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
  ///
  /// **Responsibilities:**
  /// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
  /// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
  /// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
  /// - Emits live [ObservationState] snapshots (throttled to 1/sec) on every frame
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
  ObservationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'observationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$observationNotifierHash();

  @$internal
  @override
  ObservationNotifier create() => ObservationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(core_domain.ObservationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.ObservationState>(value),
    );
  }
}

String _$observationNotifierHash() =>
    r'7976764bf087dd3b2cfae36973c10605e3149f8e';

/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
/// - Emits live [ObservationState] snapshots (throttled to 1/sec) on every frame
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

abstract class _$ObservationNotifier
    extends $Notifier<core_domain.ObservationState> {
  core_domain.ObservationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<core_domain.ObservationState, core_domain.ObservationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                core_domain.ObservationState,
                core_domain.ObservationState
              >,
              core_domain.ObservationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
