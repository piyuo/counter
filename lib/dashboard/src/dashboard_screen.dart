import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:libcli/delta/delta.dart' as delta;
import 'package:provider/provider.dart';

import 'accept_order.dart';
import 'dashboard_screen_provider.dart';
import 'delivery.dart';
import 'kitchen.dart';
import 'overview.dart';
import 'ready_board.dart';
import 'tables.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardScreenProvider>(
        builder: (context, model, _) => DefaultTabController(
            length: 6,
            child: app.UserScaffold(
              title: 'Dashboard',
              bottomNavigationBar: BottomNavigationBar(
                //backgroundColor: Colors.red,
                //type: BottomNavigationBarType.shifting,
                landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
//                      backgroundColor: Colors.blue.shade600,
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Irvine',
                  ),
                  BottomNavigationBarItem(
                    icon: delta.AnimatedBadge(
                      label: '2',
                      child: Icon(Icons.assignment),
                    ),
                    label: 'Accept Order',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant),
                    label: 'Kitchen',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fact_check),
                    label: 'Ready board',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.delivery_dining),
                    label: 'Delivery',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chair_alt),
                    label: 'Table',
                  ),
                ],
                currentIndex: 0,
//                  selectedItemColor: Colors.amber[800],
//                  fixedColor: Colors.black,
                onTap: (int index) {},
              ),
              child: const TabBarView(
                children: [
                  Overview(),
                  AcceptOrder(),
                  Kitchen(),
                  ReadyBoard(),
                  Delivery(),
                  Tables(),
                ],
              ),
            ) // Complete this code in the next step.
            ));
  }
}

/// startScreen will prepare provider and start dashboard screen
Widget startScreen(BuildContext context) {
  return MultiProvider(providers: [
    ChangeNotifierProvider<DashboardScreenProvider>(
      create: (_) => DashboardScreenProvider(),
    ),
  ], child: const DashboardScreen());
}


/*
 CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Articles',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.cabin_outlined),
                        label: 'Views',
                      ),
                    ],
                  ),
                  tabBuilder: (BuildContext context, int index) {
                    return CupertinoTabView(
                      builder: (BuildContext context) {
                        return CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                            middle: Text('Page 1 of tab $index'),
                          ),
                          child: Center(
                            child: CupertinoButton(
                              child: const Text('Next page'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return CupertinoPageScaffold(
                                        navigationBar: CupertinoNavigationBar(
                                          middle: Text('Page 2 of tab $index'),
                                        ),
                                        child: Center(
                                          child: CupertinoButton(
                                            child: const Text('Back'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
 */
/*                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.business),
                      label: 'Business',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      label: 'School',
                    ),
                  ],
                  currentIndex: 0,
                  selectedItemColor: Colors.amber[800],
                  onTap: (int index) {},
                ),
 */