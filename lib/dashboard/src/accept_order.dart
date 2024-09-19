import 'package:flutter/material.dart';
import 'package:libcli/delta/delta.dart' as delta;

import 'incoming.dart';

final _autoAcceptController = ValueNotifier<bool>(true);

class AcceptOrder extends StatelessWidget {
  const AcceptOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Wrap(
          children: [
            Incoming(),
            Incoming(),
            Incoming(),
            Incoming(),
          ],
        ),
        Card(
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          child: Row(
            children: [
              delta.Switching(
                controller: _autoAcceptController,
              ),
              const Text('Auto accept all orders'),
            ],
          ),
        ),
      ],
    );
  }
}
