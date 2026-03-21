// TOC:
//  - UploadLogsDisplay: read-only status view for the most recent UploadWorker run
//
// Display rules:
//  - No upload yet         → single "No upload yet" row; nothing else shown.
//  - Last upload succeeded → time of upload with a green icon; no error rows.
//  - Last upload failed    → red row with time, error code, detail, client-error badge,
//                              and either a next-retry time or a next-cadence hint.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UploadLogsDisplay extends StatelessWidget {
  const UploadLogsDisplay({
    this.lastUploadTimeUtc,
    this.isLastUploadSuccess,
    this.lastError,
    this.lastErrorDetail,
    this.lastClientError,
    super.key,
  });

  /// UTC timestamp of the most recent upload attempt (success or failure).
  final DateTime? lastUploadTimeUtc;

  /// Outcome of the most recent attempt; null means no attempt has happened yet.
  final bool? isLastUploadSuccess;

  /// Machine-readable error code (e.g. `transport_exception`).
  final String? lastError;

  /// Human-readable error detail.
  final String? lastErrorDetail;

  /// `true` = 4xx client error, `false` = network / server error.
  final bool? lastClientError;

  @override
  Widget build(BuildContext context) {
    // ── No upload yet ──────────────────────────────────────────────────────
    if (lastUploadTimeUtc == null) {
      return _StatusRow(icon: Icons.cloud_off_outlined, color: Colors.grey, label: 'No upload yet');
    }

    final timeLabel = _formatTime(lastUploadTimeUtc!.toLocal());

    // ── Success ────────────────────────────────────────────────────────────
    if (isLastUploadSuccess == true) {
      return _StatusRow(icon: Icons.cloud_done_outlined, color: Colors.green, label: 'Uploaded at $timeLabel');
    }

    // ── Failure ────────────────────────────────────────────────────────────
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StatusRow(icon: Icons.cloud_off_outlined, color: Colors.red, label: 'Failed at $timeLabel'),
        if (lastError != null) _DetailRow(icon: Icons.error_outline, text: lastError!),
        if (lastErrorDetail != null) _DetailRow(icon: Icons.info_outline, text: lastErrorDetail!),
        if (lastClientError == true) _DetailRow(icon: Icons.report_outlined, text: 'Client error (4xx)'),
        const _DetailRow(icon: Icons.timelapse, text: 'Will retry at next scheduled upload'),
      ],
    );
  }

  static String _formatTime(DateTime local) {
    final now = DateTime.now();
    final isToday = local.year == now.year && local.month == now.month && local.day == now.day;
    return isToday ? DateFormat.jm().format(local) : DateFormat.MMMd().add_jm().format(local);
  }
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.icon, required this.color, required this.label});

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Flexible(
          child: Text(label, style: TextStyle(color: color)),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 6),
          Flexible(
            child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
