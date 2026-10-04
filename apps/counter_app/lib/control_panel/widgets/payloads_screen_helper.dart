// TOC:
// - resendQueuedPayloads: shared resend flow for queued telemetry payloads

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

Future<bool> resendQueuedPayloads({
  required BuildContext context,
  required core_domain.TelemetryService telemetryService,
  required List<core_domain.QueuedPayload> payloads,
  String emptySelectionMessage = 'Select at least one payload first.',
}) async {
  if (payloads.isEmpty) {
    appkit.showMessage(message: emptySelectionMessage);
    return false;
  }

  try {
    final resendPayloads = payloads.map((pending) => pending.payload).toList(growable: false);
    final success = await telemetryService.sendNow(resendPayloads);

    if (!context.mounted) {
      return false;
    }

    if (!success) {
      if (telemetryService.lastError == null) {
        appkit.showMessage(message: 'Resend failed due to an unknown error.');
      } else {
        appkit.showMessage(message: 'Resend failed: ${telemetryService.lastError}');
      }
      return false;
    }

    appkit.showMessage(message: 'Resent ${resendPayloads.length} payload(s).');
    return true;
  } catch (error) {
    if (context.mounted) {
      appkit.showMessage(message: 'Resend failed: $error');
    }
    return false;
  }
}

String payloadDeliveryStatusDescription(BuildContext context, core_domain.QueuedPayload queued, DateFormat timeFmt) {
  if (queued.isUploaded) {
    return '${context.l.payloads_screen_delivered} ${timeFmt.format(queued.uploadedAtUtc!.toLocal())}';
  }
  return context.l.payloads_screen_pending;
}

String hourDeliveryStatusDescription(BuildContext context, core_domain.DeliveryHourGroup hourGroup) {
  final deliveredCount = hourGroup.deliveredCount;
  final totalCount = hourGroup.totalCount;

  switch (hourGroup.deliveryStatus) {
    case core_domain.DeliveryStatus.allDelivered:
      return '${context.l.payloads_screen_delivered} ($deliveredCount/$totalCount)';
    case core_domain.DeliveryStatus.partiallyDelivered:
      return '${context.l.payloads_screen_partially} ($deliveredCount/$totalCount)';
    case core_domain.DeliveryStatus.noneDelivered:
      return '${context.l.payloads_screen_pending} (0/$totalCount)';
  }
}

String dayDeliveryStatusDescription(BuildContext context, core_domain.DeliveryDateGroup dateGroup) {
  final deliveredCount = dateGroup.deliveredCount;
  final totalCount = dateGroup.totalCount;

  switch (dateGroup.deliveryStatus) {
    case core_domain.DeliveryStatus.allDelivered:
      return '${context.l.payloads_screen_delivered} ($deliveredCount/$totalCount)';
    case core_domain.DeliveryStatus.partiallyDelivered:
      return '${context.l.payloads_screen_partially} ($deliveredCount/$totalCount)';
    case core_domain.DeliveryStatus.noneDelivered:
      return '${context.l.payloads_screen_pending} (0/$totalCount)';
  }
}
