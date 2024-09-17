import 'package:flutter/material.dart';

class BoardItem extends StatelessWidget {
  const BoardItem({
    required this.title,
    required this.text,
    required this.color,
    this.name = 'Kevin Liu',
    super.key,
  });

  final String title;

  final String text;

  final String name;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Container(
      margin: const EdgeInsets.only(
        left: 10,
        top: 10,
      ),
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
      decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            color: color,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18))),
              const SizedBox(width: 6),
              const Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Text('03:22', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ))
            ],
          ),
          const Divider(height: 8),
          Row(children: [
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const VerticalDivider(width: 6),
            Text(name, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ]),
        ],
      ),
    ));
  }
}
