import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_l10n/shared_l10n.dart';

class LocalOnlyScreen extends ConsumerWidget {
  const LocalOnlyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            feature_pip.PipPanel(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
              child: Column(
                children: [
                  const Icon(Icons.dns_outlined, size: 64),
                  const SizedBox(height: 8),
                  Text(context.l.settings_screen_local_title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    context.l.settings_screen_local_subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(context.l.local_only_screen_body, style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final router = GoRouter.of(context);
                    await ref.read(core_domain.appProvider.notifier).selectNoDataServer();
                    router.pop();
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  child: Text(context.l.local_only_screen_use_action, style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
