/// kLogsLength is the max length of logs.
const kLogsLength = 50;

/// logs is a list of logs.
List logs = [];

/// Log entity to keep in logs
class Log {
  Log({
    required this.message,
    this.stacktrace,
  });

  /// message is the message of log
  final String message;

  /// stacktrace is the stacktrace when log is create by exception
  final String? stacktrace;

  /// when is the time when log is created
  final DateTime when = DateTime.now();
}

/// pushLog push a log to logs, logs can keep max 50 logs.
void pushLog({
  required String message,
  String? stacktrace,
}) {
  logs.insert(
      0,
      Log(
        message: message,
        stacktrace: stacktrace,
      ));
  if (logs.length > 50) {
    logs.removeLast();
  }
}

/// printLogs print all logs
String printLogs({int maxCount = 50}) {
  var buffer = StringBuffer();
  int index = 0;
  for (Log log in logs) {
    buffer.writeln('${log.when}: ${log.message}');
    if (log.stacktrace != null) {
      buffer.writeln(log.stacktrace);
    }
    buffer.writeln();
    if (index > maxCount) {
      break;
    }
    index++;
  }
  return buffer.toString();
}
