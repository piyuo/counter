import 'dart:async';

import 'package:core_runtime/insight/single_entry_future_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'reuses a value for the same key and replaces it for another key',
    () async {
      final cache = SingleEntryFutureCache<String>();
      var loadCount = 0;

      Future<String?> load() async {
        loadCount++;
        return 'value $loadCount';
      }

      expect(await cache.get('first', load), 'value 1');
      expect(await cache.get('first', load), 'value 1');
      expect(loadCount, 1);

      expect(await cache.get('second', load), 'value 2');
      expect(loadCount, 2);
    },
  );

  test('does not let an older completion clear a newer entry', () async {
    final cache = SingleEntryFutureCache<String>();
    final oldLoad = Completer<String?>();

    final oldResult = cache.get('old', () => oldLoad.future);
    expect(await cache.get('new', () async => 'new value'), 'new value');

    oldLoad.complete(null);
    expect(await oldResult, isNull);
    expect(await cache.get('new', () async => 'unexpected'), 'new value');
  });

  test('retries loads that return null or throw', () async {
    final cache = SingleEntryFutureCache<String>();
    var nullLoadCount = 0;

    Future<String?> loadNull() async {
      nullLoadCount++;
      return null;
    }

    expect(await cache.get('key', loadNull), isNull);
    expect(await cache.get('key', loadNull), isNull);
    expect(nullLoadCount, 2);

    await expectLater(
      cache.get('key', () async => throw StateError('failed')),
      throwsStateError,
    );
    expect(await cache.get('key', () async => 'retried'), 'retried');
  });
}
