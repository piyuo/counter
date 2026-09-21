import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_counting/feature_counting.dart' as feature_counting;
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
    final isEditingAreas = ref.watch(feature_counting.interestAreaProvider.select((state) => state.isEditing));
    final countState = ref.watch(feature_counting.windowCountProvider);

    return Stack(
      children: [
        if (showSplash)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
            ),
          ),
        vision.Preview(
          fit: BoxFit.cover,
          overlayBuilder:
              (
                BuildContext context,
                WidgetRef ref, {
                required double rotationDegrees,
                required bool isIPadLandscape,
                required double displayWidth,
                required double displayHeight,
                required double displayScale,
                required double videoWidth,
                required double videoHeight,
              }) {
                return isEditingAreas
                    ? feature_counting.InterestAreaEditorOverlay(
                        videoWidth: videoWidth,
                        videoHeight: videoHeight,
                        rotationDegrees: rotationDegrees,
                        isIPadLandscape: isIPadLandscape,
                        displayWidth: displayWidth,
                        displayHeight: displayHeight,
                        displayScale: displayScale,
                      )
                    : feature_counting.InterestAreaViewerOverlay(
                        videoWidth: videoWidth,
                        videoHeight: videoHeight,
                        rotationDegrees: rotationDegrees,
                        countState: countState,
                        isIPadLandscape: isIPadLandscape,
                        displayWidth: displayWidth,
                        displayHeight: displayHeight,
                        displayScale: displayScale,
                      );
              },
        ),
      ],
    );
  }
}
