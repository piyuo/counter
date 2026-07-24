// Model: DataServer (sealed union)
// Description: Where the app sends its telemetry. JSON-serialisable; persisted in AppState.
// Variants:
//   - DataServer.business({url,...}) — invitation-configured business endpoint metadata
//   - DataServer.personal({url,...}) — user-supplied or Piyuo cloud personal URL
//   - DataServer.none()              — explicitly opted out

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_server.freezed.dart';
part 'data_server.g.dart';

enum DataServerSelection { unspecified, noDataServer, personalPiyuo, businessPiyuo, personalCustom, businessCustom }

String getKeyFromDataServerSelection(DataServerSelection selection) {
  switch (selection) {
    case DataServerSelection.unspecified:
      return 'unspecified';
    case DataServerSelection.noDataServer:
      return 'noDataServer';
    case DataServerSelection.personalPiyuo:
      return 'personalPiyuo';
    case DataServerSelection.businessPiyuo:
      return 'businessPiyuo';
    case DataServerSelection.personalCustom:
      return 'personalCustom';
    case DataServerSelection.businessCustom:
      return 'businessCustom';
  }
}

@freezed
sealed class DataServer with _$DataServer {
  const DataServer._();

  // personal piyuo.com endpoint, setup by user
  // url example: https://piyuo.com/api/v1/asowhuissaw
  const factory DataServer.personalPiyuo({
    required String url, // where to send data, e.g. https://piyuo.com/api/v1
  }) = PersonalPiyuoServer;

  // business piyuo.com endpoint, must setup by invitation.user can not change anything.
  // url example: https://piyuo.com/api/v1
  // projectId and assignedId are used for business Piyuo to identify the project and device.
  const factory DataServer.businessPiyuo({
    required String url, // where to send data, e.g. https://piyuo.com/api/v1
    required String projectId, // for business Piyuo to identify the project, e.g. "1234-1234-1234-1234"
    required String projectName, // for display only, e.g. "My First Store"
    required String assignedId, // for business Piyuo to identify the device, e.g. "abcd-1234-abcd-5678"
    required String assignedName,
  }) = BusinessPiyuoServer;

  // custom server endpoint, setup by user.
  // url example: http://localhost:3000
  const factory DataServer.personalCustom({
    required String url, // where to send data, e.g. https://piyuo.com/api/v1
  }) = PersonalCustomServer;

  // business custom server endpoint, setup by invitation. user can not change anything.
  // and projectId and assignedId will be add to url when posting data, so the server can identify the project and device.
  // url example: http://localhost:3000
  const factory DataServer.businessCustom({
    required String url, // where to send data, e.g. https://piyuo.com/api/v1
    required String projectId, // for business Piyuo to identify the project, e.g. "1234-1234-1234-1234"
    required String projectName, // for display only, e.g. "My First Store"
    required String assignedId, // for business Piyuo to identify the device, e.g. "abcd-1234-abcd-5678"
    required String assignedName,
  }) = BusinessCustomServer;

  const factory DataServer.noDataServer() = NoDataServer;

  bool hasBearerToken(DataServer dataServer) {
    return dataServer.map(
      personalPiyuo: (_) => false,
      businessPiyuo: (_) => true,
      personalCustom: (_) => true,
      businessCustom: (_) => true,
      noDataServer: (_) => false,
    );
  }

  factory DataServer.fromJson(Map<String, dynamic> json) => _$DataServerFromJson(json);
}

String? getUrlFromDataServer(DataServer dataServer) {
  if (dataServer is PersonalPiyuoServer) {
    return dataServer.url;
  }
  if (dataServer is PersonalCustomServer) {
    return dataServer.url;
  }
  if (dataServer is BusinessPiyuoServer) {
    return dataServer.url;
  }
  if (dataServer is BusinessCustomServer) {
    return dataServer.url;
  }
  return null;
}

String? getProjectIdFromDataServer(DataServer dataServer) {
  if (dataServer is BusinessPiyuoServer) {
    return dataServer.projectId;
  }
  if (dataServer is BusinessCustomServer) {
    return dataServer.projectId;
  }
  return null;
}

String? getAssignedIdFromDataServer(DataServer dataServer) {
  if (dataServer is BusinessPiyuoServer) {
    return dataServer.assignedId;
  }
  if (dataServer is BusinessCustomServer) {
    return dataServer.assignedId;
  }
  return null;
}
