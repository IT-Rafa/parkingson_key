import 'package:flutter/material.dart';
import 'haptic_feedback_service.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';

import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

// Import normal de AudioPlayer
import 'package:audioplayers/audioplayers.dart';

/// DummyAudioPlayer para Linux/Windows/macOS si falla reproducción
class DummyAudioPlayer {
  Future<void> play(dynamic _) async {}
}

class FeedbackService {
  static final dynamic _player = _initPlayer();

  static dynamic _initPlayer() {
    // Linux sin GStreamer: fallback Dummy
    if (defaultTargetPlatform == TargetPlatform.linux) {
      try {
        return AudioPlayer();
      } catch (_) {
        return DummyAudioPlayer();
      }
    }

    // Windows/macOS/Android/iOS/Web
    return AudioPlayer();
  }

  /// Reproduce vibración + sonido seguro
  /// Muestra aviso si no puede reproducir sonido en Linux/Windows/macOS
  static Future<void> accept({
    required ScaffoldMessengerState messenger,
    required KeyboardAccessibilityProfile profile,
  }) async {
    // 1️⃣ Vibración
    await HapticFeedbackService.tap(profile);

    if (kIsWeb) return; // Web ignora sonido

    // 2️⃣ Sonido seguro
    try {
      await _player.play(
        AssetSource('sounds/mouse-click.mp3'),
        volume: 0.4,
      );
    } catch (_) {
      // fallo runtime (Linux/Windows/macOS)
      messenger.removeCurrentSnackBar();
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'El sonido del teclado no está disponible.\n'
            'En Linux instala GStreamer 1.0 para habilitarlo.\n'
            'En Windows/macOS puede haber un fallo de audio.',
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }
}
