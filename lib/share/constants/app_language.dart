import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/share/constants/assets.dart';

class AppLanguage {
  AppLanguage._();
  static const String defaultLocal = "en";
  static List<Language> supportedLanguages = [
    Language(
      code: 'US',
      locale: 'en',
      language: 'English',
      assetFlag: Assets.en,
    ),
    Language(
      code: 'VN',
      locale: 'vi',
      language: 'Tiếng Việt',
      assetFlag: Assets.vi,
    ),
    // the more lang
  ];

  static const List<Locale> supportLocale = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
    // the more locale
  ];

  static List<String?> localeSupport =
      supportedLanguages.map((e) => e.locale).toList();
}
