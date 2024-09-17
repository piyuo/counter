import 'package:counter/app/app.dart' as routes;
import 'package:flutter/material.dart';

class MenuItem {}

class MenuLabel extends MenuItem {
  MenuLabel({required this.title, this.subtitle});

  final String title;

  final String? subtitle;
}

class MenuButton extends MenuItem {
  MenuButton({required this.title, this.icon, this.badge, this.link});

  final String title;

  final IconData? icon;

  final String? badge;

  final String? link;
}

class MenuDivider extends MenuItem {}

List<MenuItem> getMenu() {
  return [
    MenuButton(title: 'Dashboard', icon: Icons.dashboard, link: routes.dashboardPath),
    MenuButton(title: 'Orders', icon: Icons.receipt_long),
    MenuButton(title: 'Customers', icon: Icons.groups),
    MenuButton(title: 'Products', icon: Icons.fastfood),
    MenuButton(title: 'Promotions', icon: Icons.wallpaper),
    MenuButton(title: 'Reports', icon: Icons.trending_up),
    MenuDivider(),
    MenuLabel(title: 'Owner', subtitle: 'My Store'),
    MenuButton(title: 'Payouts', icon: Icons.account_balance),
    MenuButton(title: 'Analytics', icon: Icons.analytics),
    MenuButton(title: 'Settings', icon: Icons.settings),
    MenuDivider(),
    MenuLabel(title: 'Manager', subtitle: 'My Store'),
    MenuButton(title: 'All Orders', icon: Icons.receipt_long),
    MenuButton(title: 'All Customers', icon: Icons.groups),
    MenuButton(title: 'All Products', icon: Icons.fastfood),
    MenuButton(title: 'All Promotions', icon: Icons.wallpaper),
    MenuButton(title: 'All Reports', icon: Icons.trending_up),
  ];
}
