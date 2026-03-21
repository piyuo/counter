import 'package:feature_onboarding/widgets/next_button_container.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

class OnboardingScaffold extends ConsumerWidget {
  const OnboardingScaffold({
    this.title,
    this.action,
    this.isNextOrStart = true,
    this.isLoading = false,
    this.onNextPressed,
    required this.children,
    super.key,
  });

  final String? title;

  final Widget? action;

  final bool isLoading;

  final bool isNextOrStart;

  final VoidCallback? onNextPressed;

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return feature_pip.PipScaffold(
      title: title,
      action: action,
      builder: (scrollController) {
        return NextButtonContainer(
          isLoading: isLoading,
          isNextOrStart: isNextOrStart,
          onNextPressed: onNextPressed,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              0,
              feature_pip.kScrollContentAppbarPadding,
              0,
              UniversalPlatform.isMobile ? 90 : 80.0,
            ),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...children,
                  if (!isNextOrStart)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "Press the button above to start detecting",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
