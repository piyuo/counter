import 'package:flutter/material.dart';
import 'recent.dart';
import 'attentions.dart';
import 'statistic.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const Attentions();
            case 1:
              return const Statistic();
            case 2:
              return const Recent();
          }
          return const SizedBox();
        });
  }
}
