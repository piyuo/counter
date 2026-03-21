// Model: DataServer (sealed union)
// Description: Where the app sends its telemetry. JSON-serialisable; persisted in AppState.
// Variants:
//   - DataServer.unspecified()       — default before setup
//   - DataServer.business({url,...}) — invitation-configured business endpoint metadata
//   - DataServer.personal({url})     — user-supplied or Piyuo cloud personal URL
//   - DataServer.none()              — explicitly opted out
// Helpers:
//   - hasMadeDecision : bool  — true when not unspecified

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_server.freezed.dart';
part 'data_server.g.dart';

@freezed
sealed class DataServer with _$DataServer {
  const DataServer._();

  const factory DataServer.unspecified() = UnspecifiedDataServer;

  // business endpoint, must setup by invitation.
  // url example: https://piyuo.com/api/v1
  // projectId and assignedId are used for business Piyuo to identify the project and device.
  const factory DataServer.business({
    required String url, // where to send data, e.g. https://piyuo.com/api/v1
    required String projectName, // for display only, e.g. "My First Store"
    required String projectId, // for business Piyuo to identify the project, e.g. "1234-1234-1234-1234"
    required String assignedId, // for business Piyuo to identify the device, e.g. "abcd-1234-abcd-5678"
  }) = BusinessDataServer;

  // personal endpoint, setup by user
  // url example: https://piyuo.com/api/asowhuissaw
  // personal Piyuo only rely on the url to identify the server, no projectId or assignedId needed.
  const factory DataServer.personal({
    required String url, // where to send data, e.g. https://piyuo.com/api/v1/asowhuissaw
  }) = PersonalDataServer;

  const factory DataServer.none() = NoDataServer;

  factory DataServer.fromJson(Map<String, dynamic> json) => _$DataServerFromJson(json);

  bool get hasMadeDecision => this is! UnspecifiedDataServer;

  bool get needsBearerToken => this is BusinessDataServer;

  bool get isPiyuo => switch (this) {
    BusinessDataServer(:final url) => url.contains('piyuo.com'),
    PersonalDataServer(:final url) => url.contains('piyuo.com'),
    _ => false,
  };

  /// Returns the server URL string, or empty string for [DataServer.unspecified] and [DataServer.none].
  String get url => switch (this) {
    BusinessDataServer(:final url) => url,
    PersonalDataServer(:final url) => url,
    _ => '',
  };
}
