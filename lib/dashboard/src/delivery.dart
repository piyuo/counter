import 'package:flutter/material.dart';
import 'board2.dart';
import 'board_item.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
/*
    Widget deliveryBoard() => ;
    Widget tableBoard() => Board2(
          wrap: false,
          padding: EdgeInsets.zero,
          leftTitle: 'Empty Table',
          leftColor: Colors.lightBlue.shade50.withOpacity(0.5),
          leftChildren: [
            TableItem(),
            BoardItem(title: 'DE', text: '5101', color: Colors.amber.shade600),
            BoardItem(title: 'DE', text: '5101', color: Colors.amber.shade600),
          ],
          rightTitle: 'Occupied',
          rightColor: Colors.lightBlue.shade50,
          rightChildren: [
            BoardItem(title: 'DE', text: '5101', color: Colors.amber.shade600),
          ],
        );
*/
    return Board2(
      leftTitle: 'wait for delivery drivers',
      leftColor: Colors.amber.shade50.withOpacity(0.5),
      leftChildren: [
        BoardItem(title: 'DELIVERY', text: '5101', color: Colors.amber.shade600),
        BoardItem(title: 'DELIVERY', text: '5101', color: Colors.amber.shade600),
        BoardItem(title: 'DELIVERY', text: '5101', color: Colors.amber.shade600),
      ],
      rightTitle: 'in transit',
      rightColor: Colors.amber.shade50,
      rightChildren: [
        BoardItem(title: 'UBER #F123GB', text: '5101', color: Colors.amber.shade600),
      ],
    );
  }
}
