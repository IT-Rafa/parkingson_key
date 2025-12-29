import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';
import 'package:parkingson_key/src/core/services/tts_service.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  final flutterTts = FlutterTts();
  final logger = Logger();

  final service = TtsService(flutterTts, logger);

  ref.onDispose(service.stop);

  return service;
});

