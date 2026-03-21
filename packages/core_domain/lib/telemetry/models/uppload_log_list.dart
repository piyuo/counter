// TOC:
//  - UpploadLogList: lightweight upload-log item for UI list rendering

/// Lightweight upload-log item used by UI list screens.
class UploadLogList {
  const UploadLogList({
    required this.id,
    required this.success,
    required this.datetime,
    required this.payloadSizeKb,
    required this.payloadCount,
    this.error,
  });

  /// Semantic upload-log ID (yyyyMMddHHs).
  final int id;

  /// Whether this upload attempt succeeded.
  final bool success;

  /// Attempt datetime converted to local time.
  final DateTime datetime;

  /// Serialized payload size sent in this attempt, rounded to KB.
  final int payloadSizeKb;

  /// Number of payload items included in this upload attempt.
  final int payloadCount;

  /// Machine-readable error code for failed attempts.
  final String? error;
}
