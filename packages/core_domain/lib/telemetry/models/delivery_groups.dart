// TOC:
//  - DeliveryHourGroup / DeliveryDateGroup: telemetry delivery grouping models
//  - grouping + lookup helpers for payload start-hour/day views
//  - resend-selection helpers: flatten selected day/hour groups into unique payload rows
//  - payload-id helper: UUID generation for resend payload cloning
//  - duration formatting helpers for payload detail presentation

import 'queued_observation.dart';

enum DeliveryStatus { allDelivered, partiallyDelivered, noneDelivered }

typedef DeliveryDateKey = ({int year, int month, int day});
typedef DeliveryHourKey = ({int year, int month, int day, int hour});

/// Payloads grouped into one business-local date and hour.
class DeliveryHourGroup {
  const DeliveryHourGroup({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.payloads,
  });

  final int year;
  final int month;
  final int day;
  final int hour;

  DeliveryHourKey get hourKey => (year: year, month: month, day: day, hour: hour);

  DateTime get datetime => DateTime(year, month, day, hour);

  final List<QueuedObservation> payloads;

  /// Number of delivered payloads in this slot.
  int get deliveredCount => payloads.where((p) => p.isUploaded).length;

  /// Total payloads in this slot.
  int get totalCount => payloads.length;

  /// Whether this slot represents the current date and hour in local time.
  bool get isCurrent {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day && hour == now.hour;
  }

  /// The delivery status of all payloads in this slot.
  DeliveryStatus get deliveryStatus {
    if (deliveredCount == totalCount) return DeliveryStatus.allDelivered;
    if (deliveredCount == 0) return DeliveryStatus.noneDelivered;
    return DeliveryStatus.partiallyDelivered;
  }
}

/// A business-local calendar day containing its hour-level delivery groups.
class DeliveryDateGroup {
  const DeliveryDateGroup({required this.year, required this.month, required this.day, required this.hours});

  final int year;
  final int month;
  final int day;
  final List<DeliveryHourGroup> hours;

  DeliveryDateKey get dateKey => (year: year, month: month, day: day);

  DateTime get datetime => DateTime(year, month, day);

  /// Number of delivered payloads in this day.
  int get deliveredCount => hours.fold(0, (sum, hour) => sum + hour.deliveredCount);

  /// Total payloads in this day.
  int get totalCount => hours.fold(0, (sum, hour) => sum + hour.totalCount);

  /// Whether this group represents the current local calendar day.
  bool get isCurrent {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// The delivery status of all payloads in this day.
  DeliveryStatus get deliveryStatus {
    if (deliveredCount == totalCount) return DeliveryStatus.allDelivered;
    if (deliveredCount == 0) return DeliveryStatus.noneDelivered;
    return DeliveryStatus.partiallyDelivered;
  }

  int get totalPayloadCount => totalCount;
}

/// Groups queue payloads by local delivery day, sorted newest day first.
///
/// Within each day, start-hour groups are sorted newest hour first.
List<DeliveryDateGroup> groupByDeliveryDate(List<QueuedObservation> payloads) {
  final hourGroups = groupByStartHour(payloads);
  final byDate = <DeliveryDateKey, List<DeliveryHourGroup>>{};

  for (final hour in hourGroups) {
    final date = (year: hour.year, month: hour.month, day: hour.day);
    byDate.putIfAbsent(date, () => <DeliveryHourGroup>[]).add(hour);
  }

  return byDate.entries.map((entry) {
    final firstHour = entry.value.first;
    return DeliveryDateGroup(
      year: firstHour.year,
      month: firstHour.month,
      day: firstHour.day,
      hours: [...entry.value]..sort((a, b) => b.hour.compareTo(a.hour)),
    );
  }).toList()..sort((a, b) => DateTime(b.year, b.month, b.day).compareTo(DateTime(a.year, a.month, a.day)));
}

/// Groups queue payloads by local start-hour slot, sorted newest slot first.
///
/// Payloads inside a slot are sorted by their business time ascending.
List<DeliveryHourGroup> groupByStartHour(List<QueuedObservation> payloads) {
  final buckets = <DeliveryHourKey, List<QueuedObservation>>{};
  for (final pendingPayload in payloads) {
    final observation = pendingPayload.observation;
    final hour = (year: observation.year, month: observation.month, day: observation.day, hour: observation.hour);
    buckets.putIfAbsent(hour, () => <QueuedObservation>[]).add(pendingPayload);
  }

  return buckets.entries.map((entry) {
      final observation = entry.value.first.observation;
      return DeliveryHourGroup(
        year: observation.year,
        month: observation.month,
        day: observation.day,
        hour: observation.hour,
        payloads: [...entry.value]..sort((a, b) => a.observation.timeKey.compareTo(b.observation.timeKey)),
      );
    }).toList()
    ..sort((a, b) => DateTime(b.year, b.month, b.day, b.hour).compareTo(DateTime(a.year, a.month, a.day, a.hour)));
}

/// Finds a start-hour group by its business date and hour components.
DeliveryHourGroup? findStartHourGroup(
  List<QueuedObservation> payloads, {
  required int year,
  required int month,
  required int day,
  required int hour,
}) {
  final key = (year: year, month: month, day: day, hour: hour);
  for (final group in groupByStartHour(payloads)) {
    if (group.hourKey == key) return group;
  }
  return null;
}

/// Finds one pending payload by [payloadId], or null when missing.
QueuedObservation? findPendingPayloadById(List<QueuedObservation> payloads, String payloadId) {
  for (final pendingPayload in payloads) {
    if (pendingPayload.observation.id.toString() == payloadId) return pendingPayload;
  }
  return null;
}

/// Flattens selected day/hour groups into unique payload rows.
///
/// Day selections include all hour rows for that day; otherwise selected hours
/// are included individually. Rows are deduplicated by payload ID.
List<QueuedObservation> collectSelectedPayloads(
  List<DeliveryDateGroup> dateGroups, {
  required bool Function(DeliveryDateGroup day) isDaySelected,
  required bool Function(DeliveryHourGroup hour) isHourSelected,
}) {
  final byPayloadId = <int, QueuedObservation>{};

  for (final day in dateGroups) {
    if (isDaySelected(day)) {
      for (final hour in day.hours) {
        for (final payload in hour.payloads) {
          byPayloadId[payload.observation.id] = payload;
        }
      }
      continue;
    }

    for (final hour in day.hours) {
      if (!isHourSelected(hour)) continue;
      for (final payload in hour.payloads) {
        byPayloadId[payload.observation.id] = payload;
      }
    }
  }

  return byPayloadId.values.toList();
}

/// Formats seconds as compact UI text (`Xs` or `M:SS`).
String formatSeconds(int totalSeconds) {
  if (totalSeconds < 60) return '${totalSeconds}s';
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

/// Formats milliseconds as rounded whole-second UI text (`Xs`).
String formatMillisAsSeconds(int millis) {
  final totalSeconds = (millis / 1000).round();
  return '${totalSeconds}s';
}
