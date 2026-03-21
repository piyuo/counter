import 'package:core_domain/core_domain.dart';
import 'package:flutter_test/flutter_test.dart';

QueuedPayload _pending(String id, DateTime localEnd, {bool delivered = false}) {
  final endUtc = localEnd.toUtc();
  final startUtc = localEnd.subtract(const Duration(minutes: 10)).toUtc();

  return QueuedPayload(
    id: id,
    payload: TelemetryPayload(
      id: id,
      startUtc: startUtc,
      endUtc: endUtc,
      sessionId: 'session-1',
      windowIndex: 1,
      frameCount: 100,
      missingDurationMs: 0,
      confidence: 0.9,
      isPartial: false,
      coverageRatio: 1.0,
      fps: 10.0,
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
      final currentHour = DateTime(now.year, now.month, now.day, now.hour);

      final current = DeliveryHourGroup(startHourLocal: currentHour, payloads: const []);
      final previous = DeliveryHourGroup(
        startHourLocal: currentHour.subtract(const Duration(hours: 1)),
        payloads: const [],
      );

      expect(current.isCurrent, isTrue);
      expect(previous.isCurrent, isFalse);
    });
  });

  group('DeliveryHourGroup counters', () {
    test('exposes deliveredCount and totalCount from payloads', () {
      final hourGroup = DeliveryHourGroup(
        startHourLocal: DateTime(2026, 1, 2, 11),
        payloads: [
          _pending('p1', DateTime(2026, 1, 2, 10, 5), delivered: true),
          _pending('p2', DateTime(2026, 1, 2, 10, 15), delivered: false),
          _pending('p3', DateTime(2026, 1, 2, 10, 25), delivered: true),
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
        dayLocal: DateTime(2026, 1, 2),
        hours: [
          DeliveryHourGroup(
            startHourLocal: DateTime(2026, 1, 2, 10),
            payloads: [
              _pending('p1', DateTime(2026, 1, 2, 9, 5), delivered: true),
              _pending('p2', DateTime(2026, 1, 2, 9, 25), delivered: false),
            ],
          ),
          DeliveryHourGroup(
            startHourLocal: DateTime(2026, 1, 2, 11),
            payloads: [_pending('p3', DateTime(2026, 1, 2, 10, 5), delivered: true)],
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
        dayLocal: DateTime(2026, 1, 2),
        hours: [
          DeliveryHourGroup(
            startHourLocal: DateTime(2026, 1, 2, 10),
            payloads: [_pending('p1', DateTime(2026, 1, 2, 9, 5), delivered: true)],
          ),
        ],
      );

      expect(dateGroup.deliveryStatus, DeliveryStatus.allDelivered);
    });

    test('returns noneDelivered when no day payloads are delivered', () {
      final dateGroup = DeliveryDateGroup(
        dayLocal: DateTime(2026, 1, 2),
        hours: [
          DeliveryHourGroup(
            startHourLocal: DateTime(2026, 1, 2, 10),
            payloads: [_pending('p1', DateTime(2026, 1, 2, 9, 5), delivered: false)],
          ),
        ],
      );

      expect(dateGroup.deliveryStatus, DeliveryStatus.noneDelivered);
    });

    test('isCurrent is true only for current local day', () {
      final now = DateTime.now();
      final currentDay = DateTime(now.year, now.month, now.day);
      final previousDay = currentDay.subtract(const Duration(days: 1));

      final current = DeliveryDateGroup(dayLocal: currentDay, hours: const []);
      final previous = DeliveryDateGroup(dayLocal: previousDay, hours: const []);

      expect(current.isCurrent, isTrue);
      expect(previous.isCurrent, isFalse);
    });
  });

  group('endHourSlotLocal', () {
    test('keeps exact hour in same slot', () {
      final local = DateTime(2026, 1, 2, 10, 0, 0);
      expect(endHourSlotLocal(local.toUtc()), DateTime(2026, 1, 2, 10));
    });

    test('rounds non-exact time to next hour', () {
      final local = DateTime(2026, 1, 2, 10, 1, 0);
      expect(endHourSlotLocal(local.toUtc()), DateTime(2026, 1, 2, 11));
    });
  });

  group('grouping helpers', () {
    test('groupByStartHour uses startUtc hour and sorts payloads by startUtc asc', () {
      final p1 = _pending('p1', DateTime(2026, 1, 2, 10, 15));
      final p2 = _pending('p2', DateTime(2026, 1, 2, 10, 45), delivered: true);
      final p3 = _pending('p3', DateTime(2026, 1, 2, 8, 0), delivered: true);

      final groups = groupByStartHour([p2, p3, p1]);

      expect(groups.length, 2);
      expect(groups.first.startHourLocal, DateTime(2026, 1, 2, 10));
      expect(groups.first.payloads.map((p) => p.id).toList(), ['p1', 'p2']);
      expect(groups.last.startHourLocal, DateTime(2026, 1, 2, 7));
    });

    test('groupByDeliveryDate sorts days desc and hours desc within day', () {
      final p1 = _pending('p1', DateTime(2026, 1, 1, 22, 10));
      final p2 = _pending('p2', DateTime(2026, 1, 2, 9, 20));
      final p3 = _pending('p3', DateTime(2026, 1, 2, 6, 5));

      final dateGroups = groupByDeliveryDate([p1, p2, p3]);

      expect(dateGroups.length, 2);
      expect(dateGroups[0].dayLocal, DateTime(2026, 1, 2));
      expect(dateGroups[1].dayLocal, DateTime(2026, 1, 1));
      expect(dateGroups[0].hours.map((h) => h.startHourLocal).toList(), [
        DateTime(2026, 1, 2, 9),
        DateTime(2026, 1, 2, 5),
      ]);
      expect(dateGroups[0].totalPayloadCount, 2);
    });
  });

  group('lookup helpers', () {
    test('findStartHourGroupBySlotMs returns matching group', () {
      final p1 = _pending('p1', DateTime(2026, 1, 2, 10, 10));
      final slot = DateTime(2026, 1, 2, 10).millisecondsSinceEpoch;

      final group = findStartHourGroupBySlotMs([p1], slot);

      expect(group, isNotNull);
      expect(group!.startHourLocal, DateTime(2026, 1, 2, 10));
    });

    test('findStartHourGroupBySlotMs returns null when missing', () {
      final p1 = _pending('p1', DateTime(2026, 1, 2, 10, 10));

      final group = findStartHourGroupBySlotMs([p1], DateTime(2026, 1, 2, 9).millisecondsSinceEpoch);

      expect(group, isNull);
    });

    test('findPendingPayloadById returns payload by id', () {
      final p1 = _pending('p1', DateTime(2026, 1, 2, 10, 10));
      final p2 = _pending('p2', DateTime(2026, 1, 2, 10, 20));

      expect(findPendingPayloadById([p1, p2], 'p2')?.id, 'p2');
      expect(findPendingPayloadById([p1, p2], 'missing'), isNull);
    });
  });

  group('selection helpers', () {
    test('collectSelectedPayloads includes selected day and selected hours', () {
      final p1 = _pending('p1', DateTime(2026, 1, 1, 10, 5));
      final p2 = _pending('p2', DateTime(2026, 1, 1, 11, 5));
      final p3 = _pending('p3', DateTime(2026, 1, 2, 9, 5));
      final groups = groupByDeliveryDate([p1, p2, p3]);

      final selected = collectSelectedPayloads(
        groups,
        isDaySelected: (day) => day == DateTime(2026, 1, 1),
        isHourSelected: (hour) => hour == DateTime(2026, 1, 2, 8),
      );

      expect(selected.map((p) => p.id).toSet(), {'p1', 'p2', 'p3'});
    });

    test('collectSelectedPayloads deduplicates payloads by id', () {
      final p1 = _pending('p1', DateTime(2026, 1, 1, 10, 5));
      final groups = groupByDeliveryDate([p1]);

      final selected = collectSelectedPayloads(
        groups,
        isDaySelected: (day) => day == DateTime(2026, 1, 1),
        isHourSelected: (hour) => hour == DateTime(2026, 1, 1, 11),
      );

      expect(selected.length, 1);
      expect(selected.first.id, 'p1');
    });
  });

  group('misc helpers', () {
    test('generateTelemetryPayloadId creates UUID v4-like values', () {
      final a = generateTelemetryPayloadId();
      final b = generateTelemetryPayloadId();

      final pattern = RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$');

      expect(a, matches(pattern));
      expect(b, matches(pattern));
      expect(a, isNot(equals(b)));
    });

    test('dayStartLocal strips time component', () {
      final dt = DateTime(2026, 1, 2, 13, 45, 12);
      expect(dayStartLocal(dt), DateTime(2026, 1, 2));
    });

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
