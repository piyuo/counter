import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
  const TableItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.blue,
                child: const Center(child: Text('1', style: TextStyle(color: Colors.white))),
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.blue,
                child: const Text('2 People'),
              )
            ],
          ),
        ));
  }
}
