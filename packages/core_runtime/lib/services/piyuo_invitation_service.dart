// TOC:
//  - RemoteInvitationService: validates codes and fetches invitation JSON from the remote server

import 'package:core_domain/core_domain.dart' as core_domain;

class PiyuoInvitationService implements core_domain.InvitationService {
  static const _alphabet = '23456789abcdefghjkmnpqrstuvwxyz';
  static const _codeLength = 10;

  @override
  bool isValidCode(String code) {
    if (code.length != _codeLength) return false;
    final lower = code.toLowerCase();
    return lower.split('').every((c) => _alphabet.contains(c));
  }

  @override
  @override
  Future<core_domain.InvitationResult> download(String code) async {
    // todo: remote this result for test
    return core_domain.InvitationSuccess(core_domain.createDummyInvitation());
    /*
    final normalised = code.toLowerCase();
    final uri = Uri.https('piyuo.com', '/invitation/$normalised');
    try {
      final client = HttpClient();
      try {
        final request = await client.getUrl(uri);
        final response = await request.close();
        if (response.statusCode != HttpStatus.ok) {
          return const core_domain.InvitationFailure(core_domain.InvitationError.serverError);
        }
        final body = await response.transform(utf8.decoder).join();
        final json = jsonDecode(body);
        if (json is! Map<String, dynamic>) {
          return const core_domain.InvitationFailure(core_domain.InvitationError.invalidFormat);
        }
        final error = json['error'];
        if (error is String && error.isNotEmpty) {
          return core_domain.InvitationFailure(core_domain.InvitationError.serverRejected, serverCode: error);
        }
        final invitation = json['invitation'];
        if (invitation is! Map<String, dynamic>) {
          return const core_domain.InvitationFailure(core_domain.InvitationError.invalidFormat);
        }
        return core_domain.InvitationSuccess(core_domain.Invitation.fromJson(invitation));
      } finally {
        client.close();
      }
    } on SocketException {
      return const core_domain.InvitationFailure(core_domain.InvitationError.networkFailure);
    } on FormatException {
      return const core_domain.InvitationFailure(core_domain.InvitationError.invalidFormat);
    } catch (_) {
      return const core_domain.InvitationFailure(core_domain.InvitationError.unknown);
    }*/
  }
}
