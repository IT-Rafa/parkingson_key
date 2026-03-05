import 'package:hive_flutter/hive_flutter.dart';

class HiveService {

  static Future<Box<T>> openBox<T>(String name) async {

    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    }

    return await Hive.openBox<T>(name);
  }
}