import 'dart:io' show Platform, Process;
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // reemplaza printTime
    ),
    level: kDebugMode ? Level.debug : Level.off, // reemplaza Level.nothing
  );

  TtsService() {
    if (_isFlutterTtsSupported()) {
      _flutterTts.setLanguage("es-ES");
      _flutterTts.setSpeechRate(0.5);
      _flutterTts.setPitch(1.0);
    }
  }

  bool _isFlutterTtsSupported() {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS || Platform.isWindows || Platform.isMacOS;
  }

  bool _isLinux() => !kIsWeb && Platform.isLinux;

  Future<void> speak(String text) async {
    if (text.isEmpty) return;

    if (_isFlutterTtsSupported()) {
      _logger.d("TTS (flutter_tts) hablando: $text");
      await _flutterTts.stop();
      await _flutterTts.speak(text);
    } else if (_isLinux()) {
      _logger.d("TTS Linux (espeak) hablando: $text");
      try {
        await Process.run('espeak', [text]);
      } catch (e) {
        _logger.w("No se pudo ejecutar espeak en Linux: $e");
      }
    } else if (kIsWeb) {
      _logger.w("TTS no soportado en Web");
    } else {
      _logger.w("TTS no soportado en esta plataforma");
    }
  }

  Future<void> stop() async {
    if (_isFlutterTtsSupported()) {
      await _flutterTts.stop();
    }
  }
}
