// TOC:
//  - UploadLog: persisted record of one upload attempt outcome

/// Persisted record of one upload attempt outcome.
///
/// Mirrors the worker-level status fields so UI/debug surfaces can inspect
/// historical upload behavior across app restarts.
class UploadLog {
  UploadLog({
    required this.id,
    required DateTime attemptedAtUtc,
    required this.success,
    required this.payloadSizeKb,
    this.payloadCount = 0,
    this.retryCount = 0,
    this.error,
  }) : attemptedAtUtc = attemptedAtUtc.toUtc();

  /// Generates a UTC-based upload-log ID with the format: yyyyMMddHHd
  ///
  /// Where [d] is the success digit:
  /// - 1: success
  /// - 0: failed
  ///
  /// Example: 20240515141 → May 15 2024, 14:00 UTC, success
  static int generateIdFromUtcTime(DateTime time, {required bool success}) {
    final utc = time.toUtc();

    const int yearMultiplier = 1000000; // yyyyMMddHH
    const int monthMultiplier = 10000; //   MMddHH
    const int dayMultiplier = 100; //       ddHH

    final hourKey = utc.year * yearMultiplier + utc.month * monthMultiplier + utc.day * dayMultiplier + utc.hour;

    return hourKey * 10 + (success ? 1 : 0);
  }

  /// UTC hour/status bucket key in format yyyyMMddHHs.
  final int id;

  /// UTC timestamp of the upload attempt.
  final DateTime attemptedAtUtc;

  /// Whether this attempt succeeded.
  final bool success;

  /// Payload size sent during this attempt, rounded to kilobytes.
  final int payloadSizeKb;

  /// Number of payload records included in this upload attempt.
  final int payloadCount;

  /// Number of retries attempted before this upload attempt.
  final int retryCount;

  /// Machine-readable error code from the failed attempt.
  final String? error;
}
