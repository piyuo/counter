// TOC:
//  - JsonPayloadSerializer: encodes payload batches as compact UTF-8 JSON

import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/foundation.dart';

/// Serializes a batch of [Observation]s to a UTF-8 encoded JSON array.
class JsonPayloadSerializer implements core_domain.PayloadSerializer {
  const JsonPayloadSerializer();

  static final JsonUtf8Encoder _encoder = JsonUtf8Encoder();

  @override
  String get contentType => 'application/json';

  @override
  Uint8List serialize(
    List<core_domain.Observation> observations, {
    required String deviceId, // the device ID to include in the payloads, e.g. "041bfec6-8923-4b09-be5f-0fd11d3df7f5"
    String? projectId, // the project ID to include in the payloads, e.g. "my-project-id", this value is from invitation
    String? assignId, // the assign ID to include in the payloads, e.g. "my-assign-id", this value is from invitation
  }) {
    final json = toJson(observations, deviceId: deviceId, projectId: projectId, assignId: assignId);
    final serialized = Uint8List.fromList(_encoder.convert(json));

    if (kDebugMode) {
      String text = _printJson(json);
      debugPrint(text);
    }
    return serialized;
  }

  /// Builds the JSON upload envelope before UTF-8 encoding.
  Map<String, dynamic> toJson(
    List<core_domain.Observation> observations, {
    required String deviceId,
    String? projectId,
    String? assignId,
  }) {
    final observationsJson = observations.map(_toTransportJson).toList(growable: false);
    return {
      'schema': core_domain.kSchemaVersion,
      'deviceId': deviceId,
      'projectId': ?projectId,
      'assignId': ?assignId,
      'observations': observationsJson,
    };
  }

  Map<String, dynamic> _toTransportJson(core_domain.Observation observation) {
    return jsonDecode(jsonEncode(observation.toJson())) as Map<String, dynamic>;
  }

  String _printJson(Map<String, dynamic> json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }
}
