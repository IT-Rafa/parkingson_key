
enum HapticLevel { soft, strong }

class KeyboardAccessibilityProfile {
  final String name;                   // nombre del perfil
  final Duration acceptHoldDuration;   // tiempo mínimo para aceptar la pulsación
  final Duration repeatBlockDuration;  // bloqueo para evitar rebotes
  final bool hapticEnabled;            // activar/desactivar vibración
  final HapticLevel hapticLevel;       // intensidad de vibración

  const KeyboardAccessibilityProfile({
    required this.name,
    required this.acceptHoldDuration,
    required this.repeatBlockDuration,
    required this.hapticEnabled,
    required this.hapticLevel,
  });

  KeyboardAccessibilityProfile copyWith({
    String? name,
    Duration? acceptHoldDuration,
    Duration? repeatBlockDuration,
    bool? hapticEnabled,
    HapticLevel? hapticLevel,
  }) {
    return KeyboardAccessibilityProfile(
      name: name ?? this.name,
      acceptHoldDuration: acceptHoldDuration ?? this.acceptHoldDuration,
      repeatBlockDuration: repeatBlockDuration ?? this.repeatBlockDuration,
      hapticEnabled: hapticEnabled ?? this.hapticEnabled,
      hapticLevel: hapticLevel ?? this.hapticLevel,
    );
  }
}
