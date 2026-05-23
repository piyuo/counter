// TOC:
//  - PipScaffold: ConsumerStatefulWidget that owns a ScrollController and wires it to PipNotifier
//  - _PipScaffoldState: creates, sends, disposes the ScrollController; listens to scrollEventBusProvider; uses PipAppBar

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:feature_pip/providers/pip_notifier.dart';
import 'package:feature_pip/providers/scroll_event_bus.dart';
import 'package:feature_pip/widgets/pip_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

const kScrollContentAppbarPadding = 52.0 + 10; // appbar height + some spacing

/// Picture in Picture screen scaffold that provides a managed [ScrollController]
/// to its [builder] and notifies [PipNotifier] of scroll activity.
class PipScaffold extends ConsumerStatefulWidget {
  const PipScaffold({
    required this.builder,
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
    return GlassContainer(
      useOwnLayer: false,
      quality: GlassQuality.standard,
      child: Scaffold(
        bottomNavigationBar: widget.bottomNavigationBar,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PipAppBar(
          title:
              widget.titleWidget ??
              (widget.title != null
                  ? AutoSizeText(widget.title!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                  : null),
          onSearch: widget.onSearch,
          actions: widget.action != null ? [widget.action!] : null,
        ),
        body: widget.builder(scrollController),
      ),
    );
  }
}
