import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

class SettingsPiyuoScreen extends ConsumerStatefulWidget {
  const SettingsPiyuoScreen({super.key});

  @override
  ConsumerState<SettingsPiyuoScreen> createState() => _SettingsPiyuoScreenState();
}

class _SettingsPiyuoScreenState extends ConsumerState<SettingsPiyuoScreen> {
  late final TextEditingController _cloudUrlController;
  String? _urlError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final appState = ref.read(core_domain.appProvider).asData?.value;
    assert(appState != null, 'AppState should be available when PersonalCustomServerScreen is initialized.');
    assert(
      appState!.personalPiyuoServer != null,
      'Personal Piyuo Server should be available when PersonalCustomServerScreen is initialized.',
    );
    final existingUrl = appState!.personalPiyuoServer!.url;

    _cloudUrlController = TextEditingController();
    _cloudUrlController.addListener(_clearError);
    _cloudUrlController.text = existingUrl;
  }

  @override
  void dispose() {
    _cloudUrlController.removeListener(_clearError);
    _cloudUrlController.dispose();
    super.dispose();
  }

  void _clearError() {
    if (_urlError == null) return;
    setState(() {
      _urlError = null;
    });
  }

  bool _isValidPiyuoCloudUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return false;
    }

    final isPiyuoHost = uri.host == 'piyuo.com' || uri.host.endsWith('.piyuo.com');
    if (!isPiyuoHost) {
      return false;
    }

    return uri.path == '/api' || uri.path.startsWith('/api/');
  }

  @override
  Widget build(BuildContext context) {
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
                  const Icon(Icons.cloud_outlined, size: 64),
                  const SizedBox(height: 8),
                  Text(context.l.settings_piyuo_screen_title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    context.l.settings_piyuo_screen_body,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            feature_pip.PipPanel(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l.settings_piyuo_screen_cloud_url_label,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    GlassTextField(controller: _cloudUrlController),
                    if (_urlError != null) ...[
                      const SizedBox(height: 8),
                      Text(_urlError!, style: const TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              Clipboard.setData(ClipboardData(text: _cloudUrlController.text.trim()));
                              await showMessageDialog(context.l.settings_piyuo_screen_copy_success);
                            },
                            icon: const Icon(Icons.copy),
                            label: Text(context.l.settings_piyuo_screen_copy_action),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l.settings_piyuo_screen_legacy_body,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving
                      ? null
                      : () async {
                          final typedUrl = _cloudUrlController.text.trim();
                          if (!_isValidPiyuoCloudUrl(typedUrl)) {
                            setState(() {
                              _urlError = context.l.settings_piyuo_screen_invalid_url_error;
                            });
                            return;
                          }

                          setState(() {
                            _isSaving = true;
                            _urlError = null;
                          });

                          final appController = ref.read(core_domain.appProvider.notifier);
                          await appController.selectPersonalPiyuoServer();

                          setState(() {
                            _isSaving = false;
                          });
                          if (!mounted) return;
                          context.pop();
                        },
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  child: Text(
                    _isSaving
                        ? context.l.settings_piyuo_screen_saving_action
                        : context.l.settings_piyuo_screen_use_action,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
