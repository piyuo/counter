import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_state.dart';
import 'app_state_repository.dart';

class SharedPrefsAppStateRepository implements AppStateRepository {
  static const _key = 'counter_app_state';

  @override
  Future<AppState> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      return const AppState();
    }

    return AppState.fromJson(jsonDecode(jsonString));
  }

  @override
  Future<void> save(AppState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(state.toJson()));
  }
}

final appStateRepositoryProvider = Provider<AppStateRepository>((ref) {
  return SharedPrefsAppStateRepository();
});
