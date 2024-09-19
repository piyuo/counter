import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:libcli/apollo/apollo.dart' as apollo;
import 'package:libcli/delta/delta.dart' as delta;
import 'package:provider/provider.dart';

/// AppScaffold is app scaffold
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.builder,
    required this.loader,
    this.mustSignIn = false,
    this.title,
    super.key,
  });

  /// builder must return sliver, it is a function that will be called when render screen content
  final Widget Function(bool isReady) builder;

  /// loader is a function that will be called when the screen is loading
  final Future<void> Function() loader;

  /// mustSignIn is a flag to indicate if the user must sign in or user will be redirected to sign in page
  final bool mustSignIn;

  final String? title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appBarTheme = Theme.of(context).appBarTheme;
    return Consumer<apollo.SessionProvider>(builder: (context, sessionProvider, _) {
      final session = sessionProvider.session;
      final hasSession = session != null && (session.isValid || session.canRefresh);

      buildUserButton() {
        return PopupMenuButton<int>(
          tooltip: hasSession ? 'User menu' : 'Sign in',
          onSelected: (v) {},
          offset: const Offset(10, 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          itemBuilder: (BuildContext context) => hasSession
              ? [
                  const PopupMenuItem(child: Text('Logout')),
                ]
              : [],
          child: TextButton.icon(
            //style: TextButton.styleFrom().copyWith(
            // overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
            //),
            icon: hasSession
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: delta.Avatar(
                      imageUrl: session[apollo.kSessionUserPhotoKey],
                      name: session[apollo.kSessionUserNameKey] ?? 'N/A',
                    ))
                : const SizedBox.shrink(),
            label: Text(
              hasSession ? session[apollo.kSessionUserNameKey] : 'Sign in',
              style: appBarTheme.titleTextStyle,
            ),
            onPressed: hasSession ? null : () => Beamer.of(context).goTo(apollo.kSigninPath),
          ),
        );
      }

      buildScaffold(isReady) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              apollo.SliverBar(
                spacing: 5,
                title: title != null ? Text(title!, style: appBarTheme.toolbarTextStyle) : null,
                actions: [
                  buildUserButton(),
                  if (!hasSession)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        child: const Text('Create Account', style: TextStyle(fontSize: 13)),
                        onPressed: () {} //=> Beamer.of(context).goTo(signinPath),
                        ),
                  if (delta.notPhoneScreen) const SizedBox(width: 10),
                ],
              ),
              builder(isReady),
            ],
          ),
        );
      }

      return apollo.FutureLoader(
        loader: (notifyListener) async {
          final languageProvider = apollo.LanguageProvider.of(context);
          final sessionProvider = apollo.SessionProvider.of(context);
          final beamer = Beamer.of(context);
          await languageProvider.init();
          await sessionProvider.init();
          await loader();
          if (mustSignIn) {
            final session = await sessionProvider.getValidSession();
            if (session == null) {
              return beamer.goSignIn();
            }
          }
        },
        builder: (isReady) => buildScaffold(isReady),
      );
    });
  }
}
