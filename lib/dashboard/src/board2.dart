import 'package:flutter/material.dart';

class Board2 extends StatelessWidget {
  const Board2({
    required this.leftTitle,
    required this.rightTitle,
    required this.leftColor,
    required this.rightColor,
    required this.leftChildren,
    required this.rightChildren,
    this.wrap = true,
    this.padding = const EdgeInsets.all(10),
    super.key,
  });

  final String leftTitle;

  final String rightTitle;

  final Color leftColor;

  final Color rightColor;

  final List<Widget> leftChildren;

  final List<Widget> rightChildren;

  final bool wrap;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    Widget part({
      required String title,
      required Color backgroundColor,
      required List<Widget> children,
    }) {
      return Expanded(
          child: Container(
        color: backgroundColor,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  )),
            ),
            const SizedBox(height: 10),
            if (wrap) Wrap(children: children),
            if (!wrap) ...children,
          ],
        ),
      ));
    }

    return Padding(
        padding: padding,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              part(
                title: leftTitle,
                backgroundColor: leftColor,
                children: leftChildren,
              ),
              const SizedBox(width: 10),
              part(
                title: rightTitle,
                backgroundColor: rightColor,
                children: rightChildren,
              ),
            ],
          ),
        ));
  }
}
