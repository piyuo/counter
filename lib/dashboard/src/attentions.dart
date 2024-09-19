import 'package:flutter/material.dart';
import 'package:libcli/delta/delta.dart' as delta;

final _autoAcceptController = ValueNotifier<bool>(true);

class Attentions extends StatelessWidget {
  const Attentions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget indicator({
      required String label,
      required Widget child,
      required Color backgroundColor,
    }) =>
        Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.only(left: 10),
            color: backgroundColor,
            child: SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    child,
                    const SizedBox(height: 6),
                    Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ));

    return Row(
      children: [
        const Accept(),
        const SizedBox(width: 10),
        indicator(
          child: delta.Switching(
            controller: _autoAcceptController,
          ),
          label: 'TO GO',
          backgroundColor: Colors.teal.shade300,
        ),
        const SizedBox(width: 10),
        indicator(
          child: delta.Switching(
            controller: _autoAcceptController,
          ),
          label: 'Dine in',
          backgroundColor: Colors.lightBlue.shade400,
        ),
        const SizedBox(width: 10),
        indicator(
          child: delta.Switching(
            controller: _autoAcceptController,
          ),
          label: 'Delivery',
          backgroundColor: Colors.amber.shade600,
        ),
      ],
    );
  }
}

class Attention extends StatelessWidget {
  const Attention({
    required this.child,
    required this.label,
    super.key,
  });

  final Widget child;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}

class Accept extends StatelessWidget {
  const Accept({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(10),
      color: Colors.yellow.shade600,
      child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              delta.CountDown(
                duration: Duration(minutes: 2, seconds: 23),
              ),
              SizedBox(height: 10),
              Text('You have 3 new order >',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
    );
  }
}
