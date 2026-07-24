// TOC:
// - StartScreen: control-panel landing screen
// - detection type tile: shows current selection and opens detection settings
// - upload logs tile: quick access to recent telemetry upload outcomes

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableUrl extends StatelessWidget {
  const ClickableUrl({super.key, required this.text});

  final String text;

  bool _isUrl(String text) {
    if (text.isEmpty) return false;
    try {
      final uri = Uri.parse(text);
      return uri.scheme == 'http' || uri.scheme == 'https';
    } catch (e) {
      return false;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUrl = _isUrl(text);
    //final simpleUrl = text.replaceAll(RegExp(r'^https?://'), '').replaceAll(RegExp(r'/$'), '');
    if (!isUrl) {
      return AutoSizeText(
        text,
        style: TextStyle(color: Colors.blue.shade400, fontSize: 14),
        textAlign: TextAlign.center,
      );
    }

    return GestureDetector(
      onTap: () => _launchUrl(text),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AutoSizeText(
          text,
          style: TextStyle(
            color: Colors.blue.shade400,
            fontSize: 14,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue.shade400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
