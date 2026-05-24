import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

import '../widgets/onboarding_scaffold.dart';

class SystemScreen extends ConsumerStatefulWidget {
  const SystemScreen({super.key});

  @override
  ConsumerState<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends ConsumerState<SystemScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isTestStarting = false;
  String? testSuccessMessage;
  String? testErrorMessage;

  // Callback for the compatibility test
  void onTestStarted() {
    setState(() {
      isTestStarting = true;
    });
  }

  /// Callback when the test finishes.
  void onTestFinished(String errorMessage, vision.VisionPerformance performance) {
    setState(() {
      isTestStarting = false;
      if (errorMessage.isEmpty) {
        testSuccessMessage = 'FPS: ${performance.fps}';
        testErrorMessage = null;
      } else {
        testErrorMessage = errorMessage;
        testSuccessMessage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final compatibilityState = ref.watch(vision.compatibilityProvider);
    final isStarting = compatibilityState.isStarting;

    Widget getLine1() {
      if (compatibilityState.status == vision.TestStatus.none ||
          compatibilityState.status == vision.TestStatus.starting) {
        return const Text(
          "Piyuo Counter uses your camera and AI to count people. First, let's make sure your device is compatible.",
          textAlign: TextAlign.center,
        );
      }
      if (testErrorMessage != null) {
        return Text(
          "Test failed: $testErrorMessage",
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        );
      }
      if (compatibilityState.status == vision.TestStatus.started) {
        return const Text(
          "Point your camera at people. The app will draw boxes around anyone it detects.",
          textAlign: TextAlign.center,
        );
      }
      return const SizedBox.shrink();
    }

    Widget getLine2() {
      if (compatibilityState.status == vision.TestStatus.none ||
          compatibilityState.status == vision.TestStatus.starting) {
        return const Text(
          'Tap Start. If asked, allow camera access.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        );
      }
      if (testErrorMessage != null) {
        return const SizedBox.shrink();
      }

      if (testSuccessMessage != null) {
        return Column(
          children: [
            Text(
              "Test passed! $testSuccessMessage",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(vision.compatibilityProvider.notifier).stop();
                ref.go(const core_domain.OpenOnboardingCTA());
              },
              child: const Text(
                'Tap Next to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        );
      }
      if (compatibilityState.status == vision.TestStatus.started) {
        return const Text("Waiting for the AI to detect people…", textAlign: TextAlign.center);
      }
      return const SizedBox.shrink();
    }

    return PopScope(
      canPop: !isStarting,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (isStarting) {
          appkit.logDebug('[CompatibilityExample] blocked pop - system still starting up.');
          return;
        }

        Future.microtask(() {
          ref.read(vision.compatibilityProvider.notifier).stop();
        });

        if (!didPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: OnboardingScaffold(
        title: 'AI Camera Test',
        nextButtonAction: NextButtonAction.next,
        onNextButtonPressed: testSuccessMessage == null
            ? null
            : () async {
                await ref.read(vision.compatibilityProvider.notifier).stop();
                ref.go(const core_domain.OpenOnboardingCTA());
              },
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
