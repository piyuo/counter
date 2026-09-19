// TOC
// 1. WindowCountState model
// 2. WindowCountState derived metrics
// 3. Window metrics models

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

const int kGlobalAreaId = 0;

/// Default duration of a counting window.
const kWindowDuration = Duration(minutes: 5);

@immutable
class WindowCountState {
  const WindowCountState({
    required this.startUtc,
    required this.startBusiness,
    required this.session,
    required this.sequence,
    this.missingDuration = Duration.zero,
    this.frameCount = 0,
    this.confidence = 0.0,
    this.areas = const {},
    required this.doneRatio,
    required this.inProgressRatio,
    required this.missingRatio,
    required this.fps,
  });

  /// Beginning of the observation window in UTC.
  ///
  /// This is the canonical timestamp used for synchronization,
  /// upload ordering, and auditing.
  final DateTime startUtc;

  /// End of the observation window in UTC.
  DateTime get endUtc => startUtc.add(kWindowDuration);

  /// Beginning of the same observation window expressed using the
  /// site's business clock.
  ///
  /// This timestamp is used for reports, grouping by business day,
  /// and business-hour analysis.
  final DateTime startBusiness;

  /// Business day derived from [startBusiness].
  ///
  /// Example:
  /// 2026-06-24
  String get businessDate => DateFormat('yyyy-MM-dd').format(startBusiness);

  /// Identifier of the pedestrian counting session this observation window
  /// belongs to.
  ///
  /// Generated from the session's business start time (yyMMddHHmm).
  final String session;

  /// Sequential number of this observation window within the counting session.
  ///
  /// Starts at 1 and increments by one for each 5-minute window.
  final int sequence;

  /// Total number of frames processed in this window.
  final int frameCount;

  /// Per-area metrics for the active 5-minute window.
  final Map<int, AreaMetrics> areas;

  /// Exact total duration of missing input within this window.
  final Duration missingDuration;

  /// Mean confidence (%) across all tracked-object samples in this window.
  final double confidence;

  /// Ratio in [0.0, 1.0] describing how much of this window is done.
  ///
  /// "Done" means elapsed time with valid (non-missing) input.
  /// Computed at window creation time and remains constant.
  final double doneRatio;

  /// Ratio in [0.0, 1.0] describing how much of this window is in progress.
  ///
  /// "In progress" is the future segment while the window is still active.
  /// Computed at window creation time and remains constant.
  final double inProgressRatio;

  /// Ratio in [0.0, 1.0] describing how much of this window is missing.
  ///
  /// "Missing" includes only elapsed missing input, not future time.
  /// Computed at window creation time and remains constant.
  final double missingRatio;

  /// Average processed frames per second over the covered (non-missing) window duration.
  ///
  /// For an active window, the future segment is treated as missing/uncovered time.
  /// Computed at window creation time and remains constant.
  final double fps;

  /// Indicates whether the counting session associated with this window is ready.
  bool get isSessionReady => session.isNotEmpty;

  /// Done percentage in [0.0, 100.0].
  double get donePercent => doneRatio * 100.0;

  /// In-progress percentage in [0.0, 100.0].
  double get inProgressPercent => inProgressRatio * 100.0;

  /// Missing percentage in [0.0, 100.0].
  double get missingPercent => missingRatio * 100.0;

  /// Sum of [donePercent], [inProgressPercent], and [missingPercent].
  ///
  /// This is guaranteed to be 100.0 (within floating-point precision).
  double get progressPercentTotal => donePercent + inProgressPercent + missingPercent;

  WindowCountState copyWith({
    DateTime? startUtc,
    DateTime? startBusiness,
    DateTime? endUtc,
    String? session,
    int? sequence,
    Map<int, AreaMetrics>? areas,
    Duration? missingDuration,
    int? frameCount,
    double? confidence,
    double? doneRatio,
    double? inProgressRatio,
    double? missingRatio,
    double? fps,
  }) {
    return WindowCountState(
      startUtc: startUtc ?? this.startUtc,
      startBusiness: startBusiness ?? this.startBusiness,
      session: session ?? this.session,
      sequence: sequence ?? this.sequence,
      areas: areas ?? this.areas,
      missingDuration: missingDuration ?? this.missingDuration,
      frameCount: frameCount ?? this.frameCount,
      confidence: confidence ?? this.confidence,
      doneRatio: doneRatio ?? this.doneRatio,
      inProgressRatio: inProgressRatio ?? this.inProgressRatio,
      missingRatio: missingRatio ?? this.missingRatio,
      fps: fps ?? this.fps,
    );
  }

