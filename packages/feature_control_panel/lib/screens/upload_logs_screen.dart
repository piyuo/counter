// TOC:
// - UploadLogsScreen: upload log history grouped by day

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
      final dataServer = appState.dataServer;
      if (!dataServer.hasMadeDecision || dataServer is core_domain.NoDataServer) {
        if (!mounted) return;
        await showMessageDialog('Please set the Data Server first.');
        return;
      }
    } catch (error) {
      if (!mounted) return;
      await showMessageDialog('Unable to check Data Server: $error');
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
          await showMessageDialog('Upload failed due to an unknown error.');
        } else {
          await showMessageDialog('Upload failed: ${telemetryService.lastError}');
        }
        return;
      }
      await showMessageDialog('Uploaded payloads to remote server.');
    } catch (error) {
      if (!mounted) return;
      await showMessageDialog('Upload failed: $error');
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
    if (day == today) return 'Today';
    if (day == yesterday) return 'Yesterday';
    return DateFormat.yMMMMd().format(day);
  }

  String _formatAttemptTime(DateTime localDatetime) {
    return DateFormat.jm().format(localDatetime);
  }

  Widget _buildGroupedLogs(List<core_domain.UploadLogList> logs) {
    if (logs.isEmpty) {
      return feature_pip.PipPanel(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Text('No upload logs yet.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
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
                        Text('${entry.value[i].payloadCount} payloads, ${entry.value[i].payloadSizeKb}KB'),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                    onTap: () async {
                      final queue = ref.read(core_domain.telemetryQueueRepositoryProvider);
                      final fullLog = await queue.fetchUploadLogById(entry.value[i].id);
                      if (!mounted) return;
                      if (fullLog == null) {
                        await showMessageDialog('Upload log detail is no longer available.');
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
        label: _isUploading ? 'Uploading...' : 'Upload Now',
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
                  title: 'Upload Logs',
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
                          Text('Unable to load upload logs.', style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Text(
                            '${snapshot.error}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          TextButton(onPressed: _refreshRecentLogs, child: const Text('Retry')),
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
      return 'Next upload at ...';
    }

    return 'Next upload at ${DateFormat.jm().format(dt.toLocal())}';
  }
}
