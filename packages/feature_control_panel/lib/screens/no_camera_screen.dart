import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoCameraScreen extends StatelessWidget {
  const NoCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      title: 'no camera detected',
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
                child: SelectableText(
                  "There is no camera detected on this device. Please connect a camera to use the app.\n"
                  "or you can use Live url or file to test the app.",
                  style: TextStyle(fontSize: 14.0, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
