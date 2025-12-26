import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle() => state = !state;
  void show() => state = true;
  void hide() => state = false;
}

final appBarVisibilityProvider =
    NotifierProvider<AppBarVisibilityNotifier, bool>(
  AppBarVisibilityNotifier.new,
);
