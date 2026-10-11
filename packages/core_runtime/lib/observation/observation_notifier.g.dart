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
/// - Manages a [ObservationScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [ObservationAggregator]
/// - Emits live [Observation] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [ObservationAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [ObservationAggregator.snapshot] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [StateMetrics] maintains sample-average occupancy
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
/// - Manages a [ObservationScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [ObservationAggregator]
/// - Emits live [Observation] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [ObservationAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [ObservationAggregator.snapshot] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [StateMetrics] maintains sample-average occupancy
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - [areaContains] inverse-rotates points before testing containment
final class ObservationNotifierProvider
    extends $NotifierProvider<ObservationNotifier, core_domain.Observation> {
  /// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
  ///
  /// **Responsibilities:**
  /// - Manages a [ObservationScheduler] that aligns 5-minute counting windows to UTC boundaries
  /// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
  /// - Aggregates per-window occupancy/dwell/flow metrics via [ObservationAggregator]
  /// - Emits live [Observation] snapshots (throttled to 1/sec) on every frame
  /// - Emits finalized window snapshots on [snapshots] when windows close
  ///
  /// **Data Flow:**
  /// 1. [processFrame] receives tracked objects and areas
  /// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
  /// 3. Rotation is applied to normalize object centers to screen coordinates
  /// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
  /// 5. Occupancy/dwell samples are accumulated in [ObservationAggregator]
  /// 6. Live state is broadcast (throttled to 1/sec)
  /// 7. On window close, [ObservationAggregator.snapshot] is emitted on [snapshots]
  ///
  /// **Occupancy Averaging:**
  /// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
  /// - [StateMetrics] maintains sample-average occupancy
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
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$observationNotifierHash();

  @$internal
  @override
  ObservationNotifier create() => ObservationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(core_domain.Observation value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.Observation>(value),
    );
  }
}

String _$observationNotifierHash() =>
    r'6b8a29073331e0a2e44129e5c8ea42660bf183ed';

/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [ObservationScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [ObservationAggregator]
/// - Emits live [Observation] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [ObservationAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [ObservationAggregator.snapshot] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [StateMetrics] maintains sample-average occupancy
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - [areaContains] inverse-rotates points before testing containment

abstract class _$ObservationNotifier
    extends $Notifier<core_domain.Observation> {
  core_domain.Observation build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<core_domain.Observation, core_domain.Observation>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<core_domain.Observation, core_domain.Observation>,
              core_domain.Observation,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
