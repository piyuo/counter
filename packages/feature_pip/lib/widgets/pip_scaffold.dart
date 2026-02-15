import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;
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
    this.backgroundColor,
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

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(brightness: Brightness.dark),
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: getCupertinoListSectionBackgroundColor(context),
        body: SuperScaffold(
          appBar: SuperAppBar(
            previousPageTitle: previousPageTitle ?? context.l.back,
            backgroundColor:
                backgroundColor ?? CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.4),
            title: titleWidget ?? (title != null ? AutoSizeText(title!) : null),
            largeTitle: SuperLargeTitle(enabled: largeTitle != null, largeTitle: largeTitle ?? ''),
            actions: action,
            searchBar: SuperSearchBar(enabled: onSearch != null, animationBehavior: SearchBarAnimationBehavior.steady),
          ),
          body: child,
          // extra padding let user easy to tap button on the bottom
        ),
      ),
    );
  }
}

/// get Cupertino list section theme color
Color getCupertinoListSectionBackgroundColor(BuildContext context) {
  return CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.92);
}
