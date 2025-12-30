import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

class TtsService {
  final FlutterTts _tts;
  final Logger _logger;

  bool _initialized = false;

  TtsService(this._tts, this._logger);

  /// Inicialización segura del plugin
  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    try {
      await _tts.awaitSpeakCompletion(true);
      _initialized = true;
      _logger.i('TTS initialized');
    } catch (e, s) {
      _logger.w('TTS init failed (will retry later)', error: e, stackTrace: s);
    }
  }

  /// Hablar texto
  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;

    await _ensureInitialized();

    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (e, s) {
      _logger.e('TTS speak error', error: e, stackTrace: s);
    }
  }

  /// Parar voz
  Future<void> stop() async {
    await _ensureInitialized();

    try {
      await _tts.stop();
    } catch (e, s) {
      _logger.w('TTS stop error', error: e, stackTrace: s);
    }
  }

  /// Cambiar idioma SOLO si está soportado
  Future<bool> safeSetLocale(String locale) async {
    await _ensureInitialized();

    try {
      final langs = await _tts.getLanguages;

      if (!langs.contains(locale)) {
        _logger.w('TTS locale not supported: $locale');
        return false;
      }

      await _tts.setLanguage(locale);
      _logger.i('TTS locale set: $locale');
      return true;
    } catch (e, s) {
      _logger.w(
        'TTS setLocale failed (plugin not ready yet)',
        error: e,
        stackTrace: s,
      );
      return false;
    }
  }
}
