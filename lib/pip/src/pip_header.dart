import 'package:flutter/cupertino.dart';

/// A header widget usually used in PipScaffold.
class PipHeader extends StatelessWidget {
  const PipHeader({
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
    this.showBottomBorder = true,
    super.key,
  });

  /// The child widget to display in the header.
  final Widget child;

  /// The padding to apply to the header.
  final EdgeInsetsGeometry padding;

  /// Whether to show the bottom border.
  final bool showBottomBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6.resolveFrom(context).withValues(alpha: 0.85),
        border: Border(
          top: BorderSide(
            color: CupertinoColors.opaqueSeparator.resolveFrom(context).withValues(alpha: 0.85),
            width: 1.0,
          ),
          bottom: showBottomBorder
              ? BorderSide(
                  color: CupertinoColors.opaqueSeparator.resolveFrom(context).withValues(alpha: 0.85),
                  width: 1.0,
                )
              : BorderSide.none,
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
