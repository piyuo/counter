import 'package:core_domain/state/models/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_repository.g.dart';

abstract class AppStateRepository {
  Future<AppState> load();
  Future<void> save(AppState state);
}

@riverpod
AppStateRepository appStateRepository(Ref ref) {
  throw UnimplementedError('appStateRepositoryProvider must be overridden');
}
