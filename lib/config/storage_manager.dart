import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// app全局配置 eg:theme
  static SharedPreferences sharedPreferences;

  /// 初始化必备操作 eg:user数据
  static LocalStorage localStorage;
  
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}
