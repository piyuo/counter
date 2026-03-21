import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'url_validator_service.g.dart';

abstract class UrlValidatorService {
  /// Validates [url] by checking its format and then attempting a connectivity check.
  ///
  /// Returns `null` when the URL passes all checks, or a human-readable error
  /// message suitable for display directly in the UI.
  Future<String?> validate(String url);
}

@riverpod
UrlValidatorService urlValidatorService(Ref ref) {
  throw UnimplementedError('urlValidatorServiceProvider must be overridden');
}
