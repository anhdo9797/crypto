import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/share/constants/app_theme.dart';

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
    AppPref.isDarkMode = value;
    if (value) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    notifyListeners();
  }
}
