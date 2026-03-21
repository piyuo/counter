import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_generator_service.g.dart';

abstract class TokenGeneratorService {
  /// Generates a short, URL-safe token of [length] characters.
  ///
  /// Uses a custom alphabet of URL-safe characters combined with the current
  /// timestamp and cryptographically-secure random bytes.
  String generate({int length = 12});
}

@riverpod
TokenGeneratorService tokenGeneratorService(Ref ref) {
  throw UnimplementedError('tokenGeneratorServiceProvider must be overridden');
}
