import 'dart:io';
import 'package:logging/logging.dart';

void setupLogging() {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    stdout.writeln(
      '${record.time} '
      '[${record.level.name}] '
      '${record.loggerName}: '
      '${record.message}'
    );
  });
}