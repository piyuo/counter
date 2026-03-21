// TOC:
// - resendQueuedPayloads: shared resend flow for queued telemetry payloads

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool> resendQueuedPayloads({
  required BuildContext context,
  required WidgetRef ref,
  required List<core_domain.QueuedPayload> payloads,
  String emptySelectionMessage = 'Select at least one payload first.',
}) async {
  if (payloads.isEmpty) {
    await showMessageDialog(emptySelectionMessage);
    return false;
  }

  try {
    final telemetryService = ref.read(core_domain.telemetryServiceProvider);
    final resendPayloads = payloads
        .map((pending) => pending.payload.copyWith(id: core_domain.generateTelemetryPayloadId()))
        .toList(growable: false);
    final success = await telemetryService.sendNow(resendPayloads);

    if (!context.mounted) {
      return false;
    }

    if (!success) {
      if (telemetryService.lastError == null) {
        await showMessageDialog('Resend failed due to an unknown error.');
      } else {
        await showMessageDialog('Resend failed: ${telemetryService.lastError}');
      }
      return false;
    }

    await showMessageDialog('Resent ${resendPayloads.length} payload(s).');
    return true;
  } catch (error) {
    if (context.mounted) {
      await showMessageDialog('Resend failed: $error');
    }
    return false;
  }
}
