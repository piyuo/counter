import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation.dart';
import 'observation_granularity.dart';
import 'observation_time_query.dart';

/// 5-minute observations of ONE business day.
///
/// Invariants (enforced by every constructor and mutator):
/// - every item has granularity [ObservationGranularity.minutes5]
/// - every item is aligned to a 5-minute slot (hour 0-23, minute 0,5,...,55)
/// - at most one item per slot; the first one added wins (see "Time basis
///   and DST" in observation.dart)
/// - items are sorted ascending by clock time (hour, then minute)
///
/// Together these cap the series at [maxLength] (288) items.
///
/// The series does not know its date; the owning DaySummary is responsible
/// for only adding observations from that date.
@immutable
final class ObservationSeries with IterableMixin<Observation> {
  const ObservationSeries._(this._items);

  /// 24 hours * 12 five-minute slots.
  static const int maxLength = 288;

  static const ObservationSeries empty = ObservationSeries._([]);

  /// Builds a valid series from arbitrary input: the first occurrence of a
  /// slot wins, and the result is sorted. Throws [ArgumentError] on an
  /// invalid observation.
  factory ObservationSeries.fromObservations(Iterable<Observation> source) {
    final bySlot = <int, Observation>{};
    for (final o in source) {
      _validate(o);
      bySlot.putIfAbsent(_slot(o), () => o);
    }
    final items = bySlot.values.toList()..sort((a, b) => _slot(a).compareTo(_slot(b)));
    return ObservationSeries._(List.unmodifiable(items));
  }

  final List<Observation> _items;

  // ---- read ----

  @override
  Iterator<Observation> get iterator => _items.iterator;

  @override
  int get length => _items.length;

  @override
  bool get isEmpty => _items.isEmpty;

  @override
  bool get isNotEmpty => _items.isNotEmpty;

  /// Read-only view, sorted by clock time.
  List<Observation> get items => UnmodifiableListView(_items);

  /// The observation at exactly [hour]:[minute], or null.
  Observation? at(int hour, int minute) {
    final slot = hour * 60 + minute;
    return _items.firstWhereOrNull((o) => _slot(o) == slot);
  }

  /// Observations within [query], inclusive on both ends, in clock order.
  /// If `from` is after `to`, the range wraps past midnight
  /// (e.g. 22:00 -> 02:00).
  List<Observation> find(ObservationTimeQuery query) {
    final from = query.from.hour * 60 + query.from.minute;
    final to = query.to.hour * 60 + query.to.minute;

    return _items.where((o) {
      final m = _slot(o);
      return from <= to ? (m >= from && m <= to) : (m >= from || m <= to);
    }).toList();
  }

  // ---- write (return new instances) ----

  /// Returns a series including [observation]. If its slot is already
  /// occupied, the existing one is kept (first saved wins) and `this` is
  /// returned.
  ObservationSeries add(Observation observation) {
    _validate(observation);
    if (at(observation.hour, observation.minute) != null) return this;
    return ObservationSeries.fromObservations([..._items, observation]);
  }

  /// Returns a series without the observation at [hour]:[minute]
  /// (`this` if there is none).
  ObservationSeries remove(int hour, int minute) {
    final slot = hour * 60 + minute;
    if (!_items.any((o) => _slot(o) == slot)) return this;
    return ObservationSeries._(List.unmodifiable(_items.where((o) => _slot(o) != slot)));
  }

  // ---- internals ----

  static int _slot(Observation o) => o.hour * 60 + o.minute;

  static void _validate(Observation o) {
    if (o.granularity != ObservationGranularity.minutes5) {
      throw ArgumentError.value(o.granularity, 'observation', 'Only minutes5 observations are allowed');
    }
    if (o.hour < 0 || o.hour > 23 || o.minute < 0 || o.minute > 55 || o.minute % 5 != 0) {
      throw ArgumentError.value(
        '${o.hour}:${o.minute}',
        'observation',
        'Must be aligned to a 5-minute slot (hour 0-23, minute 0,5,...,55)',
      );
    }
  }

  // Needed so Freezed's DaySummary equality keeps working.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObservationSeries && const ListEquality<Observation>().equals(_items, other._items);

  @override
  int get hashCode => const ListEquality<Observation>().hash(_items);

  @override
  String toString() => 'ObservationSeries(${_items.length})';
}

/// Lets json_serializable keep reading/writing a plain JSON array.
class ObservationSeriesConverter implements JsonConverter<ObservationSeries, List<dynamic>> {
  const ObservationSeriesConverter();

  @override
  ObservationSeries fromJson(List<dynamic> json) =>
      ObservationSeries.fromObservations(json.map((e) => Observation.fromJson(e as Map<String, dynamic>)));

  @override
  List<dynamic> toJson(ObservationSeries series) => series.items.map((o) => o.toJson()).toList();
}
