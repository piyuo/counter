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
import 'interest_area_data.dart';
import 'upload_config.dart';
import 'video_source.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
sealed class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    /// auto-generated unique device ID, sent to backend as a safety identifier
    @Default('') String deviceId,

    /// if dataServerSelection is unspecified, then app need run onboarding flow to let user select a data server.
    @Default(DataServerSelection.unspecified)
    @JsonKey(unknownEnumValue: DataServerSelection.unspecified)
    DataServerSelection dataServerSelection,

    /// personal subscription plan, use piyuo.com backend, setup by user.
    PersonalPiyuoServer? personalPiyuoServer, // will be assign when first boot, 'https://piyuo.com/api/v1/$random'
    /// personal subscription plan, use their own backend, setup by user.
    PersonalCustomServer? personalCustomServer, // will be assign when first boot, 'http://localhost:3000'
    /// business subscription plan, use piyuo.com backend, setup by invitation.
    BusinessPiyuoServer? businessPiyuoServer, // assign by invitation, e.g. 'https://piyuo.com/api/v1'
    /// business subscription plan, use their own backend, setup by invitation.
    BusinessCustomServer? businessCustomServer, // assign by invitation, e.g. 'http://localhost:3000'
    /// how to upload data to remote server/
    @Default(UploadConfig()) UploadConfig uploadConfig,

    /// Vision input selection.
    ///
    /// Stored as a flat AppState field rather than inside a nested vision-session
    /// object because source, detection, and params can each change independently.
    @Default(VideoSource.unspecified()) @JsonKey(name: 'videoSource') VideoSource videoSource,

    /// Vision model selection paired with [videoSource] and [detectionParams]
    /// to define the desired runtime session.
    @Default(DetectionType.human()) DetectionType detectionType,

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

    /// User-defined interest areas (detection zones).
    ///
    /// Stored as domain models that can be serialized to JSON. At runtime,
    /// these are converted to flutter_vision's InterestArea instances when
    /// configuring the vision session.
    @Default([]) List<InterestAreaData> interestAreas,

    /// Whether track IDs should be visible in the detection output.
    @Default(false) bool isTrackIdVisible,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  /// Returns true if the app has a valid video source configured.
  bool get hasVideoSource => videoSource != VideoSource.unspecified();

  /// Returns true if the app has a valid detection type configured.
  bool get hasDataServerSelectionMade => dataServerSelection != DataServerSelection.unspecified;

  /// Returns true if the app has a valid data server configured.
  bool get hasDataServer => dataServerSelection != DataServerSelection.noDataServer;

  /// Return true if the app has setup not to have a data server, i.e. local device only.
  bool get isLocalDeviceOnly => dataServerSelection == DataServerSelection.noDataServer;

  DataServer? get currentDataServer {
    return switch (dataServerSelection) {
      DataServerSelection.unspecified => null,
      DataServerSelection.noDataServer => const NoDataServer(),
      DataServerSelection.personalPiyuo => personalPiyuoServer,
      DataServerSelection.businessPiyuo => businessPiyuoServer,
      DataServerSelection.personalCustom => personalCustomServer,
      DataServerSelection.businessCustom => businessCustomServer,
    };
  }
}
