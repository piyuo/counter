// TOC:
// - UploadLogsScreen: upload log history grouped by day

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

class UploadLogsScreen extends ConsumerStatefulWidget {
  const UploadLogsScreen({super.key});

  @override
  ConsumerState<UploadLogsScreen> createState() => _UploadLogsScreenState();
}

class _UploadLogsScreenState extends ConsumerState<UploadLogsScreen> {
  bool _isUploading = false;
  late Future<List<core_domain.UploadLogList>> _recentLogsFuture;

  @override
  void initState() {
    super.initState();
    _recentLogsFuture = _loadRecentLogs();
  }

  Future<List<core_domain.UploadLogList>> _loadRecentLogs() {
    final queue = ref.read(core_domain.telemetryQueueRepositoryProvider);
    return queue.fetchRecentUploadLogs(daysBack: 7, limit: 24 * 7);
  }

  void _refreshRecentLogs() {
    setState(() {
      _recentLogsFuture = _loadRecentLogs();
    });
  }

  Future<void> _uploadNow() async {
    try {
      final appState = await ref.read(core_domain.appProvider.future);
      if (!mounted) return;
      if (appState.hasDataServer == false) {
        await showMessageDialog(context.l.upload_logs_screen_set_data_server_first_body);
        return;
      }
    } catch (error) {
      if (!mounted) return;
      await showMessageDialog('${context.l.upload_logs_screen_check_data_server_error_prefix}$error');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final telemetryService = ref.read(core_domain.telemetryServiceProvider);
      final success = await telemetryService.uploadNow();
      if (!mounted) return;
      if (!success) {
        if (telemetryService.lastError == null) {
          await showMessageDialog(context.l.upload_logs_screen_upload_failed_unknown);
        } else {
          await showMessageDialog('${context.l.upload_logs_screen_upload_failed_prefix}${telemetryService.lastError}');
        }
        return;
      }
      await showMessageDialog(context.l.upload_logs_screen_uploaded_success);
    } catch (error) {
      if (!mounted) return;
      await showMessageDialog('${context.l.upload_logs_screen_upload_failed_prefix}$error');
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
        _recentLogsFuture = _loadRecentLogs();
      }
    }
  }

  List<MapEntry<DateTime, List<core_domain.UploadLogList>>> _groupByDay(List<core_domain.UploadLogList> logs) {
    final grouped = <DateTime, List<core_domain.UploadLogList>>{};
    for (final log in logs) {
      final dayKey = DateTime(log.datetime.year, log.datetime.month, log.datetime.day);
      grouped.putIfAbsent(dayKey, () => <core_domain.UploadLogList>[]).add(log);
    }

    final days = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return days.map((day) => MapEntry(day, grouped[day]!)).toList(growable: false);
  }

  String _formatDayLabel(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (day == today) return context.l.upload_logs_screen_today_label;
    if (day == yesterday) return context.l.upload_logs_screen_yesterday_label;
    return DateFormat.yMMMMd().format(day);
  }

  String _formatAttemptTime(DateTime localDatetime) {
    return DateFormat.jm().format(localDatetime);
  }

  Widget _buildGroupedLogs(List<core_domain.UploadLogList> logs) {
    if (logs.isEmpty) {
      return feature_pip.PipPanel(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Text(
          context.l.upload_logs_screen_empty_body,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
      );
    }

    final groupedByDay = _groupByDay(logs);

    return Column(
      children: [
        for (final entry in groupedByDay) ...[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 8),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(_formatDayLabel(entry.key), style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          feature_pip.PipPanel(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              children: [
                for (var i = 0; i < entry.value.length; i++) ...[
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: Icon(
                      entry.value[i].success ? Icons.check_circle : Icons.error_outline,
                      size: 24,
                      color: entry.value[i].success ? Colors.green : Colors.red,
                    ),
                    title: Text(_formatAttemptTime(entry.value[i].datetime)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${entry.value[i].payloadCount} ${context.l.upload_logs_screen_payloads_unit}, ${entry.value[i].payloadSizeKb}KB',
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                    onTap: () async {
                      final queue = ref.read(core_domain.telemetryQueueRepositoryProvider);
                      final fullLog = await queue.fetchUploadLogById(entry.value[i].id);
                      if (!mounted) return;
                      if (fullLog == null) {
                        await showMessageDialog(context.l.upload_logs_screen_detail_unavailable_body);
                        return;
                      }
                      ref.push(core_domain.OpenUploadLogDetail(log: fullLog));
                    },
                  ),
                  if (i != entry.value.length - 1) const Divider(height: 1),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final telemetry = ref.watch(core_domain.telemetryServiceProvider);

    return feature_pip.PipScaffold(
      action: feature_pip.PipActionButton(
        label: _isUploading
            ? context.l.upload_logs_screen_uploading_action
            : context.l.upload_logs_screen_upload_now_action,
        onPressed: _isUploading ? null : _uploadNow,
      ),
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
          child: Column(
            children: [
              ValueListenableBuilder<DateTime?>(
                valueListenable: telemetry.nextUploadTimeListenable,
                builder: (context, nextUpload, child) => feature_pip.PipHeader(
                  icon: Icons.timelapse,
                  title: context.l.upload_logs_screen_title,
                  subtitle: _buildNextUploadLabel(nextUpload),
                ),
              ),
              FutureBuilder<List<core_domain.UploadLogList>>(
                future: _recentLogsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const feature_pip.PipPanel(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return feature_pip.PipPanel(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.l.upload_logs_screen_load_error, style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Text(
                            '${snapshot.error}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: _refreshRecentLogs,
                            child: Text(context.l.upload_logs_screen_retry_action),
                          ),
                        ],
                      ),
                    );
                  }

                  return _buildGroupedLogs(snapshot.data ?? const <core_domain.UploadLogList>[]);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _buildNextUploadLabel(DateTime? dt) {
    if (dt == null) {
      return context.l.upload_logs_screen_next_upload_pending;
    }

    return '${context.l.upload_logs_screen_next_upload_prefix}${DateFormat.jm().format(dt.toLocal())}';
  }
}
