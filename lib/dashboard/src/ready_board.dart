import 'package:flutter/material.dart';
import 'board2.dart';
import 'board_item.dart';

class ReadyBoard extends StatelessWidget {
  const ReadyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Board2(
      leftTitle: 'Preparing',
      leftColor: Colors.grey.shade50,
      leftChildren: [
        BoardItem(title: 'TOGO', text: '1101', color: Colors.teal.shade300),
        BoardItem(title: 'TABLE #12', text: '3101', color: Colors.lightBlue.shade400),
        BoardItem(title: 'UBER #F123GB', text: '5101', color: Colors.amber.shade600),
        BoardItem(title: 'TOGO', text: '1102', color: Colors.teal.shade300),
        BoardItem(title: 'TABLE #9', text: '3101', color: Colors.lightBlue.shade400),
        BoardItem(title: 'DoorDash #FW12d', text: '5101', color: Colors.amber.shade600),
        BoardItem(title: 'TOGO', text: '1103', color: Colors.teal.shade300),
        BoardItem(title: 'TABLE #11', text: '3101', color: Colors.lightBlue.shade400),
        BoardItem(title: 'DELIVERY', text: '5101', color: Colors.amber.shade600),
      ],
      rightTitle: 'Ready',
      rightColor: Colors.grey.shade100,
      rightChildren: [
        BoardItem(title: 'TOGO', text: '1101', color: Colors.teal.shade300),
        BoardItem(title: 'IN', text: '3101', color: Colors.lightBlue.shade400),
        BoardItem(title: 'DE', text: '5101', color: Colors.amber.shade600),
      ],
    );
  }
}
