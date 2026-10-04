// TOC:
// - live url form: enter and validate a live stream URL
// - submit action: persists VideoSource.live into AppState and returns to previous screen

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

class UrlScreen extends ConsumerStatefulWidget {
  const UrlScreen({super.key});

  @override
  ConsumerState<UrlScreen> createState() => _LiveUrlScreenState();
}

class _LiveUrlScreenState extends ConsumerState<UrlScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _errorMessage;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentVideoSource = ref.watch(core_domain.appProvider).asData?.value.videoSource;
    if (_urlController.text.isEmpty && currentVideoSource is core_domain.LiveVideoSource) {
      _urlController.text = currentVideoSource.url;
    }

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
          child: Column(
            children: [
              feature_pip.PipHeader(
                icon: Icons.cloud_outlined,
                title: context.l.url_screen_title,
                subtitle: context.l.url_screen_subtitle,
              ),
              feature_pip.PipPanel(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.l.url_screen_url, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _urlController,
                        minLines: 2,
                        maxLines: 4,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) {
                          if (_errorMessage != null) {
                            setState(() {
                              _errorMessage = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: context.l.url_screen_url_hint,
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.08),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 10),
                        SelectableText(
                          _errorMessage!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.redAccent),
                        ),
                      ],
                      if (kDebugMode)
                        SelectableText(
                          'https://cdn-004.whatsupcams.com/hls/hr_karlovac1.m3u8',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : () => _handleSubmit(context),
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                    child: _isSubmitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4))
                        : Text(MaterialLocalizations.of(context).okButtonLabel),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final rawUrl = _urlController.text.trim();
      final validationError = await _validateLiveUrl(rawUrl);
      if (validationError != null) {
        setState(() {
          _errorMessage = validationError;
        });
        return;
      }

      final liveUrl = core_domain.VideoSource.live(url: rawUrl);
      await ref.read(core_domain.appProvider.notifier).setVideoSource(liveUrl);

      if (context.mounted) {
        Navigator.of(context).maybePop();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<String?> _validateLiveUrl(String url) async {
    if (url.isEmpty) {
      return context.l.url_screen_url_empty_error;
    }

    final parsedUri = Uri.tryParse(url);
    if (parsedUri == null || parsedUri.scheme.isEmpty) {
      return context.l.url_screen_invalid_url_error;
    }

    switch (parsedUri.scheme.toLowerCase()) {
      case 'http':
      case 'https':
        return ref.read(core_domain.urlValidatorServiceProvider).validate(url);
      case 'rtsp':
      case 'rtsps':
        if (parsedUri.host.isEmpty) {
          return context.l.url_screen_invalid_rtsp_error;
        }
        return null;
      default:
        return context.l.url_screen_unsupported_scheme_error;
    }
  }
}
