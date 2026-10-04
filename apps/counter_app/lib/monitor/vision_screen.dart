import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:counter_app/interest_area/area_viewport.dart';
import 'package:counter_app/interest_area/interest_area_editor_overlay.dart';
import 'package:counter_app/interest_area/interest_area_viewer_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

// No local state, so this no longer needs to be a ConsumerStatefulWidget.
class VisionScreen extends ConsumerWidget {
  const VisionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRuntimeState = ref.watch(core_domain.appRuntimeProvider);
    final showSplash = !appRuntimeState.isVisionRunning;
    final isEditingAreas = ref.watch(core_runtime.interestAreaProvider.select((state) => state.isEditing));
    final observationState = ref.watch(core_runtime.observationProvider);

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
                final viewport = AreaViewport(
                  videoWidth: videoWidth,
                  videoHeight: videoHeight,
                  isIPadLandscape: isIPadLandscape,
                  displayWidth: displayWidth,
                  displayHeight: displayHeight,
                  displayScale: displayScale,
                  rotationDegrees: rotationDegrees,
                );

                return isEditingAreas
                    ? InterestAreaEditorOverlay(viewport: viewport)
                    : InterestAreaViewerOverlay(viewport: viewport, observationState: observationState);
              },
        ),
      ],
    );
  }
}
