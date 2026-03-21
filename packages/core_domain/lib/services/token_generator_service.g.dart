// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_generator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenGeneratorService)
final tokenGeneratorServiceProvider = TokenGeneratorServiceProvider._();

final class TokenGeneratorServiceProvider
    extends
        $FunctionalProvider<
          TokenGeneratorService,
          TokenGeneratorService,
          TokenGeneratorService
        >
    with $Provider<TokenGeneratorService> {
  TokenGeneratorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenGeneratorServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenGeneratorServiceHash();

  @$internal
  @override
  $ProviderElement<TokenGeneratorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenGeneratorService create(Ref ref) {
    return tokenGeneratorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenGeneratorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenGeneratorService>(value),
    );
  }
}

String _$tokenGeneratorServiceHash() =>
    r'2e0363ffbff25ff965fb6fdd397e5b21e49fa76b';
