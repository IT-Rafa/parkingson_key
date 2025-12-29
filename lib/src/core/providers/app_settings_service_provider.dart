import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/services/app_settings_service.dart';

// Providers de Riverpod para idioma y tema
// Provider del servicio (singleton)
final appSettingsServiceProvider = Provider((ref) {
  return AppSettingsService();
});
