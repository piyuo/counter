import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

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
    _cloudUrlController = TextEditingController();
    _cloudUrlController.addListener(_clearError);
    Future<void>(() async {
      final cloudUrl = await ref.read(core_domain.appProvider.notifier).ensurePiyuoCloudUrl();
      if (!mounted) return;
      _cloudUrlController.text = cloudUrl;
    });
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
                  Text('Piyuo Cloud', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Use a Piyuo Cloud URL for uploads.',
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
                    Text('Cloud URL', style: Theme.of(context).textTheme.titleSmall),
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
                              await showMessageDialog('URL copied');
                            },
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy URL'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'If you already had a Piyuo Cloud URL from an older install, paste it here to keep using the same cloud space.',
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
                              _urlError = 'Please paste a valid Piyuo Cloud URL.';
                            });
                            return;
                          }

                          setState(() {
                            _isSaving = true;
                            _urlError = null;
                          });

                          final notifier = ref.read(core_domain.appProvider.notifier);
                          await notifier.setPiyuoCloudUrl(typedUrl);
                          await notifier.setPersonalPiyuoDataServer(typedUrl);

                          if (!mounted) return;
                          setState(() {
                            _isSaving = false;
                          });
                          Navigator.of(context).pop();
                        },
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  child: Text(_isSaving ? 'Saving...' : 'Use Piyuo Cloud'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
