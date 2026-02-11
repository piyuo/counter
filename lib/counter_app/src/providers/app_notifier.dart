import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/app_state_repository.dart';
import '../data/shared_prefs_repository.dart';
import '../models/app_state.dart';

part 'app_notifier.g.dart';

abstract class AppController {}

@Riverpod(keepAlive: true)
class AppNotifier extends _$AppNotifier implements AppController {
  late final AppStateRepository repo;

  @override
  Future<AppState> build() async {
    repo = ref.read(appStateRepositoryProvider);
    final loaded = await repo.load();
    return loaded;
  }
}
