// TOC:
// - ResetAppController: use-case for a full app reset back to onboarding
// - resetAppProvider: notifier exposing the reset command

import 'package:core_domain/app_flow/models/app_flow_event.dart';
import 'package:core_domain/app_flow/providers/app_flow_notifier.dart';
import 'package:core_domain/services/auth_storage_service.dart';
import 'package:core_domain/services/vision_service.dart';
import 'package:core_domain/state/providers/app_notifier.dart';
import 'package:core_domain/state/providers/app_runtime_notifier.dart';
import 'package:core_domain/telemetry/services/payload_queue_repository.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_app_notifier.g.dart';

abstract class ResetAppController {
  Future<void> reset();
}

@Riverpod(keepAlive: true)
class ResetAppNotifier extends _$ResetAppNotifier implements ResetAppController {
  @override
  void build() {}

  @override
  Future<void> reset() async {
    // reset device locale to system default
    await ref.read(appkit.localeProvider.notifier).set(null);

    // turn off vision session first
    await ref.read(visionRuntimeServiceProvider).stop();
    await ref.read(appRuntimeProvider.notifier).reset();
    await ref.read(telemetryQueueRepositoryProvider).reset();
    await ref.read(authStorageServiceProvider).reset();
    await ref.read(appProvider.notifier).reset(); // reset state and repo
    ref.read(appFlowProvider.notifier).dispatch(const AppFlowEvent.onboardingNeeded());
  }
}
