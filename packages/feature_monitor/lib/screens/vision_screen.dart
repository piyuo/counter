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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appRuntimeState = ref.watch(core_domain.appRuntimeProvider);
    final showSplash = !appRuntimeState.isVisionRunning;

    return Stack(
      children: [
        if (showSplash)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
            ),
          ),
        vision.Preview(fit: BoxFit.cover),
      ],
    );
  }
}
