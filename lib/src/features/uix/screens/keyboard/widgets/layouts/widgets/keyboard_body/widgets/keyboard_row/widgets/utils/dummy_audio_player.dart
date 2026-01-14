import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/core/services/haptic_feedback_service.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:audioplayers/audioplayers.dart';

/// DummyAudioPlayer para Linux sin GStreamer
class DummyAudioPlayer {
  Future<void> play(dynamic _) async {}
}

class FeedbackService {
  static final dynamic _player = _initPlayer();

  static dynamic _initPlayer() {
    if (defaultTargetPlatform == TargetPlatform.linux) {
      try {
        // intentamos instanciar AudioPlayer normal
        return AudioPlayer();
      } catch (_) {
        // fallback DummyAudioPlayer si no hay GStreamer
        return DummyAudioPlayer();
      }
    }
    return AudioPlayer();
  }

  static Future<void> accept({
    required ScaffoldMessengerState messenger,
    required KeyboardAccessibilityProfile profile,
  }) async {
    // Vibración
    await HapticFeedbackService.tap(profile);

    if (kIsWeb) return; // web ignora

    try {
      await _player.play(
        AssetSource('sounds/mouse-click.mp3'),
        volume: 0.4,
      );
    } catch (_) {
      // fallo runtime (Linux sin GStreamer)
      messenger.removeCurrentSnackBar();
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'El sonido del teclado no está disponible.\n'
            'En Linux, instala GStreamer 1.0 para habilitarlo.',
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }
}
