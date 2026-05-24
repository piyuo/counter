import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

class NoCameraScreen extends StatelessWidget {
  const NoCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      title: context.l.no_camera_screen_title,
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.red,
                child: SelectableText(
                  context.l.no_camera_screen_body,
                  style: TextStyle(fontSize: 14.0, color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
