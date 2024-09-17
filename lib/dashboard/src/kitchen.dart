import 'package:flutter/material.dart';
import 'ticket.dart';

final _scrollController = ScrollController();

class Kitchen extends StatelessWidget {
  const Kitchen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
      itemCount: 10,
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
//                childAspectRatio: 1.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == 7) {
          return const Column(children: [
            Divider(),
            Text('Later today'),
          ]);
        }
        return const Ticket();
      },
    );
  }
}
