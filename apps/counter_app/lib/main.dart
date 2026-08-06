import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_shell/app_shell.dart';

void main() async {
  late core_runtime.TelemetryDatabaseFun dbFactory;
  appkit.appRun(
    preInitCallback: () async {
      final appSupportDir = await getApplicationSupportDirectory();
      await appSupportDir.create(recursive: true); // ensure the directory exists before trying to open the DB
      final telemetryDbPath = p.join(appSupportDir.path, 'telemetry.db');
      dbFactory = await core_runtime.TelemetryDatabase.open(filePath: telemetryDbPath);
    },
    ProviderScope(
      //observers: [appkit.riverpodObserver()],
      overrides: [
        core_domain.appStateRepositoryProvider.overrideWith((ref) => core_runtime.SharedPrefsAppStateRepository()),
        core_domain.authStorageServiceProvider.overrideWith((ref) => core_runtime.SecureAuthStorageService()),
        core_domain.hardwareCapabilityServiceProvider.overrideWith((ref) {
          final cameraDeviceController = ref.read(vision.cameraDeviceProvider.notifier);
          return core_runtime.NativeHardwareCapabilityService(cameraDeviceController);
        }),
        core_domain.portraitOrientationServiceProvider.overrideWith(
          (ref) => core_runtime.SystemChromePortraitOrientationService(),
        ),
        core_domain.visionRuntimeServiceProvider.overrideWith(
          (ref) => ref.read(core_runtime.flutterVisionServiceProvider.notifier),
        ),
        core_domain.invitationServiceProvider.overrideWith((ref) => core_runtime.PiyuoInvitationService()),
        core_domain.tokenGeneratorServiceProvider.overrideWith((ref) => core_runtime.RandomTokenGeneratorService()),
        core_domain.urlValidatorServiceProvider.overrideWith((ref) => core_runtime.HttpUrlValidatorService()),
        core_domain.appLinkServiceProvider.overrideWith((ref) {
          final appLinkService = core_runtime.NativeAppLinkService(
            ref.read(core_domain.appFlowProvider.notifier),
            ref.read(core_domain.invitationCodeProvider.notifier),
          );
          unawaited(appLinkService.init());
          return appLinkService;
        }),
        core_domain.telemetryQueueRepositoryProvider.overrideWith((ref) {
          return core_runtime.DriftPayloadQueueRepository(dbFactory);
        }),
        core_domain.telemetryServiceProvider.overrideWith((ref) {
          ref.keepAlive();
          final service = core_runtime.NativeTelemetryService(
            queue: ref.read(core_domain.telemetryQueueRepositoryProvider),
            onServerConfigOverride: ({detectionType, detectionParams, deliveryConfig}) async {
              await ref
                  .read(core_domain.appProvider.notifier)
                  .applyServerConfigOverrides(
                    detectionType: detectionType,
                    detectionParams: detectionParams,
                    deliveryConfig: deliveryConfig,
                  );
            },
            uploadConfigResolver: () async {
              final appState = await ref.read(core_domain.appProvider.future);
              return appState.uploadConfig;
            },
            jitterSecResolver: () async {
              final appState = await ref.read(core_domain.appProvider.future);
              return appState.uploadJitterSec;
            },
            sessionResolver: () async {
              final appState = await ref.read(core_domain.appProvider.future);
              if (!appState.hasDataServer) return null;
              final appRuntimeState = ref.read(core_domain.appRuntimeProvider);

              return core_domain.UploadSession(
                config: appState.uploadConfig,
                dataServer: appState.currentDataServer!,
                deviceId: appState.deviceId,
                bearerToken: appRuntimeState.bearerToken,
              );
            },
          );

          ref.listen(core_domain.appProvider, (previous, next) {
            final previousConfig = previous?.asData?.value.uploadConfig;
            final nextConfig = next.asData?.value.uploadConfig;

            if (nextConfig != null && previousConfig != nextConfig) {
              service.refreshSchedule();
            }
          });

          return service;
        }),
      ],
      child: appkit.LocaleAwareWidget(builder: (locale) => AppShell(locale: locale)),
    ),
  );
}
