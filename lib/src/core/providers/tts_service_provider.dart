import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/services/tts_service.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

