// TOC:
//  - JsonPayloadSerializer: encodes payload batches as compact UTF-8 JSON

import 'dart:convert';
import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/foundation.dart';

/// Serializes a batch of [TelemetryPayload]s to a UTF-8 encoded JSON array.
class JsonPayloadSerializer implements core_domain.PayloadSerializer {
  const JsonPayloadSerializer();

  static final JsonUtf8Encoder _encoder = JsonUtf8Encoder();

  @override
  String get contentType => 'application/json';

  @override
  Uint8List serialize(
    List<core_domain.TelemetryPayload> payloads, {
    required int schemaVersion, // the json schema version to use for the payloads, e.g. 1
    required String deviceId, // the device ID to include in the payloads, e.g. "041bfec6-8923-4b09-be5f-0fd11d3df7f5"
    String? projectId, // the project ID to include in the payloads, e.g. "my-project-id", this value is from invitation
    String? assignId, // the assign ID to include in the payloads, e.g. "my-assign-id", this value is from invitation
  }) {
    final payloadJson = payloads.map(_toTransportJson).toList(growable: false);
    final json = {
      'schema': schemaVersion,
      'deviceId': deviceId,
      'projectId': ?projectId,
      'assignId': ?assignId,
      'payloads': payloadJson,
    };
    final serialized = Uint8List.fromList(_encoder.convert(json));

    if (kDebugMode) {
      String text = _printJson(json);
      debugPrint(text);
    }
    return serialized;
  }

  Map<String, dynamic> _toTransportJson(core_domain.TelemetryPayload payload) {
    final normalized = jsonDecode(jsonEncode(payload.toJson())) as Map<String, dynamic>;
    return _roundJsonMap(normalized);
  }

  Map<String, dynamic> _roundJsonMap(Map<String, dynamic> json) {
    return {for (final entry in json.entries) entry.key: _roundJsonValue(entry.value, key: entry.key)};
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
      case 'coverage':
        return 2;
      case 'fps':
        return 1;
      case 'avgDwellSec':
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

  String _printJson(Map<String, dynamic> json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }
}
