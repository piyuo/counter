// Model: AppRuntimeState
// Description: Transient runtime flags for the current app session. Not persisted — reset on every cold start.
// Fields:
//   - developMode       : bool — enabled by tapping App Version 10 times in About
//   - businessBearerToken : String? — business backend auth token hydrated from secure storage

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_runtime_state.freezed.dart';

@freezed
sealed class AppRuntimeState with _$AppRuntimeState {
  /// click App Version in About screen 10 times to enable develop mode
  const factory AppRuntimeState({@Default(false) bool developMode, String? businessBearerToken}) = _AppRuntimeState;
}
