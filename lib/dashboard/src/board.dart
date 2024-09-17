import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  const Board({
    required this.title,
    required this.color,
    required this.child,
    this.padding = const EdgeInsets.all(10),
    super.key,
  });

  final String title;

  final Color color;

  final Widget child;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
/*    Widget part({
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
          ],
        ),
      ));
    }
*/
    return Padding(
        padding: padding,
        child: const IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [],
          ),
        ));
  }
}
