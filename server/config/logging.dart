import 'dart:io';
import 'package:logging/logging.dart';

/// Configures the root logger to print all records to stdout.
/// This is used by the server to emit structured console logs.
void setupLogging() {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    stdout.writeln('${record.time} '
        '[${record.level.name}] '
        '${record.loggerName}: '
        '${record.message}');
  });
}
