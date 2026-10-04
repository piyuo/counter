import 'package:intl/intl.dart';

/// Generates the current counting session and payload sequence.
///
/// Session format:
///   yyMMddHHmm
///
/// Example:
///   2606260923
///
/// Sequence starts at 1 for each new session.
class SessionCursor {
  SessionCursor();

  String session = buildSession();
  int _nextSequence = 0;

  /// Starts a new counting session.
  void reset() {
    session = buildSession();
    _nextSequence = 0;
  }

  /// Returns the next payload sequence within the current session.
  int nextSequence() => ++_nextSequence;
}

/// Builds a human-readable session identifier from the current business time.
///
/// Format:
///   yyMMddHHmm
///
/// Example:
///   2606260923
String buildSession() {
  return DateFormat('yyMMddHHmm').format(DateTime.now());
}
