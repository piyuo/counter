import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsAppStateRepository implements core_domain.AppStateRepository {
  static const _key = 'counter_app_state';

  @override
  Future<core_domain.AppState> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      return const core_domain.AppState();
    }

    try {
      return core_domain.AppState.fromJson(jsonDecode(jsonString));
    } catch (_) {
      // Stored data is malformed or incompatible with the current schema.
      // Wipe it out and start fresh.
      await reset();
      return const core_domain.AppState();
    }
  }

  @override
  Future<void> save(core_domain.AppState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(state.toJson()));
  }

  @override
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
