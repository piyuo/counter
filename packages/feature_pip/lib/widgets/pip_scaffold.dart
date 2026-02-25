import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:feature_pip/providers/pip_notifier.dart';
import 'package:feature_pip/providers/scroll_event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

// TOC:
//  - PipScaffold: ConsumerStatefulWidget that owns a ScrollController and wires it to PipNotifier
//  - _PipScaffoldState: creates, sends, disposes the ScrollController; listens to scrollEventBusProvider
//  - getCupertinoListSectionBackgroundColor: shared theme helper

/// Picture in Picture screen scaffold that provides a managed [ScrollController]
/// to its [builder] and notifies [PipNotifier] of scroll activity.
class PipScaffold extends ConsumerStatefulWidget {
  const PipScaffold({
    required this.builder,
    this.themeData = const CupertinoThemeData(brightness: Brightness.dark),
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

  /// the builder for the content of the screen, it provides a scroll controller for the content
  final Widget Function(ScrollController scrollController) builder;

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

  final CupertinoThemeData themeData;

  @override
  ConsumerState<PipScaffold> createState() => _PipScaffoldState();
}

class _PipScaffoldState extends ConsumerState<PipScaffold> {
  ScrollController scrollController = ScrollController();
  StreamSubscription<ScrollEvent>? _scrollSubscription;
  String? _routeName;
  PipController? pipController;
  @override
  void initState() {
    super.initState();
    final routeInfo = GoRouter.of(context).routeInformationProvider.value;
    _routeName = routeInfo.uri.path;

    _scrollSubscription = ref.read(scrollEventBusProvider).stream.listen((event) {
      if (event is ScrollToTopEvent && scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    });

    Future.microtask(() {
      pipController = ref.read(pipProvider.notifier);
      pipController!.clearScrollPosition(_routeName!);
    });
  }

  @override
  void dispose() {
    pipController?.clearScrollPosition(_routeName!);
    _scrollSubscription?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: widget.themeData,
      child: Builder(
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: widget.bottomNavigationBar,
            backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
            body: SuperScaffold(
              appBar: SuperAppBar(
                previousPageTitle: widget.previousPageTitle ?? context.l.back,
                backgroundColor: widget.backgroundColor ?? CupertinoColors.systemBackground.resolveFrom(context),
                title: widget.titleWidget ?? (widget.title != null ? AutoSizeText(widget.title!) : null),
                largeTitle: SuperLargeTitle(enabled: widget.largeTitle != null, largeTitle: widget.largeTitle ?? ''),
                actions: widget.action,
                searchBar: SuperSearchBar(
                  enabled: widget.onSearch != null,
                  animationBehavior: SearchBarAnimationBehavior.steady,
                ),
              ),
              body: widget.builder(scrollController),
            ),
          );
        },
      ),
    );
  }
}

/// get Cupertino list section theme color
Color getCupertinoListSectionBackgroundColor(BuildContext context) {
  return CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.92);
}
