import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_lib/apollo/apollo.dart' as apollo;
import 'package:sample_lib/delta/delta.dart' as delta;

import 'menu.dart';
import 'user_scaffold_model.dart';

class UserScaffold extends StatelessWidget {
  UserScaffold({
    required this.title,
    required this.child,
    this.backgroundColor,
    this.bottomNavigationBar,
    super.key,
  });

  final Widget child;

  final Widget? bottomNavigationBar;

  final String title;

  final Color? backgroundColor;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//  final ScrollController _sideScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    PopupMenuEntry<String> userMenuItem(String value, String text, IconData icon) {
      return PopupMenuItem<String>(
        value: value,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              icon,
//              color: Colors.grey[700]!,
            ),
          ),
          Text(text),
        ]),
      );
    }

    Widget userMenu() {
      return PopupMenuButton<String>(
        offset: const Offset(0, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          userMenuItem('item1', 'Preferences', Icons.settings_accessibility),
          userMenuItem('item2', 'Log out', Icons.logout),
        ],
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipOval(
                child: Image.network(
                  'https://www.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg',
                ),
              ),
            ),
            if (delta.notPhoneScreen)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('Kevin liu',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
            if (delta.notPhoneScreen) const Icon(Icons.arrow_drop_down),
            const SizedBox(width: 10),
          ],
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserScaffoldProvider>(
          create: (context) => UserScaffoldProvider(),
        ),
        ChangeNotifierProvider<delta.SidePanelProvider>(
          create: (context) => delta.SidePanelProvider(),
        ),
      ],
      child: Consumer2<UserScaffoldProvider, delta.SidePanelProvider>(
          builder: (context, userScaffoldProvider, sidePanelProvider, _) => delta.SidePanel(
                sideWidth: 240,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: const Alignment(1, 1), // 10% of the width, so there are ten blinds.
                    colors: [
                      Colors.red,
                      Colors.blue,
                    ], // red to yellow
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                sideWidget: _side(context),
                mainWidget: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: backgroundColor,
                  bottomNavigationBar: bottomNavigationBar,
                  appBar: AppBar(
                    elevation: 0,
                    bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 1),
                      child: Container(
                        height: 1,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sidePanelProvider.leading,
                        const SizedBox(width: 16),
                        Expanded(
                          child: Center(child: Text(title)),
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              padding: const EdgeInsets.all(10),
                              content: const Text('You have new order'),
                              leading: const Icon(Icons.error_outline),
                              backgroundColor: Colors.yellow[700],
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      userMenu(),
                    ],
                  ),
                  body: Consumer<UserScaffoldProvider>(builder: (context, model, _) => child),
                ),
              )),
    );
  }

  Widget _sideLabel(String label) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(label,
            style: const TextStyle(
              fontSize: 16,
            )));
  }

  Widget _sideButton(
    Color color,
    String label, {
    IconData? icon,
    String? badge,
    bool isSelected = false,
    Color badgeColor = Colors.grey,
  }) {
    return SizedBox(
        //      margin: const EdgeInsets.symmetric(horizontal: 10),
        //       decoration: isSelected == true
        //           ? BoxDecoration(
//                color: Colors.blue,
//                borderRadius: const BorderRadius.all(Radius.circular(25)),
        //             )
        //       : null,
        child: ListTile(
      horizontalTitleGap: 0,
      leading: icon != null
          ? Icon(
              icon,
              color: isSelected ? Colors.blue : color,
            )
          : const SizedBox(),
      title: Text(label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.blue : color,
          )),
      trailing: badge != null
          ? Chip(
              backgroundColor: badgeColor,
              label: Text(badge, style: const TextStyle(color: Colors.white)),
            )
          : null,
    ));
  }

  Widget _side(BuildContext context) {
    final menu = getMenu();
    var color = Colors.red;
    return ListView.builder(
      itemCount: menu.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.all(15),
            height: 45,
            //           color: Colors.blue.shade900,
            child: OutlinedButton.icon(
              icon: const Text('Irvine',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  )),
              label: const Icon(
                Icons.expand_more,
              ),
              onPressed: () => {},
            ),
          );
        }

        final item = menu[index - 1];
        if (item is MenuDivider) {
          return const Divider(height: 10);
        }

        if (item is MenuLabel) {
          return _sideLabel(item.title);
        }
        item as MenuButton;
        var button = _sideButton(
          color,
          item.title,
          isSelected: index == 2,
          icon: item.icon,
          badge: item.badge,
        );
        if (item.link != null) {
          button = apollo.BeamLink(
            path: item.link!,
            child: button,
          );
        }

        return button;
      },
    );
  }
}
