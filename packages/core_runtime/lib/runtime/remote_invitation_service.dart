// TOC:
//  - RemoteInvitationService: validates codes and fetches invitation JSON from the remote server

import 'dart:convert';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;

class RemoteInvitationService implements core_domain.InvitationService {
  static const _alphabet = '23456789abcdefghjkmnpqrstuvwxyz';
  static const _codeLength = 10;

  @override
  bool isValidCode(String code) {
    if (code.length != _codeLength) return false;
    final lower = code.toLowerCase();
    return lower.split('').every((c) => _alphabet.contains(c));
  }

  @override
  Future<core_domain.Invitation?> download(String code) async {
    final normalised = code.toLowerCase();
    final uri = Uri.https('piyuo.com', '/invitation/$normalised');

    try {
      final client = HttpClient();
      try {
        final request = await client.getUrl(uri);
        final response = await request.close();

        if (response.statusCode != HttpStatus.ok) return null;

        final body = await response.transform(utf8.decoder).join();
        final json = jsonDecode(body);

        if (json is! Map<String, dynamic>) return null;
        final error = json['error'];
        if (error is String && error.isNotEmpty) {
          return null;
        }

        final invitation = json['invitation'];
        if (invitation is! Map<String, dynamic>) return null;

        return core_domain.Invitation.fromJson(invitation);
      } finally {
        client.close();
      }
    } catch (_) {
      return null;
    }
  }
}
