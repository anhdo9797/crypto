import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_crypto/data/local/pref.dart';
import 'package:s_crypto/share/constants/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    init();
  }

  get theme => _themeMode == ThemeMode.light
      ? AppThemeData.lightThemeData
      : AppThemeData.darkThemeData;
  get isDark => _themeMode == ThemeMode.dark;

  void init() {
    if (AppPref.isDarkMode) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void onChangeTheme(bool value) {
    log("Change theme: $value");
    AppPref.isDarkMode = value;
    if (value) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: value ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.green,
      ),
    );

    notifyListeners();
  }
}
