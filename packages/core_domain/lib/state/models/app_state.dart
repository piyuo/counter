// Model: AppState
// Description: Persisted configuration snapshot of the app setup. Serialised to/from JSON via shared_preferences.
// Architecture note:
//   Vision session configuration is intentionally stored as three flat AppState fields
//   (videoSource, detection, detectionParams) instead of a nested wrapper object.
//   They are changed independently in the UI and runtime, but together they define
//   the desired vision session that VisionSessionBootstrap/Notifier reconciles.
// Fields:
//   - dataServerSelection      : DataServerSelection — which remembered data-server choice is active
//   - businessDataServer       : BusinessDataServer? — remembered invitation/business server
//   - customPersonalDataServer : PersonalDataServer? — remembered custom personal server
//   - piyuoPersonalDataServer  : PersonalDataServer? — remembered Piyuo Cloud personal server
//   - videoSource      : VideoSource     — vision input selection; together with detection and detectionParams forms the desired vision session
//   - detection        : Detection       — what kind of object to detect; kept flat because it may change independently from source/params
//   - deviceId         : String          — auto-generated unique device ID, sent to backend as a safety identifier
//   - detectionParams  : DetectionParams — tracking/detection tuning parameters; kept flat because tuning changes should not require reshaping AppState
//   - uploadJitterSec  : int             — stable per-device jitter (0–180 s) added to wall-clock upload boundaries; generated once on first boot to prevent thundering herd

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data_server.dart';
import 'detection_params.dart';
import 'detection_type.dart';
import 'upload_config.dart';
import 'video_source.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

enum DataServerSelection { unspecified, none, business, personalCustom, personalPiyuo }

@freezed
sealed class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    /// auto-generated unique device ID, sent to backend as a safety identifier
    @Default('') String deviceId,

    /// Which remembered data-server choice is currently active.
    @Default(DataServerSelection.unspecified)
    @JsonKey(unknownEnumValue: DataServerSelection.unspecified)
    DataServerSelection dataServerSelection,

    /// Last invitation/business server remembered for later reuse.
    BusinessDataServer? businessDataServer,

    /// Last custom personal server remembered for later reuse.
    PersonalDataServer? customPersonalDataServer,

    /// Stable personal Piyuo Cloud server remembered for later reuse.
    PersonalDataServer? piyuoPersonalDataServer,

    /// how to upload data to remote server/
    @Default(UploadConfig()) UploadConfig uploadConfig,

    /// Vision input selection.
    ///
    /// Stored as a flat AppState field rather than inside a nested vision-session
    /// object because source, detection, and params can each change independently.
    @Default(VideoSource.unspecified()) @JsonKey(name: 'videoSource') VideoSource videoSource,

    /// Vision model selection paired with [videoSource] and [detectionParams]
    /// to define the desired runtime session.
    @Default(DetectionType.human()) DetectionType detection,

    /// Runtime tuning paired with [videoSource] and [detection].
    ///
    /// Kept flat in AppState so small parameter edits remain ordinary app-state
    /// updates instead of forcing a wrapper type with weak domain meaning.
    @Default(DetectionParams()) DetectionParams detectionParams,

    /// Stable per-device jitter added to every wall-clock upload boundary.
    ///
    /// Generated once on first boot (range: 0–180 seconds) and never changed.
    /// Spreads simultaneous uploads across a 3-minute window to prevent
    /// thundering herd against the backend (Lambda / DynamoDB).
    ///
    /// A value of 0 means "not yet generated" and triggers auto-generation in
    /// [AppNotifier.build].
    @Default(0) int uploadJitterSec,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  /// Derived view of the currently selected data server.
  DataServer get dataServer => switch (dataServerSelection) {
    DataServerSelection.unspecified => const DataServer.unspecified(),
    DataServerSelection.none => const DataServer.none(),
    DataServerSelection.business => businessDataServer ?? const DataServer.unspecified(),
    DataServerSelection.personalCustom => customPersonalDataServer ?? const DataServer.unspecified(),
    DataServerSelection.personalPiyuo => piyuoPersonalDataServer ?? const DataServer.unspecified(),
  };

  /// Derived view of the last custom personal server URL.
  String get customServerUrl => customPersonalDataServer?.url ?? '';

  /// Derived view of the last Piyuo Cloud personal server URL.
  String get piyuoCloudUrl => piyuoPersonalDataServer?.url ?? '';
}
