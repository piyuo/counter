import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

class OpencvScreen extends StatelessWidget {
  const OpencvScreen({
    required this.onScroll,
    super.key,
  });

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OpencvScreenProvider>(
      create: (_) => OpencvScreenProvider()..init(onScroll),
      child: Consumer<OpencvScreenProvider>(
        builder: (context, opencvScreenProvider, child) {
          return pip.PipScaffold(
            title: 'OpenCV',
            child: SingleChildScrollView(
              controller: opencvScreenProvider.scrollController,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
                    child: SelectableText(
                      opencvScreenProvider.buildInfo,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: CupertinoColors.secondaryLabel.resolveFrom(context),
                      ),
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
  /// The build information.
  String buildInfo = '';

  /// _cLib is the C++ library interface.
  final vision.Clib _clib = vision.Clib();

  /// The scroll controller
  ScrollController scrollController = ScrollController();

  Future<void> init(pip.ScrollCallback onScroll) async {
    buildInfo = _clib.getBuildInfo();
    scrollController.addListener(() {
      onScroll(scrollController);
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _clib.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
