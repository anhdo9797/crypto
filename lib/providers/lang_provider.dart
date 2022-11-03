import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/share/constants/constants.dart';

class LangProvider with ChangeNotifier {
  String _locale = "en";

  String get locale => _locale;

  String getCode() {
    return getLanguage().code ?? "US";
  }

  LangProvider() {
    _init();
  }

  Language getLanguage() {
    return AppLanguage.supportedLanguages[AppLanguage.supportedLanguages
        .indexWhere((language) => language.locale == _locale)];
  }

  void _init() async {
    if (AppPref.language != '') {
      _locale = AppPref.language;
    }
    log('LangProvider init');
  }

  void changeLanguage(String local) {
    _locale = local;
    AppPref.language = _locale;
    notifyListeners();
  }
}
