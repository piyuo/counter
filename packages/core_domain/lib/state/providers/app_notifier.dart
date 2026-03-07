import 'dart:async';

import 'package:core_domain/state/models/app_state.dart';
import 'package:core_domain/state/models/backend.dart';
import 'package:core_domain/state/models/frontend.dart';
import 'package:core_domain/state/models/setup_by.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_state_repository.dart';

part 'app_notifier.g.dart';

abstract class AppController {
  Future<void> setFrontend(Frontend backend);
  Future<void> setup(SetupBy by, Backend backend);
}

@riverpod
class AppNotifier extends _$AppNotifier implements AppController {
  late final AppStateRepository repo;

  @override
  Future<AppState> build() async {
    repo = ref.read(appStateRepositoryProvider);
    final loaded = await repo.load();
    return loaded;
  }

  @override
  Future<void> setFrontend(Frontend frontend) async {
    final current = await future;
    final updated = current.copyWith(frontend: frontend);
    state = AsyncData(updated);
    await repo.save(updated);
  }

  @override
  Future<void> setup(SetupBy by, Backend backend) async {
    final current = await future;
    final updated = current.copyWith(setupBy: by, backend: backend);
    state = AsyncData(updated);
    await repo.save(updated);
  }
}
