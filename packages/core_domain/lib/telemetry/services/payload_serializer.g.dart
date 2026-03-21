// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_serializer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(payloadSerializer)
final payloadSerializerProvider = PayloadSerializerProvider._();

final class PayloadSerializerProvider
    extends
        $FunctionalProvider<
          PayloadSerializer,
          PayloadSerializer,
          PayloadSerializer
        >
    with $Provider<PayloadSerializer> {
  PayloadSerializerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'payloadSerializerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$payloadSerializerHash();

  @$internal
  @override
  $ProviderElement<PayloadSerializer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PayloadSerializer create(Ref ref) {
    return payloadSerializer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PayloadSerializer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PayloadSerializer>(value),
    );
  }
}

String _$payloadSerializerHash() => r'cf607cb988da9849af04713a8a792f9ba56c74f8';
