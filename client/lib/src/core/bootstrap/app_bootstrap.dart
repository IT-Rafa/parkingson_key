import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBootstrap {

  static Future<AppBootstrapData> init() async {

    await Hive.initFlutter();

    final prefs = await SharedPreferences.getInstance();

    return AppBootstrapData(
      sharedPrefs: prefs,
    );
  }
}

class AppBootstrapData {
  final SharedPreferences sharedPrefs;

  AppBootstrapData({
    required this.sharedPrefs,
  });
}