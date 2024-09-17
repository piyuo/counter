// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sample_lib/delta/delta.dart' as delta;

final autoAcceptController = ValueNotifier<bool>(true);

class Incoming extends StatelessWidget {
  const Incoming({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.dining_rounded, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Dine in #1109',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800]!,
                          ),
                        ),
                      ),
                      const delta.CountDown(
                        duration: Duration(minutes: 2, seconds: 23),
                      ),
                    ],
                  ),
                  const Divider(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '地三鲜x1, 鱼香肉丝x1, 麻辣香锅x1, 回锅肉x1',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700]!,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 80,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '\$20.95',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]!,
                              ),
                            ),
                          )),
                    ],
                  ),
                  const Divider(height: 10),
                  Text(
                    'Table 11',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600]!,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        child: const Text('View', style: TextStyle(color: Colors.blue)),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          ),
                          foregroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      OutlinedButton(
                        child: Text('Reject', style: TextStyle(color: Colors.red.shade300)),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      OutlinedButton(
                        child: const Text('Accept', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
