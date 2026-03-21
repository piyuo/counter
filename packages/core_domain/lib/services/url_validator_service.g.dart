// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_validator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(urlValidatorService)
final urlValidatorServiceProvider = UrlValidatorServiceProvider._();

final class UrlValidatorServiceProvider
    extends
        $FunctionalProvider<
          UrlValidatorService,
          UrlValidatorService,
          UrlValidatorService
        >
    with $Provider<UrlValidatorService> {
  UrlValidatorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'urlValidatorServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$urlValidatorServiceHash();

  @$internal
  @override
  $ProviderElement<UrlValidatorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UrlValidatorService create(Ref ref) {
    return urlValidatorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UrlValidatorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UrlValidatorService>(value),
    );
  }
}

String _$urlValidatorServiceHash() =>
    r'736892192b6e644ac6db373b21f6fe344382dbf7';
