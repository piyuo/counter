// TOC:
//  - DeliveryHourGroup / DeliveryDateGroup: telemetry delivery grouping models
//  - grouping + lookup helpers for payload start-hour/day views
//  - resend-selection helpers: flatten selected day/hour groups into unique payload rows
//  - payload-id helper: UUID generation for resend payload cloning
//  - duration formatting helpers for payload detail presentation

import 'queued_payload.dart';

enum DeliveryStatus { allDelivered, partiallyDelivered, noneDelivered }

/// Payloads grouped into one start-hour slot in local time.
class DeliveryHourGroup {
  const DeliveryHourGroup({required this.startHourLocal, required this.payloads});

  final DateTime startHourLocal;
  final List<QueuedPayload> payloads;

  /// Number of delivered payloads in this slot.
  int get deliveredCount => payloads.where((p) => p.isUploaded).length;

  /// Total payloads in this slot.
  int get totalCount => payloads.length;

  /// Whether this slot represents the current date and hour in local time.
  bool get isCurrent {
    final now = DateTime.now();
    return startHourLocal.year == now.year &&
        startHourLocal.month == now.month &&
        startHourLocal.day == now.day &&
        startHourLocal.hour == now.hour;
  }

  /// The delivery status of all payloads in this slot.
  DeliveryStatus get deliveryStatus {
    if (deliveredCount == totalCount) return DeliveryStatus.allDelivered;
    if (deliveredCount == 0) return DeliveryStatus.noneDelivered;
    return DeliveryStatus.partiallyDelivered;
  }
}

/// A local calendar day containing its hour-level delivery groups.
class DeliveryDateGroup {
  const DeliveryDateGroup({required this.dayLocal, required this.hours});

  final DateTime dayLocal;
  final List<DeliveryHourGroup> hours;

  /// Number of delivered payloads in this day.
  int get deliveredCount => hours.fold(0, (sum, hour) => sum + hour.deliveredCount);

  /// Total payloads in this day.
  int get totalCount => hours.fold(0, (sum, hour) => sum + hour.totalCount);

  /// Whether this group represents the current local calendar day.
  bool get isCurrent {
    final now = DateTime.now();
    return dayLocal.year == now.year && dayLocal.month == now.month && dayLocal.day == now.day;
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
List<DeliveryDateGroup> groupByDeliveryDate(List<QueuedPayload> payloads) {
  final hourGroups = groupByStartHour(payloads);
  final byDay = <DateTime, List<DeliveryHourGroup>>{};

  for (final hour in hourGroups) {
    final day = dayStartLocal(hour.startHourLocal);
    byDay.putIfAbsent(day, () => <DeliveryHourGroup>[]).add(hour);
  }

  return byDay.entries
      .map(
        (entry) => DeliveryDateGroup(
          dayLocal: entry.key,
          hours: [...entry.value]..sort((a, b) => b.startHourLocal.compareTo(a.startHourLocal)),
        ),
      )
      .toList()
    ..sort((a, b) => b.dayLocal.compareTo(a.dayLocal));
}

/// Groups queue payloads by local start-hour slot, sorted newest slot first.
///
/// Payloads inside a slot are sorted by `payload.startUtc` ascending.
List<DeliveryHourGroup> groupByStartHour(List<QueuedPayload> payloads) {
  final buckets = <DateTime, List<QueuedPayload>>{};
  for (final pendingPayload in payloads) {
    final slot = startHourSlotLocal(pendingPayload.payload.startUtc);
    buckets.putIfAbsent(slot, () => <QueuedPayload>[]).add(pendingPayload);
  }

  return buckets.entries
      .map(
        (entry) => DeliveryHourGroup(
          startHourLocal: entry.key,
          payloads: [...entry.value]..sort((a, b) => a.payload.startUtc.compareTo(b.payload.startUtc)),
        ),
      )
      .toList()
    ..sort((a, b) => b.startHourLocal.compareTo(a.startHourLocal));
}

/// Converts a UTC start timestamp to its local start-hour slot.
DateTime startHourSlotLocal(DateTime utcTime) {
  final local = utcTime.toLocal();
  return DateTime(local.year, local.month, local.day, local.hour);
}

/// Converts an observation end UTC timestamp to its local end-hour slot.
///
/// Exact hour timestamps stay in the same hour; otherwise they roll to next hour.
DateTime endHourSlotLocal(DateTime utcTime) {
  final local = utcTime.toLocal();
  final floor = DateTime(local.year, local.month, local.day, local.hour);
  final isExactHour = local.minute == 0 && local.second == 0 && local.millisecond == 0 && local.microsecond == 0;
  return isExactHour ? floor : floor.add(const Duration(hours: 1));
}

/// Finds the start-hour group matching [slotMs], or null if not present.
DeliveryHourGroup? findStartHourGroupBySlotMs(List<QueuedPayload> payloads, int slotMs) {
  for (final group in groupByStartHour(payloads)) {
    if (group.startHourLocal.millisecondsSinceEpoch == slotMs) return group;
  }
  return null;
}

/// Finds one pending payload by [payloadId], or null when missing.
QueuedPayload? findPendingPayloadById(List<QueuedPayload> payloads, String payloadId) {
  for (final pendingPayload in payloads) {
    if (pendingPayload.id == payloadId) return pendingPayload;
  }
  return null;
}

/// Flattens selected day/hour groups into unique payload rows.
///
/// Day selections include all hour rows for that day; otherwise selected hours
/// are included individually. Rows are deduplicated by payload ID.
List<QueuedPayload> collectSelectedPayloads(
  List<DeliveryDateGroup> dateGroups, {
  required bool Function(DateTime dayLocal) isDaySelected,
  required bool Function(DateTime hourLocal) isHourSelected,
}) {
  final byPayloadId = <String, QueuedPayload>{};

  for (final day in dateGroups) {
    if (isDaySelected(day.dayLocal)) {
      for (final hour in day.hours) {
        for (final payload in hour.payloads) {
          byPayloadId[payload.id] = payload;
        }
      }
      continue;
    }

    for (final hour in day.hours) {
      if (!isHourSelected(hour.startHourLocal)) continue;
      for (final payload in hour.payloads) {
        byPayloadId[payload.id] = payload;
      }
    }
  }

  return byPayloadId.values.toList();
}

/// Returns the local calendar-day boundary (00:00) for [localTime].
DateTime dayStartLocal(DateTime localTime) => DateTime(localTime.year, localTime.month, localTime.day);

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
