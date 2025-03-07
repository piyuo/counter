import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision/vision.dart' as vision;

/// benchmarkImagePath is the path of the image to be used for benchmarking.
const String benchmarkImagePath = 'assets/images/benchmark.jpg';

// Defines the minimum acceptable frames per second for the model benchmark
const int acceptableFPS = 20;

/// Class to hold the details of a model benchmark
class Benchmark {
  Benchmark({
    required this.model,
    required this.fps,
    required this.errorCode,
  });

  // The model to be benchmarked
  final vision.Models model;

  // The frames per second of the model
  final int fps;

  // The error code after run model
  final int errorCode;
}

/// Benchmark controller class
class BenchmarkController {
  BenchmarkController({
    this.onSingleBenchmarkDone,
  });

  /// Callback function to be called after a single benchmark is done
  final Function(List<Benchmark>)? onSingleBenchmarkDone;

  /// _cLib is the C++ library interface. no need to dispose it. it lifetime is the same as the app.
  final vision.Clib _cLib = vision.Clib();

  /// The recognition settings used by clib's controller. if null, it mean no settings provide and it is preview only mode
  final vision.Recognition _recognition = vision.Recognition();

  /// result is the benchmark result.
  List<Benchmark> benchmarks = [];

  // This function recommends a model based on the benchmarks
  // It first sorts the benchmarks, then selects the first model with a frames per second greater than or equal to the acceptable FPS
  // If no such model exists, it defaults to the ncnn_640 model
  vision.Models getRecommendedModel() {
    benchmarks.sort((a, b) => a.fps.compareTo(b.fps));
    final recommendedModel = benchmarks
        .firstWhere(
          (element) => element.fps >= acceptableFPS, // fps just greater than acceptableFPS will get better result
          orElse: () => benchmarks.last, // if no model is found, return the last one which is fastest model
        )
        .model;
    return recommendedModel;
  }

  void dispose() {
    _cLib.dispose();
    _recognition.dispose();
  }

  void initRecognition() async {
    final mediaWidth = 100;
    final mediaHeight = 100;
    final double reductionValue = min(mediaWidth * 0.1, mediaHeight * 0.1);

    final offsetX = reductionValue / 2;
    final offsetY = reductionValue / 2;
    final zoneId = 1;
    final zone = vision.VideoZone(
      tallyAnnotations: [],
      zoneId: zoneId,
      name: 'Zone1',
      color: Colors.blue,
      objectClasses: const [0, 1, 2],
      points: [
        Offset(offsetX, offsetY),
        Offset(mediaWidth - offsetX, offsetY),
        Offset(mediaWidth - offsetX, mediaHeight - offsetY),
        Offset(offsetX, mediaHeight - offsetY),
      ],
    );
    _recognition.setVideoZones([zone]);
  }

  /// Runs the benchmark on all models based on the image path
  Future<int> run() async {
    initRecognition();
    try {
      final imageFilePath = await writeFileFromAssets(benchmarkImagePath);
      final media = _cLib.openFile(imageFilePath);
      if (media.errorCode != vision.errorOK) {
        return media.errorCode;
      }

      // Run the benchmark on all models
      for (var model in vision.Models.values) {
        final benchmark = await runModel(model);
        benchmarks.add(benchmark);
        onSingleBenchmarkDone?.call(benchmarks);
        await Future.delayed(Duration(seconds: 1)); // cooldown to get more accurate fps
      }
      return vision.errorOK;
    } finally {
      _cLib.closeMedia();
      await removeFile(benchmarkImagePath);
    }
  }

  /// This function writes a file from the assets to a temporary directory and returns the file path
  Future<String> writeFileFromAssets(String path) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$path';
    final file = File(filePath);

    if (await file.exists()) {
      return filePath;
    }

    final byteData = await rootBundle.load('packages/vision/$path');
    final buffer = byteData.buffer;
    await file.create(recursive: true);
    await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return filePath;
  }

  /// This function removes a file from the temporary directory
  Future<void> removeFile(String path) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$path';
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Runs a model for benchmarking.
  Future<Benchmark> runModel(vision.Models model) async {
    await _recognition.loadModel(model);
    int errorCode = _cLib.setRecognition(_recognition);
    if (errorCode != vision.errorOK) {
      return Benchmark(model: model, fps: 0, errorCode: errorCode);
    }

    // warm up
    errorCode = _cLib.readFrame(-1);
    if (errorCode != vision.errorOK && errorCode != vision.errorEOF) {
      return Benchmark(model: model, fps: 0, errorCode: errorCode);
    }

    errorCode = _cLib.trackFrame();
    if (errorCode != vision.errorOK && errorCode != vision.errorEOF) {
      return Benchmark(model: model, fps: 0, errorCode: errorCode);
    }

    // for benchmark
    errorCode = _cLib.trackFrame();
    if (errorCode != vision.errorOK && errorCode != vision.errorEOF) {
      return Benchmark(model: model, fps: 0, errorCode: errorCode);
    }

    final fps = _recognition.fps;
    return Benchmark(model: model, fps: fps, errorCode: vision.errorOK);
  }
}

/// BenchmarkLocalStorage class to save and load benchmarks from local storage
class BenchmarkLocalStorage {
  /// Key for the benchmarks
  static const String _benchmarksKey = 'benchmark';

  /// Key for the recommended model
  static const String _recommendedModelKey = 'recommendedModel';

  /// List of benchmarks
  final List<Benchmark> benchmarks = [];

  /// Recommended model
  vision.Models? _recommendedModel;

  /// Returns the recommended model
  vision.Models get recommendedModel => _recommendedModel ?? vision.Models.ncnn_640;

  /// Initializes the benchmarks, load from local storage if available, otherwise do the benchmark
  Future<void> init() async {
    await load();
    if (benchmarks.isEmpty) {
      await doBenchmark();
    }
  }

  /// Saves the benchmarks to local storage
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final data = benchmarks.map((e) => '${e.model.index}:${e.fps}').join(',');
    await prefs.setString(_benchmarksKey, data);

    if (_recommendedModel != null) {
      await prefs.setInt(_recommendedModelKey, _recommendedModel!.index);
    }
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_benchmarksKey);
    if (data == null) {
      return;
    }
    final temp = data.split(',').map((e) {
      final parts = e.split(':');
      final model = vision.Models.values[int.parse(parts[0])];
      final fps = int.parse(parts[1]);
      return Benchmark(model: model, fps: fps, errorCode: vision.errorOK);
    }).toList();

    benchmarks.clear();
    benchmarks.addAll(temp);

    // load _recommendedModel

    final recommendedModelIndex = prefs.getInt(_recommendedModelKey);
    if (recommendedModelIndex != null) {
      _recommendedModel = vision.Models.values[recommendedModelIndex];
    }
  }

  /// Resets the benchmarks to current state
  Future<int> doBenchmark({Function(List<Benchmark>)? onSingleBenchmarkDone}) async {
    BenchmarkController benchmarkController = BenchmarkController(onSingleBenchmarkDone: onSingleBenchmarkDone);
    try {
      final errorCode = await benchmarkController.run();
      if (errorCode == vision.errorOK) {
        benchmarks.clear();
        benchmarks.addAll(benchmarkController.benchmarks);
        _recommendedModel = benchmarkController.getRecommendedModel();
        await save();
      }
      return errorCode;
    } finally {
      benchmarkController.dispose();
    }
  }
}
