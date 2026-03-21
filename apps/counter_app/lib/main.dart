import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_shell/app_shell.dart';

void main() async {
  // Instantiate early — before ProviderScope — so AppLinks is ready to catch
  // the very first link when the app launches from a cold state.
  core_runtime.NativeAppLinkService? appLinkService;
  core_runtime.TelemetryDatabase? telemetryDb;
  appkit.appRun(
    preInitCallback: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await LiquidGlassWidgets.initialize();
      appLinkService = core_runtime.NativeAppLinkService();
      final appSupportDir = await getApplicationSupportDirectory();
      final telemetryDbPath = p.join(appSupportDir.path, 'telemetry.db');
      telemetryDb = await core_runtime.TelemetryDatabase.open(filePath: telemetryDbPath);
    },
    ProviderScope(
      //observers: [appkit.riverpodObserver()],
      overrides: [
        core_domain.appStateRepositoryProvider.overrideWith((ref) => core_runtime.SharedPrefsAppStateRepository()),
        core_domain.authStorageServiceProvider.overrideWith((ref) => core_runtime.SecureAuthStorageService()),
        core_domain.hardwareCapabilityServiceProvider.overrideWith(
          (ref) => core_runtime.NativeHardwareCapabilityService(),
        ),
        core_domain.visionRuntimeServiceProvider.overrideWith((ref) => core_runtime.FlutterVisionRuntimeService(ref)),
        core_domain.invitationServiceProvider.overrideWith((ref) => core_runtime.RemoteInvitationService()),
        core_domain.tokenGeneratorServiceProvider.overrideWith((ref) => core_runtime.RandomTokenGeneratorService()),
        core_domain.urlValidatorServiceProvider.overrideWith((ref) => core_runtime.HttpUrlValidatorService()),
        core_domain.appLinkServiceProvider.overrideWith((ref) {
          assert(appLinkService != null, 'AppLinkService should have been initialized in preInitCallback');
          ref.keepAlive(); // must stay alive so the stream listener can write to invitationCodeProvider
          Future(
            () => appLinkService!.init(ref),
          ); // schedule after binding is ready; completes well before boot reads the code
          return appLinkService!;
        }),
        core_domain.telemetryQueueRepositoryProvider.overrideWith((ref) {
          assert(telemetryDb != null, 'TelemetryDatabase should have been initialized in preInitCallback');
          ref.keepAlive();
          return core_runtime.DriftPayloadQueueRepository(telemetryDb!);
        }),
        core_domain.telemetryServiceProvider.overrideWith((ref) {
          ref.keepAlive();
          final service = core_runtime.NativeTelemetryService(
            queue: ref.read(core_domain.telemetryQueueRepositoryProvider),
            onServerConfigOverride: ({detection, detectionParams, deliveryConfig}) async {
              await ref
                  .read(core_domain.appProvider.notifier)
                  .applyServerConfigOverrides(
                    detection: detection,
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
              final dataServer = appState.dataServer;
              if (!dataServer.hasMadeDecision || dataServer is core_domain.NoDataServer) return null;

              final bearerToken = switch (dataServer) {
                core_domain.BusinessDataServer() =>
                  await ref.read(core_domain.appRuntimeStateProvider.notifier).ensureBusinessBearerTokenLoaded(),
                _ => null,
              };

              return core_domain.UploadSession(
                config: appState.uploadConfig,
                dataServer: dataServer,
                deviceId: appState.deviceId,
                bearerToken: bearerToken,
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
      child: LiquidGlassWidgets.wrap(appkit.LocaleAwareWidget(builder: (locale) => AppShell(locale: locale))),
    ),
  );
}
