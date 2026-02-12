import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> _init() async {
    if (_initialized) return;

    if (!Platform.isLinux) {
      await _tts.setSpeechRate(0.9);
      await _tts.setPitch(1.0);
    }

    _initialized = true;
  }

  Future<void> speak(String text) async {
    try {
      await _init();

      if (Platform.isLinux) {
        await _speakLinux(text);
      } else {
        await _tts.stop();
        await _tts.speak(text);
      }
    } catch (e) {
      debugPrint('⛔ TTS error: $e');
    }
  }

  Future<void> stop() async {
    if (!Platform.isLinux) {
      await _tts.stop();
    }
  }

  Future<void> setLocale(String locale) async {
    if (!Platform.isLinux) {
      await _tts.setLanguage(locale);
    }
  }

  Future<void> _speakLinux(String text) async {
    try {
      await Process.run('spd-say', [text]);
    } catch (e) {
      debugPrint('⚠️ spd-say no disponible en Linux');
    }
  }
}
