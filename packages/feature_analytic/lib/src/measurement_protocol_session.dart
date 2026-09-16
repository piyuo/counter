import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'predefined_events.dart';

/// A pure-HTTP client for the [GA4 Measurement Protocol]
/// (https://developers.google.com/analytics/devguides/collection/protocol/ga4).
///
/// Has no dependency on Firebase, so it works identically on every platform,
/// including Windows and Linux where Firebase Analytics is unavailable.
class MeasurementProtocolSession {
  MeasurementProtocolSession(this.measurementId, this.apiSecret, this.userId, [this.useValidationServer = false]) {
    _sessionId = sessionStarted.toIso8601String();
  }

  final String measurementId;
  final String apiSecret;
  final String userId;

  final DateTime sessionStarted = DateTime.now().toUtc();
  String get sessionId => _sessionId;
  String _sessionId = '';

  /// If true, events are sent to GA4's debug/validation endpoint instead of the
  /// real collection endpoint.
  /// https://developers.google.com/analytics/devguides/collection/protocol/ga4/validating-events
  final bool useValidationServer;

  /// Sends an event to the analytics service.
  /// [eventName] is the name of the event. Max length is 40 characters.
  /// [params] is a Map of additional parameters to attach to the event.
  void sendEvent(String eventName, Map<String, Object?>? params) {
    assert(!reservedGa4Events.contains(eventName), '"$eventName" is a reserved GA4 event name');
    if (reservedGa4Events.contains(eventName)) return;
    assert(eventName.length <= 40, 'Event name should be at most 40 characters long');
    assert(
      eventName.isNotEmpty && RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(eventName),
      'Event name should start with a letter and contain only letters, numbers, and underscores.',
    );

    final defParams = <String, Object?>{
      'engagement_time_msec': DateTime.now().toUtc().difference(sessionStarted).inMilliseconds,
      'session_id': sessionId,
      ...?params,
    };

    final body = jsonEncode({
      'client_id': defaultTargetPlatform.name,
      'user_id': userId,
      'events': [
        {'name': eventName, 'params': defParams},
      ],
    });

    final headers = {
      'Content-Type': 'application/json',
      'Accept-Language': PlatformDispatcher.instance.locale.toLanguageTag(),
    };

    http.post(
      Uri.parse(
        'https://www.google-analytics.com/${useValidationServer ? 'debug/' : ''}mp/collect'
        '?measurement_id=$measurementId&api_secret=$apiSecret',
      ),
      headers: headers,
      body: body,
    );
  }
}
