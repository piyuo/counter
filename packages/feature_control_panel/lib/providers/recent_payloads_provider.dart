// TOC:
// - recentPayloadsProvider: recent retained payloads for recent payload UI flows

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentPayloadsProvider = FutureProvider.autoDispose<List<core_domain.QueuedPayload>>((ref) async {
  return ref.read(core_domain.telemetryQueueRepositoryProvider).fetchRecent(daysBack: 7);
});
