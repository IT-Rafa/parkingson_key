import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _appBarKey = 'show_app_bar';

class AppBarVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() {
    _load();
    return true; // valor inicial estable
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_appBarKey) ?? true;
  }

  Future<void> toggle() async {
    final newValue = !state;
    state = newValue;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_appBarKey, newValue);
  }
}

final appBarVisibilityProvider =
    NotifierProvider<AppBarVisibilityNotifier, bool>(
      AppBarVisibilityNotifier.new,
    );
