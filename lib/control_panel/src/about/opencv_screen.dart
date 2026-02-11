import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpencvScreen extends StatelessWidget {
  const OpencvScreen({required this.scrollController, super.key});

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OpencvScreenProvider>(
      create: (_) => OpencvScreenProvider()..init(),
      child: Consumer<OpencvScreenProvider>(
        builder: (context, opencvScreenProvider, child) {
          return pip.PipScaffold(
            title: 'OpenCV',
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
                    child: SelectableText(
                      opencvScreenProvider.buildInfo,
                      style: TextStyle(fontSize: 14.0, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                    ),
                  ),
                  pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide opencv screen support
class OpencvScreenProvider with ChangeNotifier {
  OpencvScreenProvider();

  /// The build information.
  String buildInfo = '';

  /// Initialize the provider
  Future<void> init() async {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
