import 'dart:async';

import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/l10n/vision_localization.dart';
import 'package:vision/vision.dart' as vision;

class BenchmarkScreen extends StatelessWidget {
  const BenchmarkScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l = VisionLocalization.of(context);
    return ChangeNotifierProvider<BenchmarkScreenProvider>(
      create: (_) {
        final projectProvider = app.ProjectProvider.of(context);
        return BenchmarkScreenProvider(projectProvider.benchmarkLocalStorage);
      },
      child: Consumer<BenchmarkScreenProvider>(
        builder: (context, benchmarkScreenProvider, child) {
          return pip.PipScaffold(
            action: CupertinoButton(
              child: Text(l.benchmark_screen_start_button),
              onPressed: () async {
                final errorCode = await benchmarkScreenProvider.doBenchmark();
                if (errorCode != 0 && context.mounted) {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        content: Text('${l.benchmark_screen_start_failed} $errorCode.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text(l.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.chart_bar, size: 44),
                        const SizedBox(height: 8.0),
                        Text('Benchmarks', style: const TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        title: Text(l.benchmark_screen_recommended),
                        additionalInfo: Text(vision.getModelName(benchmarkScreenProvider.recommendedModel)),
                      )
                    ],
                  ),
                  if (benchmarkScreenProvider.benchmarks.isNotEmpty)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      children: benchmarkScreenProvider.benchmarks.map((benchmark) {
                        return CupertinoListTile(
                          title: Text(vision.getModelName(benchmark.model)),
                          additionalInfo: Text('${benchmark.fps} ${l.benchmark_screen_fps}'),
                        );
                      }).toList(),
                    ),
                  if (benchmarkScreenProvider.isBenchmarkRunning)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CupertinoActivityIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide benchmark screen support
class BenchmarkScreenProvider with ChangeNotifier {
  BenchmarkScreenProvider(
    this.benchmarkLocalStorage,
  );

  /// benchmark local storage
  final app.BenchmarkLocalStorage benchmarkLocalStorage;

  /// true if the benchmark is running
  bool isBenchmarkRunning = false;

  /// The list of benchmarks
  List<app.Benchmark> get benchmarks {
    if (isBenchmarkRunning) {
      return benchmarkInRunning ?? [];
    }
    benchmarkLocalStorage.benchmarks.sort((a, b) => b.fps.compareTo(a.fps));
    return benchmarkLocalStorage.benchmarks;
  }

  /// The list of benchmarks in running
  List<app.Benchmark>? benchmarkInRunning;

  /// The recommended model
  vision.Models get recommendedModel => benchmarkLocalStorage.recommendedModel;

  /// Starts the benchmark process
  Future<int> doBenchmark() async {
    isBenchmarkRunning = true;
    notifyListeners();
    final errorCode = await benchmarkLocalStorage.doBenchmark(
      onSingleBenchmarkDone: (List<app.Benchmark> tempBenchmarks) {
        benchmarkInRunning = tempBenchmarks;
        notifyListeners();
      },
    );
    isBenchmarkRunning = false;
    benchmarkInRunning = null;
    notifyListeners();
    return errorCode;
  }
}
