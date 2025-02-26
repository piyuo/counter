import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

class OpencvScreen extends StatelessWidget {
  const OpencvScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OpencvScreenProvider>(
      create: (_) => OpencvScreenProvider()..init(),
      child: Consumer<OpencvScreenProvider>(
        builder: (context, opencvScreenProvider, child) {
          return pip.PipScaffold(
            title: 'OpenCV',
            child: SingleChildScrollView(
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

  Future<void> init() async {
    buildInfo = _clib.getBuildInfo();
    notifyListeners();
  }

  @override
  void dispose() {
    _clib.dispose();
    super.dispose();
  }
}
