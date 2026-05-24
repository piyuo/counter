// TOC:
//  - PipActionButton: standardized top-right action button for PipScaffold app bars

import 'package:flutter/material.dart';

class PipActionButton extends StatelessWidget {
  const PipActionButton({
    required this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.only(right: 16),
    this.backgroundColor = Colors.white70,
    this.foregroundColor = Colors.black87,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).shortestSide < 600;
    final buttonPadding = isCompact
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 0)
        : const EdgeInsets.symmetric(horizontal: 20, vertical: 12);

    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          tapTargetSize: isCompact ? MaterialTapTargetSize.shrinkWrap : MaterialTapTargetSize.padded,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
