import 'package:freezed_annotation/freezed_annotation.dart';

import 'backend.dart';
import 'frontend.dart';
import 'setup_by.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
sealed class AppState with _$AppState {
  const factory AppState({
    @Default(Backend.empty()) Backend backend,
    @Default(Frontend.empty()) Frontend frontend,
    @Default(SetupBy.empty()) SetupBy setupBy,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
}
