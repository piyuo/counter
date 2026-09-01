// TOC:
// - recentPayloadsProvider: recent retained payloads for recent payload UI flows

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentPayloadsProvider = StreamProvider.autoDispose<List<core_domain.QueuedPayload>>((ref) async* {
  final repository = ref.read(core_domain.telemetryQueueProvider);

  Future<List<core_domain.QueuedPayload>> safeFetch() async {
    return await repository.fetchRecent(daysBack: 7);
  }

  yield await safeFetch();
  await for (final _ in Stream.periodic(const Duration(minutes: 3))) {
    yield await safeFetch();
  }
});
