// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_panel_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlPanelNotifier)
final controlPanelProvider = ControlPanelNotifierProvider._();

final class ControlPanelNotifierProvider
    extends $NotifierProvider<ControlPanelNotifier, ControlPanelState> {
  ControlPanelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlPanelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlPanelNotifierHash();

  @$internal
  @override
  ControlPanelNotifier create() => ControlPanelNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlPanelState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlPanelState>(value),
    );
  }
}

String _$controlPanelNotifierHash() =>
    r'ec88282e1bf72fcbec3a86aa5bd3b4c4cb103060';

abstract class _$ControlPanelNotifier extends $Notifier<ControlPanelState> {
  ControlPanelState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ControlPanelState, ControlPanelState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlPanelState, ControlPanelState>,
              ControlPanelState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
