// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sample_lib/delta/delta.dart' as delta;

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
          color: Colors.orange.shade600,
          padding: const EdgeInsets.all(10),
          child: const Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#1001',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '05:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'TO GO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Station',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ));
    }

    Widget checkItem() {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            leading: delta.RoundCheckbox(
              checked: false,
              onChanged: (bool value) {},
            ),
            title: const Text(
              '1 x Stuffed Quesadilla Taco',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ));
    }

    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          elevation: 8,
          child: Column(
            children: <Widget>[
              title(),
              checkItem(),
              const Divider(height: 1),
              checkItem(),
              const Divider(height: 1),
              checkItem(),
              const Divider(height: 1),
              checkItem(),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(8),
                child: OutlinedButton(
                  child: const Text('Ready', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey.shade800),
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.grey.shade50),
                    backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 56),
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }
}
