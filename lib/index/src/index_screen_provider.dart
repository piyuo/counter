import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexScreenProvider extends ChangeNotifier {
  int current = 0;

  /// of get BranchModel from context
  static IndexScreenProvider of(BuildContext context) {
    return Provider.of<IndexScreenProvider>(context, listen: false);
  }

  /// scrollController is screen scroll controller
  final scrollController = ScrollController();
}
