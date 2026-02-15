import 'package:freezed_annotation/freezed_annotation.dart';

import 'backend.dart';
import 'frontend.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
sealed class AppState with _$AppState {
  const factory AppState({@Default(Backend.empty()) Backend backend, @Default(Frontend.empty()) Frontend frontend}) =
      _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
}
