// TOC:
//  - JsonPayloadSerializer: encodes payload batches as compact UTF-8 JSON

import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

/// Serializes a batch of [TelemetryPayload]s to a UTF-8 encoded JSON array.
class JsonPayloadSerializer implements core_domain.PayloadSerializer {
  const JsonPayloadSerializer();

  static final JsonUtf8Encoder _encoder = JsonUtf8Encoder();
  static const Set<String> _areaZeroDefaultKeys = {
    'passBy',
    'stay',
    'entry',
    'exit',
    'appear',
    'disappear',
    'occupancyAvg',
    'occupancyPeak',
    'dwellAvgSec',
    'dwellPeakSec',
  };

  @override
  String get contentType => 'application/json';

  @override
  Uint8List serialize(
    List<core_domain.TelemetryPayload> payloads, {
    required int schemaVersion,
    required String deviceId,
  }) {
    final payloadJson = payloads.map(_toTransportJson).toList(growable: false);

    final serialized = Uint8List.fromList(
      _encoder.convert({'schema': schemaVersion, 'deviceId': deviceId, 'payloads': payloadJson}),
    );

    assert(() {
      _debugLogPayloads(payloadJson, batchBytes: serialized.length, schemaVersion: schemaVersion, deviceId: deviceId);
      return true;
    }());

    return serialized;
  }

  Map<String, dynamic> _toTransportJson(core_domain.TelemetryPayload payload) {
    final normalized = jsonDecode(jsonEncode(payload.toJson())) as Map<String, dynamic>;
    return _roundJsonMap(normalized);
  }

  Map<String, dynamic> _roundJsonMap(Map<String, dynamic> json) {
    final rounded = {for (final entry in json.entries) entry.key: _roundJsonValue(entry.value, key: entry.key)};

    if (_isAreaJsonMap(rounded)) {
      rounded.removeWhere((key, value) => _areaZeroDefaultKeys.contains(key) && _isZeroNumber(value));
    }

    return rounded;
  }

  Object? _roundJsonValue(Object? value, {String? key}) {
    if (value is double) {
      return _roundDouble(value, decimals: _decimalsForKey(key));
    }

    if (value is Map<String, dynamic>) {
      return _roundJsonMap(value);
    }

    if (value is List) {
      return value.map((item) => _roundJsonValue(item)).toList(growable: false);
    }

    return value;
  }

  int _decimalsForKey(String? key) {
    switch (key) {
      case 'coverageRatio':
        return 2;
      case 'fps':
        return 1;
      case 'dwellAvgSec':
        return 1;
      default:
        return 2;
    }
  }

  double _roundDouble(double value, {required int decimals}) {
    if (!value.isFinite) {
      return value;
    }

    final factor = math.pow(10, decimals).toDouble();
    return (value * factor).round() / factor;
  }

  bool _isAreaJsonMap(Map<String, dynamic> map) => map.containsKey('areaId');

  bool _isZeroNumber(Object? value) => value is num && value == 0;

  void _debugLogPayloads(
    List<Map<String, dynamic>> payloads, {
    required int batchBytes,
    required int schemaVersion,
    required String deviceId,
  }) {
    final previewCount = math.min(3, payloads.length);
    final batchKb = batchBytes / 1024;
    final payloadPreview = List<String>.generate(previewCount, (i) {
      final jsonString = jsonEncode(payloads[i]);
      final jsonBytes = utf8.encode(jsonString).length;
      return '\n payload[$i]={bytes:$jsonBytes,json:$jsonString}';
    }).join(', ');
    final truncatedCount = payloads.length - previewCount;
    final truncatedSuffix = truncatedCount > 0 ? ', omitted=$truncatedCount' : '';

    appkit.logInfo(
      '[JsonPayloadSerializer] schema=$schemaVersion deviceId=$deviceId count=${payloads.length} bytes=$batchBytes kb=${batchKb.toStringAsFixed(2)} top=$previewCount $payloadPreview$truncatedSuffix',
    );
  }
}
