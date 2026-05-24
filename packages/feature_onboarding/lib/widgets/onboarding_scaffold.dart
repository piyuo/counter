import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/feature_pip.dart' as pip;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum NextButtonAction { next, start, none }

final _primaryColor = Colors.blue.shade700;

// add typedef function builder that will take a BuildContext return list of Widget
typedef ContentBuilder = List<Widget> Function(BuildContext context);

class OnboardingScaffold extends ConsumerWidget {
  const OnboardingScaffold({
    required this.builder,
    this.footBuilder,
    this.showSkipIntro = false,
    this.onNextButtonPressed,
    this.isLoading = false,
    this.nextButtonAction = NextButtonAction.next,
    this.automaticallyImplyLeading = true,
    this.title,
    super.key,
  });

  final bool isLoading;

  final ContentBuilder builder;

  final ContentBuilder? footBuilder;

  final bool showSkipIntro;

  final VoidCallback? onNextButtonPressed;

  final NextButtonAction nextButtonAction;

  final String? title;

  /// Whether to show a back button automatically when the navigator can pop.
  ///
  /// Defaults to true.
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(brightness: Brightness.light, seedColor: _primaryColor),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: _primaryColor)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        bodyMedium: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
        bodySmall: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
        labelLarge: TextStyle(fontSize: 18.0, color: Colors.blue),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: _primaryColor, foregroundColor: Colors.white),
      ),
    );

    Widget? effectiveLeading;
    if (automaticallyImplyLeading) {
      final router = GoRouter.of(context);
      final canPop = router.canPop();
      if (canPop) {
        effectiveLeading = Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextButton(
            onPressed: () => router.pop(),
            child: Text('Back', style: TextStyle(fontSize: 18, color: Colors.blue)), //todo:add translation
          ),
        );
      }
    }

    return Theme(
      data: introTheme,
      child: feature_pip.PipScaffold(
        appBarBackgroundColor: introTheme.appBarTheme.backgroundColor ?? introTheme.colorScheme.surface,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: effectiveLeading,
        action: showSkipIntro
            ? Padding(
                padding: EdgeInsetsGeometry.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    ref.go(const core_domain.OpenOnboardingSystem());
                  },
                  child: Text('Skip Intro', style: TextStyle(fontSize: 18, color: Colors.blue)), //todo:add translation
                ),
              )
            : null,
        builder: (scrollController) {
          return Builder(
            builder: (innerContext) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Theme.of(innerContext).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10.0,
                      spreadRadius: 0,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(0, feature_pip.kScrollContentAppbarPadding, 0, 0),
                  controller: scrollController,
                  child: Column(
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(innerContext).textTheme.titleLarge!.copyWith(
                            color: nextButtonAction == NextButtonAction.start ? Colors.green : null,
                          ),
                        ),
                      ...builder(innerContext),
                      const SizedBox(height: 8.0),
                      if (nextButtonAction != NextButtonAction.none)
                        IntroNextButton(
                          text: nextButtonAction == NextButtonAction.next ? 'Next' : 'Start',
                          color: nextButtonAction == NextButtonAction.next ? Colors.blue : Colors.green,
                          onPressed: onNextButtonPressed,
                          isLoading: isLoading,
                        ),
                      if (footBuilder != null) ...footBuilder!(innerContext),
                      const SizedBox(height: 30.0), // bottom padding so next button won't be too close to the edge
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class IntroNextButton extends StatelessWidget {
  const IntroNextButton({required this.text, required this.color, this.onPressed, this.isLoading = false, super.key});

  final VoidCallback? onPressed;

  /// When true, shows a loading indicator next to the button text and disables the button.
  final bool isLoading;

  final String text;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final isMacOS = Theme.of(context).platform == TargetPlatform.macOS;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: isMacOS ? 15.0 : 10.0),
        minimumSize: Size(0, isMacOS ? 48.0 : 40.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4,
        shadowColor: Colors.black,
        disabledBackgroundColor: color.withValues(alpha: 0.3),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          if (isLoading) ...[
            SizedBox(width: 20),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Widget onboardingSpacer() {
  return const SizedBox(height: 20.0);
}

Widget onboardingImage(String assetPath) {
  return SizedBox(height: 240, child: Image.asset(assetPath, fit: BoxFit.cover));
}

Widget onboardingPanel(Widget child) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    clipBehavior: Clip.antiAlias,
    elevation: 2,
    child: child,
  );
}

Widget onboardingTextField(String text) {
  return TextFormField(
    initialValue: text,
    readOnly: true,
    style: const TextStyle(fontSize: 14, color: Colors.blue),
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      suffixIcon: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () async {
          Clipboard.setData(ClipboardData(text: text));
          await pip.showMessageDialog('URL copied');
        },
      ),
    ),
  );
}

Widget onboardingTextButton(String text, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.blue)),
  );
}
