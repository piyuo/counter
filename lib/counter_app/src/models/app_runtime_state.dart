import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_runtime_state.freezed.dart';

@freezed
sealed class AppRuntimeState with _$AppRuntimeState {
  const factory AppRuntimeState() = _AppRuntimeState;
}
