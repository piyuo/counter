import 'package:core_domain/model/observation.dart';
import 'package:core_domain/telemetry/models/delivery_groups.dart';
import 'package:core_domain/telemetry/models/queued_observation.dart';
import 'package:flutter_test/flutter_test.dart';

QueuedObservation _pending(DateTime localEnd, {bool delivered = false}) {
  final endUtc = localEnd.toUtc();
  final startUtc = localEnd.subtract(const Duration(minutes: 10)).toUtc();
  final startBusiness = localEnd.subtract(const Duration(minutes: 10));

  return QueuedObservation(
    observation: Observation(
      granularity: ObservationGranularity.minutes5,
      year: startBusiness.year,
      month: startBusiness.month,
      day: startBusiness.day,
      hour: startBusiness.hour,
      minute: startBusiness.minute,
      frameCount: 100,
      confidenceRatioSum: 0.9,
      confidenceSampleCount: 1,
      confidenceRatio: 0.9,
      coveredSeconds: 300,
      expectedSeconds: 300,
      coverageRatio: 1,
      areas: const [],
    ),
    createdAtUtc: startUtc,
    uploadedAtUtc: delivered ? endUtc : null,
  );
}

void main() {
  group('DeliveryHourGroup.isCurrent', () {
    test('is true only for the current local hour', () {
      final now = DateTime.now();
      final previousHour = now.subtract(const Duration(hours: 1));

      final current = DeliveryHourGroup(
        year: now.year,
        month: now.month,
        day: now.day,
        hour: now.hour,
        payloads: const [],
      );
      final previous = DeliveryHourGroup(
        year: previousHour.year,
        month: previousHour.month,
        day: previousHour.day,
        hour: previousHour.hour,
        payloads: const [],
      );

      expect(current.isCurrent, isTrue);
      expect(previous.isCurrent, isFalse);
    });
  });

  group('DeliveryHourGroup counters', () {
    test('exposes deliveredCount and totalCount from payloads', () {
      final hourGroup = DeliveryHourGroup(
        year: 2026,
        month: 1,
        day: 2,
        hour: 11,
        payloads: [
          _pending(DateTime(2026, 1, 2, 10, 5), delivered: true),
          _pending(DateTime(2026, 1, 2, 10, 15), delivered: false),
          _pending(DateTime(2026, 1, 2, 10, 25), delivered: true),
        ],
      );

      expect(hourGroup.deliveredCount, 2);
      expect(hourGroup.totalCount, 3);
      expect(hourGroup.deliveryStatus, DeliveryStatus.partiallyDelivered);
    });
  });

  group('DeliveryDateGroup counters and status', () {
    test('aggregates deliveredCount and totalCount from hour groups', () {
      final dateGroup = DeliveryDateGroup(
        year: 2026,
        month: 1,
        day: 2,
        hours: [
          DeliveryHourGroup(
            year: 2026,
            month: 1,
            day: 2,
            hour: 10,
            payloads: [
              _pending(DateTime(2026, 1, 2, 9, 5), delivered: true),
              _pending(DateTime(2026, 1, 2, 9, 25), delivered: false),
            ],
          ),
          DeliveryHourGroup(
            year: 2026,
            month: 1,
            day: 2,
            hour: 11,
            payloads: [_pending(DateTime(2026, 1, 2, 10, 5), delivered: true)],
          ),
        ],
      );

      expect(dateGroup.deliveredCount, 2);
      expect(dateGroup.totalCount, 3);
      expect(dateGroup.totalPayloadCount, 3);
      expect(dateGroup.deliveryStatus, DeliveryStatus.partiallyDelivered);
    });

    test('returns allDelivered when all day payloads are delivered', () {
      final dateGroup = DeliveryDateGroup(
        year: 2026,
        month: 1,
        day: 2,
        hours: [
          DeliveryHourGroup(
            year: 2026,
            month: 1,
            day: 2,
            hour: 10,
            payloads: [_pending(DateTime(2026, 1, 2, 9, 5), delivered: true)],
          ),
        ],
      );

      expect(dateGroup.deliveryStatus, DeliveryStatus.allDelivered);
    });

    test('returns noneDelivered when no day payloads are delivered', () {
      final dateGroup = DeliveryDateGroup(
        year: 2026,
        month: 1,
        day: 2,
        hours: [
          DeliveryHourGroup(
            year: 2026,
            month: 1,
            day: 2,
            hour: 10,
            payloads: [_pending(DateTime(2026, 1, 2, 9, 5), delivered: false)],
          ),
        ],
      );

      expect(dateGroup.deliveryStatus, DeliveryStatus.noneDelivered);
    });

    test('isCurrent is true only for current local day', () {
      final now = DateTime.now();
      final currentDay = DateTime(now.year, now.month, now.day);
      final previousDay = currentDay.subtract(const Duration(days: 1));

      final current = DeliveryDateGroup(
        year: currentDay.year,
        month: currentDay.month,
        day: currentDay.day,
        hours: const [],
      );
      final previous = DeliveryDateGroup(
        year: previousDay.year,
        month: previousDay.month,
        day: previousDay.day,
        hours: const [],
      );

      expect(current.isCurrent, isTrue);
      expect(previous.isCurrent, isFalse);
    });
  });

  group('grouping helpers', () {
    test('groupByStartHour uses business date/time and sorts payloads by time asc', () {
      final p1 = _pending(DateTime(2026, 1, 2, 10, 15));
      final p2 = _pending(DateTime(2026, 1, 2, 10, 45), delivered: true);
      final p3 = _pending(DateTime(2026, 1, 2, 8, 0), delivered: true);

      final groups = groupByStartHour([p2, p3, p1]);

      expect(groups.length, 2);
      expect(groups.first.hourKey, (year: 2026, month: 1, day: 2, hour: 10));
      expect((groups.first.year, groups.first.month, groups.first.day), (2026, 1, 2));
      expect(groups.first.hour, 10);
      expect(groups.first.payloads.map((p) => p.observation.id).toList(), [p1.observation.id, p2.observation.id]);
      expect(groups.last.hourKey, (year: 2026, month: 1, day: 2, hour: 7));
      expect(groups.last.hour, 7);
    });

    test('groupByDeliveryDate sorts days desc and hours desc within day', () {
      final p1 = _pending(DateTime(2026, 1, 1, 22, 10));
      final p2 = _pending(DateTime(2026, 1, 2, 9, 20));
      final p3 = _pending(DateTime(2026, 1, 2, 6, 5));

      final dateGroups = groupByDeliveryDate([p1, p2, p3]);

      expect(dateGroups.length, 2);
      expect(dateGroups[0].dateKey, (year: 2026, month: 1, day: 2));
      expect((dateGroups[0].year, dateGroups[0].month, dateGroups[0].day), (2026, 1, 2));
      expect(dateGroups[1].dateKey, (year: 2026, month: 1, day: 1));
      expect(dateGroups[0].hours.map((hour) => hour.hourKey).toList(), [
        (year: 2026, month: 1, day: 2, hour: 9),
        (year: 2026, month: 1, day: 2, hour: 5),
      ]);
      expect(dateGroups[0].totalPayloadCount, 2);
    });
  });

  group('lookup helpers', () {
    test('findStartHourGroup returns matching date and hour components', () {
      final p1 = _pending(DateTime(2026, 1, 2, 10, 10));

      final group = findStartHourGroup([p1], year: 2026, month: 1, day: 2, hour: 10);

      expect(group, isNotNull);
      expect(group!.hourKey, (year: 2026, month: 1, day: 2, hour: 10));
    });

    test('findStartHourGroup returns null when the components do not match', () {
      final p1 = _pending(DateTime(2026, 1, 2, 10, 10));

      final group = findStartHourGroup([p1], year: 2026, month: 1, day: 2, hour: 9);

      expect(group, isNull);
    });

    test('findPendingPayloadById returns payload by id', () {
      final p1 = _pending(DateTime(2026, 1, 2, 10, 10));
      final p2 = _pending(DateTime(2026, 1, 2, 10, 20));

      expect(findPendingPayloadById([p1, p2], p2.observation.id.toString())?.observation.id, p2.observation.id);
      expect(findPendingPayloadById([p1, p2], 'missing'), isNull);
    });
  });

  group('selection helpers', () {
    test('collectSelectedPayloads includes selected day and selected hours', () {
      final p1 = _pending(DateTime(2026, 1, 1, 10, 5));
      final p2 = _pending(DateTime(2026, 1, 1, 11, 5));
      final p3 = _pending(DateTime(2026, 1, 2, 9, 5));
      final groups = groupByDeliveryDate([p1, p2, p3]);

      final selected = collectSelectedPayloads(
        groups,
        isDaySelected: (day) => day.year == 2026 && day.month == 1 && day.day == 1,
        isHourSelected: (hour) => hour.year == 2026 && hour.month == 1 && hour.day == 2 && hour.hour == 8,
      );

      expect(selected.map((p) => p.observation.id).toSet(), {p1.observation.id, p2.observation.id, p3.observation.id});
    });

    test('collectSelectedPayloads deduplicates payloads by id', () {
      final p1 = _pending(DateTime(2026, 1, 1, 10, 5));
      final groups = groupByDeliveryDate([p1]);

      final selected = collectSelectedPayloads(
        groups,
        isDaySelected: (day) => day.year == 2026 && day.month == 1 && day.day == 1,
        isHourSelected: (hour) => hour.year == 2026 && hour.month == 1 && hour.day == 1 && hour.hour == 11,
      );

      expect(selected.length, 1);
      expect(selected.first.observation.id, p1.observation.id);
    });
  });

  group('misc helpers', () {
    test('formatSeconds formats short and minute values', () {
      expect(formatSeconds(5), '5s');
      expect(formatSeconds(125), '2:05');
    });

    test('formatMillisAsSeconds rounds to nearest second', () {
      expect(formatMillisAsSeconds(1499), '1s');
      expect(formatMillisAsSeconds(1501), '2s');
    });
  });
}
