// TOC:
// - VisionSessionBootstrap: app-level listener that keeps runtime session aligned with app state

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisionSessionBootstrap extends ConsumerStatefulWidget {
  const VisionSessionBootstrap({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<VisionSessionBootstrap> createState() => _VisionSessionBootstrapState();
}

class _VisionSessionBootstrapState extends ConsumerState<VisionSessionBootstrap> {
  ProviderSubscription<AsyncValue<core_domain.AppState>>? _appSubscription;
  ProviderSubscription<core_domain.AppFlow>? _flowSubscription;
  // Coalesces bursts of provider notifications into a single sync pass.
  bool _syncScheduled = false;

  @override
  void initState() {
    super.initState();
    _appSubscription = ref.listenManual(
      core_domain.appProvider,
      (previous, next) => _scheduleSync(),
      fireImmediately: true,
    );
    _flowSubscription = ref.listenManual(
      core_domain.appFlowProvider,
      (previous, next) => _scheduleSync(),
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _appSubscription?.close();
    _flowSubscription?.close();
    super.dispose();
  }

  void _scheduleSync() {
    if (_syncScheduled) return;
    _syncScheduled = true;
    // Defer the actual sync to the next microtask so appProvider and
    // appFlowProvider can settle first if both changed in the same turn.
    // We intentionally do not await here because this callback is triggered
    // from provider listeners; it should enqueue work and return immediately.
    unawaited(
      Future.microtask(() async {
        _syncScheduled = false;
        if (!mounted) return;

        // Re-read the latest values at execution time so the sync uses the
        // final coalesced app state instead of an intermediate listener value.
        final appState = ref.read(core_domain.appProvider);
        final appFlow = ref.read(core_domain.appFlowProvider);
        final visionSessionController = ref.read(core_domain.visionSessionProvider.notifier);

        if (appFlow is! core_domain.SessionRunning || !appState.hasValue) {
          await visionSessionController.stop();
          return;
        }

        // AppState keeps the vision session as three flat fields on purpose.
        // Reassemble them here only when reconciling the runtime session.
        final currentAppState = appState.requireValue;
        await visionSessionController.reconcile(
          videoSource: currentAppState.videoSource,
          detectionType: currentAppState.detectionType,
          detectionParams: currentAppState.detectionParams,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