  @override
  String toString() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    final startUtcStr = formatter.format(startUtc);
    final startBusinessStr = formatter.format(startBusiness);
    return 'WindowCountState('
        'startUtc: $startUtcStr, '
        'startBusiness: $startBusinessStr, '
        'businessDate: $businessDate, '
        'session: $session, '
        'sequence: $sequence, '
        'missingDuration: ${missingDuration.inSeconds}s, '
        'frameCount: $frameCount, '
        'fps: ${fps.toStringAsFixed(2)}, '
        'confidence: ${confidence.toStringAsFixed(2)}, '
        'areas: {${areas.entries.map((e) {
      final id = e.key == kGlobalAreaId ? 'global' : '${e.key}';
      return '$id(${e.value})';
    }).join(', ')}}'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WindowCountState &&
        other.startUtc == startUtc &&
        other.startBusiness == startBusiness &&
        other.businessDate == businessDate &&
        other.session == session &&
        other.sequence == sequence &&
        other.frameCount == frameCount &&
        mapEquals(other.areas, areas) &&
        other.missingDuration == missingDuration &&
        other.confidence == confidence &&
        other.doneRatio == doneRatio &&
        other.inProgressRatio == inProgressRatio &&
        other.missingRatio == missingRatio &&
        other.fps == fps;
  }

  @override
  int get hashCode {
    final areasHash = Object.hashAllUnordered(
      areas.entries.map((entry) => Object.hash(entry.key, entry.value)),
    );
    return Object.hash(
      startUtc,
      session,
      sequence,
      frameCount,
      areasHash,
      missingDuration,
      confidence,
      doneRatio,
      inProgressRatio,
      missingRatio,
      fps,
    );
  }
}

@immutable
class AreaMetrics {
  final int areaId;

  final String areaName;

  // Flow metrics (movement events)

  /// Unique tracks that made at least one in-area contact in this window.
  ///
  /// This is counted once per track ID on first in-area contact for the
  /// window, regardless of whether the track also contributes to entry/exit.
  final int passBy;

  /// Unique tracks that started outside and were later observed inside.
  ///
  /// This is a one-shot event per track ID within the window.
  final int entry;

  /// Unique tracks that started inside and were later observed outside.
  ///
  /// This is a one-shot event per track ID within the window.
  final int exit;

  /// Objects first detected with center position inside the area.
  final int appear;

  /// Unique tracks that were last seen inside and then disappeared long enough
  /// to satisfy the configured disappear threshold.
  final int disappear;

  /// Unique tracks that remained inside continuously for at least the
  /// configured stay threshold.
  final int stay;

  // Presence metrics (occupancy + dwell)

  /// The most recent per-frame occupancy count for this area.
  ///
  /// This is the last raw occupancy sample observed in the window.
  final int currentOccupancy;

  /// Mean occupancy across discrete frame samples in this window.
  ///
  /// This is a simple arithmetic mean (sum of sampled occupancies / number of
  /// samples), with no time-weighting.
  final double avgOccupancy;

  /// Peak occupancy observed in any sample in this window.
  final int maxOccupancy;

  /// Mean dwell time in seconds across all dwell observations.
  final double avgDwellSec;

  /// max dwell time in rounded seconds.
  final double maxDwellSec;

  const AreaMetrics({
    required this.areaId,
    required this.areaName,
    required this.passBy,
    required this.entry,
    required this.exit,
    this.currentOccupancy = 0,
    this.appear = 0,
    this.disappear = 0,
    this.stay = 0,
    this.avgOccupancy = 0.0,
    this.maxOccupancy = 0,
    this.avgDwellSec = 0.0,
    this.maxDwellSec = 0,
  });

  @override
  String toString() =>
      'AreaMetrics(id:$areaId, name:$areaName, currentOccupancy: $currentOccupancy, passBy: $passBy, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, stay: $stay,  avgOccupancy: ${avgOccupancy.toStringAsFixed(2)}, maxOccupancy: $maxOccupancy, avgDwellSec: ${avgDwellSec.toStringAsFixed(2)}, maxDwellSec: $maxDwellSec)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AreaMetrics &&
        other.currentOccupancy == currentOccupancy &&
        other.passBy == passBy &&
        other.entry == entry &&
        other.exit == exit &&
        other.appear == appear &&
        other.disappear == disappear &&
        other.stay == stay &&
        other.avgOccupancy == avgOccupancy &&
        other.maxOccupancy == maxOccupancy &&
        other.avgDwellSec == avgDwellSec &&
        other.maxDwellSec == maxDwellSec &&
        other.areaId == areaId &&
        other.areaName == areaName;
  }

  @override
  int get hashCode => Object.hash(
        currentOccupancy,
        passBy,
        entry,
        exit,
        appear,
        disappear,
        stay,
        avgOccupancy,
        maxOccupancy,
        avgDwellSec,
        maxDwellSec,
        areaId,
        areaName,
      );
}
