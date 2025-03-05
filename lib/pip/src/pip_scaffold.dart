import 'package:auto_size_text/auto_size_text.dart';
import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

/// Picture in Picture screen
class PipScaffold extends StatelessWidget {
  const PipScaffold({
    required this.child,
    this.action,
    this.titleWidget,
    this.title,
    this.largeTitle,
    this.onSearch,
    this.bottomNavigationBar,
    this.previousPageTitle,
    super.key,
  });

  /// the main screen
  final Widget child;

  /// action widget on the top right
  final Widget? action;

  /// the title on the top
  final String? title;

  /// the title widget on the top
  final Widget? titleWidget;

  /// the large title on the top
  final String? largeTitle;

  /// search callback
  final VoidCallback? onSearch;

  /// the bottom navigation bar
  final Widget? bottomNavigationBar;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: getCupertinoListSectionBackgroundColor(context),
        body: SuperScaffold(
          appBar: SuperAppBar(
            previousPageTitle: previousPageTitle ?? context.l.back,
            backgroundColor: CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.5),
            title: titleWidget ?? (title != null ? AutoSizeText(title!) : null),
            largeTitle: SuperLargeTitle(
              enabled: largeTitle != null,
              largeTitle: largeTitle ?? '',
            ),
            actions: action,
            searchBar: SuperSearchBar(
              enabled: onSearch != null,
              animationBehavior: SearchBarAnimationBehavior.steady,
            ),
          ),
          body: Material(
            // Wrap the child in Material to have a default background
            color: CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.5),
            child: child,
            // extra padding let user easy to tap button on the bottom
          ),
        ),
      ),
    );
  }
}

/// get Cupertino list section theme color
Color getCupertinoListSectionBackgroundColor(BuildContext context) {
//  return Colors.red;
  return CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.75);
}
