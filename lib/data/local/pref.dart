import 'package:flutter_boiler/data/local/local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static Future<SharedPreferences> get _instance async =>
      _prefInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefInstance;

  static Future<SharedPreferences?> init() async {
    _prefInstance = await _instance;
    return _prefInstance;
  }

  static removeToken() {
    _prefInstance!.remove(StorageString.token);
    // more key remove
  }

  static set token(String value) =>
      _prefInstance!.setString(StorageString.token, value);
  static String get token =>
      _prefInstance?.getString(StorageString.token) ?? "";

  static set language(String value) =>
      _prefInstance!.setString(StorageString.language, value);
  static String get language =>
      _prefInstance?.getString(StorageString.language) ?? "";

  static set firstInstall(bool value) =>
      _prefInstance!.setBool(StorageString.firstInstall, value);
  static bool get firstInstall =>
      _prefInstance?.getBool(StorageString.firstInstall) ?? true;

  static set isDarkMode(bool value) =>
      _prefInstance!.setBool(StorageString.isDark, value);
  static bool get isDarkMode =>
      _prefInstance?.getBool(StorageString.isDark) ?? true;
}
