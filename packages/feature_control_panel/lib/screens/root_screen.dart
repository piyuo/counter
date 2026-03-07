import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get screen height
    final localeDisplayLabels = appkit.localeDisplayLabels;
    final localization = appkit.Localization.of(context);

    final lifecycle = ref.watch(core_domain.systemLifecycleProvider);

    final statusLabel = lifecycle.whenOrNull(
      booting: () => context.l.main_screen_booting,
      checkingHardware: () => context.l.main_screen_checking_hardware,
    );

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              feature_pip.PipHeader(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Image(image: AssetImage('assets/icon/icon.png'), width: 84, height: 84),
                    const SizedBox(height: 8.0),
                    Text(context.l.product_name, style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // show loading indicator and status label when booting or checking hardware
              if (statusLabel != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 64, 16, 16),
                  child: const CupertinoActivityIndicator(radius: 16.0),
                ),

              if (statusLabel != null) Text(statusLabel),
              feature_pip.PipFooter(),
            ],
          ),
        );
      },
    );
  }
}
