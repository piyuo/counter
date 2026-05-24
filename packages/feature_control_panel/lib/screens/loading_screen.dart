import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return Center(child: const GlassProgressIndicator.circular(color: Colors.white, strokeWidth: 4, size: 64));
      },
    );
  }
}
