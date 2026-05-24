import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/models/invitation.dart';

export '../state/models/invitation.dart';

part 'invitation_service.g.dart';

// in core_domain
sealed class InvitationResult {
  const InvitationResult();
}

class InvitationSuccess extends InvitationResult {
  final Invitation invitation;
  const InvitationSuccess(this.invitation);
}

enum InvitationError {
  networkFailure, // SocketException / no internet
  serverError, // non-200 status
  invalidFormat, // malformed JSON / missing fields
  serverRejected, // server returned { "error": "..." }  ← carries a code
  unknown,
}

class InvitationFailure extends InvitationResult {
  final InvitationError error;
  final String? serverCode; // only set when error == serverRejected
  const InvitationFailure(this.error, {this.serverCode});
}

abstract class InvitationService {
  /// Returns true if [code] is a syntactically valid invitation code.
  bool isValidCode(String code);

  /// Downloads and parses an invitation for [code].
  ///
  /// Returns an [Invitation] on success, or `null` when the code is not found,
  /// the server is unreachable, or the response is malformed.
  Future<InvitationResult> download(String code);
}

@riverpod
InvitationService invitationService(Ref ref) {
  throw UnimplementedError('invitationServiceProvider must be overridden');
}
