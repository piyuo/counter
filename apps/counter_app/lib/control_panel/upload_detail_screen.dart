// TOC:
// - UploadDetailScreen: details for one telemetry upload attempt

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

class UploadDetailScreen extends StatelessWidget {
  const UploadDetailScreen({required this.attemptedAtMs, required this.success, this.log, super.key});

  final int attemptedAtMs;
  final bool success;
  final core_domain.UploadLog? log;

  @override
  Widget build(BuildContext context) {
    final attemptedAtUtc = log?.attemptedAtUtc ?? DateTime.fromMillisecondsSinceEpoch(attemptedAtMs, isUtc: true);
    final local = attemptedAtUtc.toLocal();
    final locale = Localizations.localeOf(context).toString();
    final dayFmt = DateFormat.yMMMMd(locale);
    final timeFmt = DateFormat.jm(locale);

    final isSuccess = log?.success ?? success;
    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
          child: Column(
            children: [
              feature_pip.PipHeader(
                icon: success ? Icons.check_circle : Icons.error_outline,
                title: '${dayFmt.format(local)} ${timeFmt.format(local)}',
                subtitle: isSuccess ? context.l.upload_screen_success : context.l.upload_screen_failed,
              ),
              feature_pip.PipPanel(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: SelectableText(
                  _buildDetailText(
                    context,
                    attemptedAtLabel: '${dayFmt.format(local)} ${timeFmt.format(local)}',
                    resultLabel: isSuccess ? context.l.upload_screen_success : context.l.upload_screen_failed,
                    payloadSizeLabel: '${log?.payloadSizeKb ?? 0} ${context.l.upload_screen_size_kb}',
                    payloadCountLabel: log == null ? '-' : '${log!.payloadCount}',
                    retryCountLabel: log == null ? '-' : '${log!.retryCount}',
                    errorLabel: log?.error ?? '-',
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _buildDetailText(
    BuildContext context, {
    required String attemptedAtLabel,
    required String resultLabel,
    required String payloadSizeLabel,
    required String payloadCountLabel,
    required String retryCountLabel,
    required String errorLabel,
  }) {
    return [
      context.l.upload_screen_attempt_time,
      attemptedAtLabel,
      '',
      context.l.upload_screen_result,
      resultLabel,
      '',
      context.l.upload_screen_payload_size,
      payloadSizeLabel,
      '',
      context.l.upload_screen_payload_count_label,
      payloadCountLabel,
      '',
      context.l.upload_screen_retry,
      retryCountLabel,
      '',
      context.l.upload_screen_error,
      errorLabel,
    ].join('\n');
  }
}
