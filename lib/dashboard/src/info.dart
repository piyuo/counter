import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget indicator({
      required String text,
      required String caption,
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(text, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(caption, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ));

    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        children: [
          indicator(
            text: '2',
            caption: 'Prepare',
            backgroundColor: Colors.grey.shade400,
          ),
          indicator(
            text: '3',
            caption: 'Ready',
            backgroundColor: Colors.grey.shade400,
          ),
          indicator(
            text: '2',
            caption: 'Dine in',
            backgroundColor: Colors.lightBlue.shade400,
          ),
          indicator(
            text: '6',
            caption: 'TO GO',
            backgroundColor: Colors.teal.shade300,
          ),
          indicator(
            text: '0',
            caption: 'Delivery',
            backgroundColor: Colors.amber.shade600,
          ),
          indicator(
            text: '4',
            caption: 'Staff',
            backgroundColor: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}
