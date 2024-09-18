import 'package:auto_size_text/auto_size_text.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_lib/apollo/apollo.dart' as apollo;
import 'package:sample_lib/delta/delta.dart' as delta;

/// AppScaffold is app scaffold
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.builder,
    required this.loader,
    this.mustSignIn = false,
    super.key,
  });

  /// builder must return sliver, it is a function that will be called when render screen content
  final Widget Function(bool isReady) builder;

  /// loader is a function that will be called when the screen is loading
  final Future<void> Function() loader;

  /// mustSignIn is a flag to indicate if the user must sign in or user will be redirected to sign in page
  final bool mustSignIn;

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
        Widget linkButton(String text, String url, {bool bold = false}) {
          return TextButton(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            onPressed: () {},
          );
        }

        return Scaffold(
          endDrawer: Drawer(
            shape: const RoundedRectangleBorder(),
            child: SafeArea(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(title: const Text('Products'), onTap: () => Navigator.pop(context)),
                ListTile(title: const Text('Technology'), onTap: () => Navigator.pop(context)),
                ListTile(title: const Text('Pricing'), onTap: () => Navigator.pop(context)),
              ],
            )),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              apollo.SliverBar(
                spacing: 5,
                home: Text('Piyuo Counter', style: appBarTheme.toolbarTextStyle),
                items: [
                  apollo.BarItemButton(text: 'Technology', onPressed: () => debugPrint('Technology pressed')),
                  apollo.BarItemButton(text: 'Pricing', onPressed: () => debugPrint('Pricing pressed')),
                ],
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
              SliverToBoxAdapter(
                  child: apollo.Footer(
                copyRight: AutoSizeText('Copyright © Piyuo LLC. All rights reserved.',
                    maxLines: 2, style: TextStyle(fontSize: 14, color: colorScheme.outline)),
                actions: const [apollo.LanguageButton()],
                items: [
                  linkButton('About', ''),
                  linkButton('Privacy Policy', 'privacy'),
                  linkButton('Terms of Use', 'terms'),
                ],
              )),
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
/*
  @override
  Widget build(BuildContext context) {
    Widget drawerItem(String text) => ListTile(
          title: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: Colors.grey[800]!,
            ),
          ),
        );

    Widget drawer() => Padding(
        padding: const EdgeInsets.all(40),
        child: SafeArea(
            child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 8.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ListView(
                  padding: const EdgeInsets.only(left: 40),
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 10),
                    apollo.BeamLink(
                      path: routes.dashboardPath,
                      child: drawerItem('XHot it works'),
                    ),
                    const Divider(height: 10),
                    apollo.BeamLink(
                      path: '${routes.orderPath}/2f123181mb',
                      child: drawerItem('XTechnology'),
                    ),
                    const Divider(height: 10),
                    drawerItem('Pricing'),
                    const Divider(height: 10),
                  ],
                ))));

    Widget shortcutsItem(String text) => Text(
          text,
          style: TextStyle(
            color: Colors.grey[700]!,
          ),
        );

    Widget shortcuts() => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              apollo.BeamLink(
                path: routes.dashboardPath,
                child: shortcutsItem('Hot it works'),
              ),
              const Spacer(),
              apollo.BeamLink(
                path: '${routes.orderPath}/2f123181mb',
                child: shortcutsItem('Technology'),
              ),
              const Spacer(),
              shortcutsItem('Pricing'),
              const Spacer(),
            ],
          ),
        );

    SliverAppBar bar(PortalScaffoldProvider model, bool isPhoneLayout) {
      return SliverAppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 1),
          child: Container(
            height: 1,
            color: const Color(0xFFE7EAED),
          ),
        ),
        pinned: true,
        automaticallyImplyLeading: isPhoneLayout,
        foregroundColor: Colors.grey[600],
        backgroundColor: Colors.white.withOpacity(0.9),
        title: Row(children: [
          InkWell(
            onTap: () => model.onLogoClicked(context),
            child: const AutoSizeText('Piyuo',
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                )),
          ),
          if (!isPhoneLayout) shortcuts()
        ]),
        actions: [
          TextButton(
            child: Text(
              context.l10n.mainframeSigninButtonText,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            onPressed: () => model.onSignInClicked(context),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(4, 10, 0, 10),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
                ),
                onPressed: () {}, // model.onCreateAccountClicked(context),
                child: Text(
                  context.l10n.mainframeCreateButtonText,
                  style: TextStyle(
                    color: Colors.grey[50],
                  ),
                ),
              )),
          const SizedBox(width: 8),
        ],
      );
    }

    return ChangeNotifierProvider<PortalScaffoldProvider>(
        create: (context) => PortalScaffoldProvider(),
        child: Consumer<PortalScaffoldProvider>(
            builder: (context, provide, _) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) => SliverScaffold(
                      // drawer: delta.buildLayoutWidget(constraints.maxWidth, phone: _drawer),
                      drawer: drawer(),
                      backgroundColor: const Color(0xFFF8F9FA),
                      appBar: bar(provide, delta.phoneScreen),
                      appBarPadding: delta.paddingToCenter(context, 900),
                      padding: delta.paddingToCenter(context, 900),
                      children: [
                        _tool(context, provide),
                        child ?? const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey[350]!,
                          ),
                        ),
                        _footer(context, provide),
                      ],
                    ))));
  }

  Widget _language(BuildContext context, PortalScaffoldProvider model) => Theme(
        data: ThemeData(
          hoverColor: Colors.white,
          focusColor: Colors.white,
        ),
        child: DropdownButton<String>(
          //isExpanded: true,
          //alignment: AlignmentDirectional.centerEnd,
          borderRadius: BorderRadius.circular(15),
          dropdownColor: Colors.white,
          underline: const SizedBox(),
          value: i18n.locale.toString(),
          icon: const Icon(
            Icons.expand_more,
            color: Colors.black87,
          ),
          onChanged: (String? newValue) => model.onSelectLanguage(context, newValue),
          items: model.languages.entries.map<DropdownMenuItem<String>>((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            );
          }).toList(),
        ),
      );

  Widget _tool(BuildContext context, PortalScaffoldProvider provide) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _language(context, provide),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _link(BuildContext context, String text, String url, {bool bold = false}) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: Text(
          text,
          style: TextStyle(
            color: bold ? Colors.grey[600] : Colors.grey,
            fontSize: 16,
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            fontFamily: 'Helvetica',
          ),
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _footer(BuildContext context, PortalScaffoldProvider provide) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _link(context, '© Piyuo LLC', '', bold: true),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: _language(context, provide),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _link(context, 'Products', '', bold: true),
            _link(context, 'Technology', ''),
            _link(context, 'Pricing', ''),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _link(context, 'About', '', bold: true),
            _link(context, 'Privacy', 'privacy'),
            _link(context, 'Terms', ''),
          ],
        ),
      ],
    );
  }*/
}
