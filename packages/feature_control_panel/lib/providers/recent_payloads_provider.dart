// TOC:
// - recentPayloadsProvider: recent retained payloads for recent payload UI flows

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentPayloadsProvider = StreamProvider.autoDispose<List<core_domain.QueuedPayload>>((ref) async* {
  final repository = ref.read(core_domain.telemetryQueueRepositoryProvider);

  Future<List<core_domain.QueuedPayload>> safeFetch() async {
    try {
      return await repository.fetchRecent(daysBack: 7);
    } catch (e, st) {
      appkit.logError(' Failed to fetch recent payloads $e $st');
    }
    return <core_domain.QueuedPayload>[];
  }

  yield await safeFetch();
  await for (final _ in Stream.periodic(const Duration(minutes: 3))) {
    yield await safeFetch();
  }
});
