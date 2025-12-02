import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboards_provider.dart';
import 'package:parkingson_key/src/core/providers/selected_keyboard_id_provider.dart';
import 'package:parkingson_key/src/models/keyboard_layout_model.dart';

final keyboardProvider =
    Provider.family<KeyboardLayoutModel, Orientation>((ref, orientation) {
  final selectedId = ref.watch(selectedKeyboardIdProvider);
  final keyboards = ref.watch(keyboardsProvider);

  final selected = keyboards.firstWhere(
    (k) => k.id == selectedId,
    orElse: () => keyboards.first,
  );

  return selected; // devuelve el KeyboardLayoutModel completo
});

