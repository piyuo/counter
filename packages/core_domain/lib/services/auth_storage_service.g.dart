// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_storage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authStorageService)
final authStorageServiceProvider = AuthStorageServiceProvider._();

final class AuthStorageServiceProvider
    extends
        $FunctionalProvider<
          AuthStorageService,
          AuthStorageService,
          AuthStorageService
        >
    with $Provider<AuthStorageService> {
  AuthStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStorageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStorageServiceHash();

  @$internal
  @override
  $ProviderElement<AuthStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthStorageService create(Ref ref) {
    return authStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStorageService>(value),
    );
  }
}

String _$authStorageServiceHash() =>
    r'6ae10e671ef612edc2b2d5e93261f1764827034f';
