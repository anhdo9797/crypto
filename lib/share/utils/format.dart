import 'package:flutter/material.dart';

import 'package:flutter_boiler/share/constants/constants.dart';
import 'package:intl/intl.dart';

/// coin handler
String fixedPercentage(num? value, {fractionDigits = 2}) =>
    "${fixedNumber(value)}%";

String fixedNumber(num? value, {fractionDigits = 2}) {
  if (value == null) return "";
  return value.toStringAsFixed(fractionDigits).replaceAll("-", "");
}

Color getColorPercentage(num? value) {
  if (value == null) return Colors.white;
  if (value > 0) return successColor;

  return errorColor;
}

String formatCurrency(num? value) {
  if (value == null) return "";
  final oCcy = NumberFormat("#,##0.00", "en_US");
  return '＄ ${oCcy.format(value).replaceAll("-", "")}';
}

String getChartUrl(String? image) {
  if (image == null) return "";

  final parseUrl = image.split("/");
  final imageString = parseUrl.indexWhere((element) => element == "images");
  final imageNumber = parseUrl[imageString + 1];

  return "https://www.coingecko.com/coins/$imageNumber/sparkline";
}

final _vietnameseRegex = <RegExp>[
  RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
  RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
  RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
  RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
  RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
  RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
  RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
  RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
  RegExp(r'ì|í|ị|ỉ|ĩ'),
  RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
  RegExp(r'đ'),
  RegExp(r'Đ'),
  RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
  RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
];
toLowerCaseNonAccentVietnamese(String str) {
  str = str.toLowerCase();

  _vietnameseRegex.forEach((element) {
    str = str.replaceAll(element, "");
  });

  return str.toUpperCase();
}
