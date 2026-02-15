import 'dart:async';

import 'package:core_domain/state/models/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_state_repository.dart';

part 'app_notifier.g.dart';

abstract class AppController {}

@riverpod
class AppNotifier extends _$AppNotifier implements AppController {
  late final AppStateRepository repo;

  @override
  Future<AppState> build() async {
    repo = ref.read(appStateRepositoryProvider);
    final loaded = await repo.load();
    return loaded;
  }
}
