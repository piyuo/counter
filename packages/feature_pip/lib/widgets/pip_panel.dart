import 'package:flutter/material.dart';

class PipPanel extends StatelessWidget {
  const PipPanel({
    required this.child,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    this.backgroundColor,
    super.key,
  });

  /// The child widget to display in the header.
  final Widget child;

  /// The padding to apply to the header.
  final EdgeInsetsGeometry padding;

  /// The padding to apply to the header.
  final EdgeInsetsGeometry margin;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Material(
        color: backgroundColor ?? Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
