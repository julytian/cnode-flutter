import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}