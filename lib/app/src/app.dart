import 'package:flutter/material.dart';
import 'package:libcli/apollo/apollo.dart' as apollo;
import 'package:libcli/auth/auth.dart' as auth;
import 'package:libcli/net/net.dart' as net;
import 'package:provider/provider.dart';

import 'theme.dart';

/// appConfigFileName used in native app to load config
const appConfigFileName = 'asset/config/app.json';

/// kPiyuoCom is piyuo.com url
const kPiyuoCom = 'https://piyuo.com';

// [indexPath] is index path
const indexPath = '/';

/// [productsPath] is product path
const productsPath = '/products';

/// [dashboardPath] is dashboard path
const dashboardPath = '/dashboard';

/// [orderPath] is order path
const orderPath = '/order';

/// [signinPath] is signin path
const signinPath = '/signin';

/// start app
start(apollo.Routes routes) => apollo.start(
      theme: themeLight,
      routes: routes,
      appBuilder: (Widget child) {
        return MultiProvider(
          providers: [
            Provider<net.Downloader>(
              create: (_) => net.Downloader(),
            ),
            Provider<auth.AuthService>(
              create: (context) => auth.AuthService('https://auth-us.piyuo.com/?q'),
            ),
          ],
          child: child,
        );
      },
    );

/// initUrl init service with remote url
T initUrl<T extends net.Service>(BuildContext context, T service) {
  final sessionProvider = apollo.SessionProvider.of(context);
  final session = sessionProvider.session;
  String? region;
  if (session != null && session.containsKey(apollo.kSessionRegionKey)) {
    region = '-${session[apollo.kSessionRegionKey]}';
  } else {
    region = '-us';
  }
  service.url = 'https://${service.serviceName}$region.piyuo.com/?q';
  return service;
}

/// AppScreen is a screen that will init providers when loading screen show
class AppScreen extends StatelessWidget {
  const AppScreen({
    required this.builder,
    required this.loader,
    super.key,
  });

  /// builder is a function that will be called when the screen is ready
  final Widget Function(bool isReady) builder;

  /// loader is a function that will be called when the screen is loading
  final Future<void> Function() loader;

  @override
  Widget build(BuildContext context) {
    return apollo.FutureLoader(
      loader: (notifyListener) async {
        final languageProvider = apollo.LanguageProvider.of(context);
        final sessionProvider = apollo.SessionProvider.of(context);
        await languageProvider.init();
        await sessionProvider.init();
        await loader();
      },
      builder: (isReady) => builder(isReady),
    );
  }
}

/*
main() => start(
      appName: 'piyuo.app',
      theme: shared.theme(),
      darkTheme: shared.darkTheme(),
      builder: shared.appBuilder,
      routesBuilder: () => {
        '/': (context, state, data) => BeamPage(
              key: const ValueKey('/'),
              title: context.l10n.indexPageTitle,
              child: index.startScreen(context),
            ),
        '/signup': (context, state, routeData) => signup.startScreen(context),
        routes.dashboardPath: (context, state, data) => BeamPage(
              key: const ValueKey('dashboard'),
              title: context.l10n.dashboardPageTitle,
              child: const DashboardScreen(),
            ),
        '$orderPath/:id': (context, state, data) {
          final id = state.pathParameters['id']!;
          return BeamPage(
            key: ValueKey('other-$id'),
            title: context.l10n.orderPageTitle,
            child: OrderPage(orderID: id),
          );
        },
        products.listRoute: products.listPage,
        products.productRoute: products.productPage,
      },
    );
*/
/*

Future<String?> _accessTokenBuilder() async {
  final session = await _sessionProvider.getSession();
  if (session == null) {
    return null;
  }
  return session.accessTicket.token;
}

String _acceptLanguage() => i18n.localeToAcceptLanguage(i18n.locale);

String _sessionRegionBuilder() {
  final session = _sessionProvider.currentSession;
  if (session != null && session.containsKey(app.kSessionRegion)) {
    return '-${session[app.kSessionRegion]}';
  }
  return '-us';
}

///
T setupRemote<T extends command.Service>(T service) {
  service.accessTokenBuilder = _accessTokenBuilder;
  service.acceptLanguage = _acceptLanguage;
  service.urlBuilder = () => 'https://${service.serviceName}${_sessionRegionBuilder()}$_branchUrl.piyuo.com/?q';
  return service;
}


*/