// TOC:
//  - PipAppBar: GlassAppBar wrapper with automaticallyImplyLeading support

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass app bar for PIP screens.
///
/// Wraps [_AppBar] and adds [automaticallyImplyLeading]: when true (the
/// default) and no [leading] is provided, a back [GlassButton] is shown
/// automatically whenever the current route can be popped.
class PipAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PipAppBar({
    super.key,
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.onSearch,
    this.backgroundColor,
    this.preferredSize = const Size.fromHeight(68),
  });

  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// An explicit leading widget. When provided, [automaticallyImplyLeading]
  /// is ignored.
  final Widget? leading;

  /// Whether to show a back button automatically when the navigator can pop.
  ///
  /// Defaults to true.
  final bool automaticallyImplyLeading;

  /// Trailing action widgets rendered after the title.
  final List<Widget>? actions;

  /// When non-null, a search [GlassButton] is appended before [actions].
  final VoidCallback? onSearch;

  final Color? backgroundColor;

  @override
  final Size preferredSize;

  @override
  State<PipAppBar> createState() => _PipAppBarState();
}

class _PipAppBarState extends State<PipAppBar> {
  /// Guards against multiple `pop()` calls while the first pop is being
  /// processed. A second tap can otherwise occur before the navigation stack
  /// has finished updating, potentially causing:
  /// `GoError: There is nothing to pop`.
  ///
  /// No reset is needed: a successful `pop()` removes this screen (and this
  /// `PipAppBar` instance) from the tree, disposing this state along with it.
  bool _isPopping = false;

  void _handleBack(BuildContext context) {
    if (_isPopping) return;
    if (!context.canPop()) return;

    _isPopping = true;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading = widget.leading;

    if (effectiveLeading == null && widget.automaticallyImplyLeading) {
      if (context.canPop()) {
        effectiveLeading = Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GlassButton(
            width: 44,
            height: 44,
            icon: const Icon(Icons.arrow_back_ios_new),
            onTap: () => _handleBack(context),
          ),
        );
      }
    }

    final List<Widget> effectiveActions = [
      if (widget.onSearch != null)
        GlassButton(width: 44, height: 44, onTap: widget.onSearch!, icon: const Icon(Icons.search)),
      ...?widget.actions,
    ];

    return _AppBar(
      preferredSize: widget.preferredSize,
      title: widget.title,
      leading: effectiveLeading,
      backgroundColor: widget.backgroundColor,
      actions: effectiveActions.isEmpty ? null : effectiveActions,
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a glass app bar.
  const _AppBar({
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.preferredSize = const Size.fromHeight(44.0),
  });

  // ===========================================================================
  // Content Properties
  // ===========================================================================

  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget containing the page title.
  final Widget? title;

  /// A widget to display before the [title].
  ///
  /// Typically a [GlassButton] with a back arrow or menu icon.
  final Widget? leading;

  /// Widgets to display in a row after the [title].
  ///
  /// Typically [GlassButton] widgets for actions like search, share, etc.
  final List<Widget>? actions;

  final Color? backgroundColor;

  /// The height of the app bar.
  ///
  /// Defaults to 44.0 (iOS compact navigation bar height).
  /// For large titles, use 96.0 or higher.
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppBarThemeData appBarTheme = AppBarTheme.of(context);

    final TextStyle? effectiveTitleTextStyle = appBarTheme.titleTextStyle ?? theme.textTheme.titleLarge;

    final IconThemeData effectiveIconTheme = appBarTheme.iconTheme ?? theme.iconTheme;
    final IconThemeData effectiveActionsIconTheme = appBarTheme.actionsIconTheme ?? effectiveIconTheme;

    // Build the app bar content
    final appBarContent = SafeArea(
      child: Container(
        color: backgroundColor,
        height: preferredSize.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Title is centered relative to the full bar width
            if (title != null)
              Center(
                child: DefaultTextStyle.merge(style: effectiveTitleTextStyle ?? const TextStyle(), child: title!),
              ),

            // Leading and actions sit on top without affecting title position
            Row(
              children: [
                if (leading != null) IconTheme.merge(data: effectiveIconTheme, child: leading!),
                const Spacer(),
                if (actions != null)
                  IconTheme.merge(
                    data: effectiveActionsIconTheme,
                    child: Row(mainAxisSize: MainAxisSize.min, spacing: 8, children: actions!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );

    return appBarContent;
  }
}
