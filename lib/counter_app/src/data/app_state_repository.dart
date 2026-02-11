import '../models/app_state.dart';

abstract class AppStateRepository {
  Future<AppState> load();
  Future<void> save(AppState state);
}
