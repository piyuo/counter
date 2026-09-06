import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class CameraTestScreen extends ConsumerStatefulWidget {
  const CameraTestScreen({super.key});

  @override
  ConsumerState<CameraTestScreen> createState() => _CameraTestScreenState();
}

class _CameraTestScreenState extends ConsumerState<CameraTestScreen> {
  late final vision.CompatibilityNotifier compatibilityNotifier;

  bool isTestStarting = false;
  String? testSuccessFPS;
  String? testErrorMessage;

  @override
  void initState() {
    super.initState();

    // Cache the notifier while the widget is mounted.
    // Do not use ref during/after dispose or after the route has been popped.
    compatibilityNotifier = ref.read(vision.compatibilityProvider.notifier);
  }

  void onTestStarted() {
    if (!mounted) return;

    setState(() {
      isTestStarting = true;
    });
  }

  /// Callback when the test finishes.
  void onTestFinished(int errorCode, String errorMessage, vision.VisionPerformance performance) {
    if (!mounted) return;

    setState(() {
      isTestStarting = false;

      if (errorMessage.isEmpty) {
        testSuccessFPS = 'FPS: ${performance.fps}';
        testErrorMessage = null;
      } else {
        testErrorMessage = errorMessage;
        testSuccessFPS = null;
      }
    });
  }

  Future<void> stopAndGoToNext() async {
    await compatibilityNotifier.stop();

    if (!context.mounted) return;

    ref.go(const core_domain.OpenOnboardingCTA());
  }

  @override
  Widget build(BuildContext context) {
    final compatibilityState = ref.watch(vision.compatibilityProvider);
    final isStarting = compatibilityState.isStart;

    Widget getLine1() {
      if (compatibilityState.status == vision.TestStatus.none) {
        return Text(context.l.camera_test_screen_help, textAlign: TextAlign.center);
      }

      if (testErrorMessage != null) {
        return Text(
          "${context.l.camera_test_screen_test_failed} $testErrorMessage",
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        );
      }

      if (compatibilityState.status == vision.TestStatus.start) {
        return Text(context.l.camera_test_screen_instruction, textAlign: TextAlign.center);
      }

      return const SizedBox.shrink();
    }

    Widget getLine2() {
      if (compatibilityState.status == vision.TestStatus.none) {
        return Text(
          context.l.camera_test_screen_start,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        );
      }

      if (testErrorMessage != null) {
        return const SizedBox.shrink();
      }

      if (testSuccessFPS != null) {
        return Column(
          children: [
            Text(
              context.l.camera_test_screen_test_passed,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.green, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(testSuccessFPS!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
            TextButton(
              onPressed: stopAndGoToNext,
              child: Text(
                context.l.camera_test_screen_next,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ],
        );
      }

      if (compatibilityState.status == vision.TestStatus.start) {
        return Text(context.l.camera_test_screen_wait, textAlign: TextAlign.center);
      }

      return const SizedBox.shrink();
    }

    return PopScope(
      // Prevent the route from being popped before stop() completes.
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }

        if (isStarting) {
          appkit.logDebug('[CompatibilityExample] blocked pop - system still starting up.');
          return;
        }

        await compatibilityNotifier.stop();

        if (!context.mounted) return;

        Navigator.pop(context);
      },
      child: OnboardingScaffold(
        title: context.l.camera_test_screen_title,
        nextButtonAction: NextButtonAction.next,
        onNextButtonPressed: testSuccessFPS == null ? null : stopAndGoToNext,
        popEnabled: !isTestStarting,
        builder: (context) => [
          getLine1(),
          const SizedBox(height: 12),
          getLine2(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: vision.CompatibilityView(onTestStarted: onTestStarted, onTestFinished: onTestFinished),
          ),
        ],
      ),
    );
  }
}
