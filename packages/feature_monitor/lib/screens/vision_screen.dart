import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

class VisionScreen extends ConsumerStatefulWidget {
  const VisionScreen({super.key});

  @override
  ConsumerState<VisionScreen> createState() => _VisionScreenState();
}

class _VisionScreenState extends ConsumerState<VisionScreen> {
  ProviderSubscription<core_domain.VisionSessionState>? _sessionSubscription;
  Timer? _previewReadyTimer;
  bool _isPreviewReady = false;

  @override
  void initState() {
    super.initState();
    _sessionSubscription = ref.listenManual(
      core_domain.visionSessionProvider,
      (previous, next) => _handleSessionChanged(next),
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _previewReadyTimer?.cancel();
    _sessionSubscription?.close();
    super.dispose();
  }

  void _handleSessionChanged(core_domain.VisionSessionState session) {
    _previewReadyTimer?.cancel();

    if (!session.isRunning) {
      if (_isPreviewReady && mounted) {
        setState(() => _isPreviewReady = false);
      }
      return;
    }

    _previewReadyTimer = Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isPreviewReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(core_domain.visionSessionProvider);
    final showSplash = !_isPreviewReady;

    return Stack(
      children: [
        if (showSplash)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
            ),
          ),
        vision.Preview(fit: BoxFit.cover),
        if (session.hasError)
          const ColoredBox(
            color: Color(0x99000000),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Failed to initialize vision runtime',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
