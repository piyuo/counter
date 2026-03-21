import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

class BuildInfoScreen extends ConsumerStatefulWidget {
  const BuildInfoScreen({super.key});

  @override
  ConsumerState<BuildInfoScreen> createState() => _BuildInfoScreenState();
}

class _BuildInfoScreenState extends ConsumerState<BuildInfoScreen> {
  String buildInfo = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = vision.getBuildInfo();
    debugPrint(info);
    setState(() {
      buildInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        controller: scrollController,
        child: Column(
          children: [
            feature_pip.PipHeader(icon: Icons.info_outline_rounded, title: "OpenCV Build"),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: SelectableText(buildInfo, style: TextStyle(fontSize: 14.0)),
            ),
          ],
        ),
      ),
    );
  }
}
