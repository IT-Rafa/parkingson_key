import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

class TtsService {
  final FlutterTts _tts;
  final Logger _logger;
  bool _initialized = false;

  TtsService(this._tts, this._logger);

  Future<void> _init() async {
    if (_initialized) return;
    await _tts.awaitSpeakCompletion(true); // opcional, asegura secuencia
    _initialized = true;
  }

  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    await _init();
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<bool> safeSetLocale(String locale) async {
    await _init(); // <--- asegura que el plugin está listo
    final langs = await _tts.getLanguages;
    if (!langs.contains(locale)) {
      _logger.w('TTS locale not supported: $locale');
      return false;
    }
    await _tts.setLanguage(locale);
    _logger.i('TTS locale set: $locale');
    return true;
  }

  Future<void> stop() async {
    await _init();
    await _tts.stop();
  }
}
