import 'package:flutter/material.dart';
import 'package:sample_lib/charts/charts.dart' as charts;

class Statistic extends StatelessWidget {
  const Statistic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget section({
      required Widget child,
    }) =>
        Card(
            margin: const EdgeInsets.all(15),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child,
            ));

    Widget item(
      String text,
      String label,
    ) =>
        section(
            child: Column(
          children: [
            Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label),
          ],
        ));

    return Container(
        color: Colors.grey.shade100,
        child: Wrap(
          children: [
            item('15', 'Preparing'),
            item('5', 'Wait for Delivery'),
            item('2', 'Available Table'),
            section(
              child: const charts.TimeChart(title: 'Sales', subtitle: '\$35,500'),
            )
          ],
        ));
  }
}
