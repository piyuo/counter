// TOC:
//  - load returns empty AppState when no data is stored
//  - load returns persisted AppState when valid data exists
//  - load returns empty AppState and wipes key when stored state is malformed or incompatible
//  - save persists AppState as JSON under the expected key
//  - reset removes the stored key

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/runtime/shared_prefs_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedPrefsAppStateRepository', () {
    test('load returns empty AppState when no data is stored', () async {
      final repo = SharedPrefsAppStateRepository();

      final result = await repo.load();

      expect(result, equals(const core_domain.AppState()));
    });

    test('load returns persisted AppState when valid data exists', () async {
      final repo = SharedPrefsAppStateRepository();
      const state = core_domain.AppState();
      await repo.save(state);

      final result = await repo.load();

      expect(result, equals(state));
    });

    test('load returns empty AppState and wipes key when stored state is malformed or incompatible', () async {
      // Simulate malformed persisted data.
      SharedPreferences.setMockInitialValues({'counter_app_state': 'not-json'});
      final repo = SharedPrefsAppStateRepository();

      final result = await repo.load();

      expect(result, equals(const core_domain.AppState()));

      // Key must be wiped so the next load is clean.
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('counter_app_state'), isNull);
    });

    test('save persists AppState as JSON under the expected key', () async {
      final repo = SharedPrefsAppStateRepository();
      const state = core_domain.AppState();

      await repo.save(state);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('counter_app_state'), isNotNull);
    });

    test('reset removes the stored key', () async {
      final repo = SharedPrefsAppStateRepository();
      await repo.save(const core_domain.AppState());

      await repo.reset();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('counter_app_state'), isNull);
    });
  });
}
