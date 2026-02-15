import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_shell/app_shell.dart';

void main() {
  appkit.appRun(
    ProviderScope(
      //observers: [appkit.riverpodObserver()],
      overrides: [
        core_domain.appStateRepositoryProvider.overrideWith((ref) => core_runtime.SharedPrefsAppStateRepository()),
        core_domain.hardwareCapabilityServiceProvider.overrideWith((ref) => core_runtime.HardwareCapabilityService()),
      ],
      child: appkit.LocaleAwareWidget(builder: (locale) => AppShell(locale: locale)),
    ),
  );
}
