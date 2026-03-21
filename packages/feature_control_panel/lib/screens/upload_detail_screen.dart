// TOC:
// - UploadDetailScreen: details for one telemetry upload attempt

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                subtitle: isSuccess ? 'Success' : 'Failed',
              ),
              feature_pip.PipPanel(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: SelectableText(
                  _buildDetailText(
                    attemptedAtLabel: '${dayFmt.format(local)} ${timeFmt.format(local)}',
                    resultLabel: isSuccess ? 'Success' : 'Failed',
                    payloadSizeLabel: '${log?.payloadSizeKb ?? 0} KB',
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

  String _buildDetailText({
    required String attemptedAtLabel,
    required String resultLabel,
    required String payloadSizeLabel,
    required String payloadCountLabel,
    required String retryCountLabel,
    required String errorLabel,
  }) {
    return [
      'Attempt Time:',
      attemptedAtLabel,
      '',
      'Result:',
      resultLabel,
      '',
      'Payload Size:',
      payloadSizeLabel,
      '',
      'Payload Count:',
      payloadCountLabel,
      '',
      'Retry Count:',
      retryCountLabel,
      '',
      'Error:',
      errorLabel,
    ].join('\n');
  }
}
