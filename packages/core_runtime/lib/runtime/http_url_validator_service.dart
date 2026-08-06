// TOC:
//  - HttpUrlValidatorService: validates URL format and reachability via HTTP HEAD request

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;

class HttpUrlValidatorService implements core_domain.UrlValidatorService {
  @override
  Future<String?> validate(String url) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return 'Please enter a URL.';
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null || uri.host.isEmpty) {
      return 'The URL format is invalid. Please enter a valid URL (e.g. https://example.com).';
    }

    if (!uri.isScheme('http') && !uri.isScheme('https')) {
      return 'The URL must start with http:// or https://.';
    }
    return null;
    /* do not test the http, for now ,validate only test url format, since we allow user user specific a url even when server is not in place*/
  }
}
