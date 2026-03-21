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
    required BusinessDataServer businessDataServer,
    required String bearerToken,
    required String deviceName,
    required String instruction,
    required DetectionType detection,
    required DetectionParams detectionParams,
    required UploadConfig deliveryConfig,
  }) = _Invitation;

  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);
}
