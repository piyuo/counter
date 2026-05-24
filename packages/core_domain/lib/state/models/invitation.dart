// Model: Invitation
// Description: Business object returned from the invitation server after a valid code is redeemed.
// Fields:
//   - businessDataServer     : BusinessDataServer — business endpoint metadata from the invitation
//   - afterInviteInstruction : String — onboarding message shown post-invite
//   - deviceToken            : String — auth token for this device
//   - deviceName             : String — human-readable device identifier

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data_server.dart';
import 'detection_params.dart';
import 'detection_type.dart';
import 'upload_config.dart';

part 'invitation.freezed.dart';
part 'invitation.g.dart';

@freezed
abstract class Invitation with _$Invitation {
  const factory Invitation({
    required String instruction,
    required String bearerToken,
    BusinessPiyuoServer? businessPiyuoServer,
    BusinessCustomServer? businessCustomServer,
    DetectionType? detection,
    DetectionParams? detectionParams,
    UploadConfig? uploadConfig,
  }) = _Invitation;

  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);
}

String? getProjectNameFromInvitation(Invitation invitation) {
  if (invitation.businessPiyuoServer != null) {
    return invitation.businessPiyuoServer!.projectName;
  } else if (invitation.businessCustomServer != null) {
    return invitation.businessCustomServer!.projectName;
  } else {
    return null;
  }
}

String? getAssignedNameFromInvitation(Invitation invitation) {
  if (invitation.businessPiyuoServer != null) {
    return invitation.businessPiyuoServer!.assignedName;
  } else if (invitation.businessCustomServer != null) {
    return invitation.businessCustomServer!.assignedName;
  } else {
    return null;
  }
}

Invitation createDummyInvitation({
  String instruction =
      'Mount the device in the designated location and aim the camera toward street traffic for pedestrian counting.',
  BusinessPiyuoServer? businessPiyuoServer,
  BusinessCustomServer? businessCustomServer,
  DetectionType? detection,
  DetectionParams? detectionParams,
  UploadConfig? uploadConfig,
}) {
  return Invitation(
    businessPiyuoServer: const BusinessPiyuoServer(
      url: 'https://piyuo.com/api/v1',
      projectName: 'Demo Project',
      projectId: 'demo-project-id',
      assignedId: 'demo-device-id',
      assignedName: 'phone point to street',
    ),
    bearerToken: 'demo-bearer-token',
    instruction:
        'Mount the device in the designated location and aim the camera toward street traffic for pedestrian counting.',
    detection: detection,
    detectionParams: detectionParams,
    uploadConfig: uploadConfig,
  );
}
