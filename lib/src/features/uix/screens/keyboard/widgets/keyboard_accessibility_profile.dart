class KeyboardAccessibilityProfile {
  final String name;
  final Duration acceptHoldDuration;
  final Duration repeatBlockDuration;
  final bool hapticEnabled;

  const KeyboardAccessibilityProfile({
    required this.name,
    required this.acceptHoldDuration,
    required this.repeatBlockDuration,
    required this.hapticEnabled,
  });
}
