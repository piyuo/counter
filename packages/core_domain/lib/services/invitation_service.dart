import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/models/invitation.dart';

export '../state/models/invitation.dart';

part 'invitation_service.g.dart';

abstract class InvitationService {
  /// Returns true if [code] is a syntactically valid invitation code.
  bool isValidCode(String code);

  /// Downloads and parses an invitation for [code].
  ///
  /// Returns an [Invitation] on success, or `null` when the code is not found,
  /// the server is unreachable, or the response is malformed.
  Future<Invitation?> download(String code);
}

@riverpod
InvitationService invitationService(Ref ref) {
  throw UnimplementedError('invitationServiceProvider must be overridden');
}
