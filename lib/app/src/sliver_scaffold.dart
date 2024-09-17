import 'package:flutter/material.dart';

/// SliverScaffold create scaffold with sliver appbar and sliver body
class SliverScaffold extends StatelessWidget {
  const SliverScaffold({
    required this.children,
    required this.appBar,
    this.backgroundColor,
    this.drawer,
    this.appBarPadding = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final List<Widget> children;

  final Color? backgroundColor;

  final SliverAppBar appBar;

  final EdgeInsets appBarPadding;

  final EdgeInsets padding;

  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer,
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: appBarPadding,
              sliver: appBar,
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                  childCount: 1,
                ),
              ),
            ),
          ],
        ));
  }
}
