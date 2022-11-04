import 'package:flutter/material.dart';

import 'package:flutter_boiler/share/constants/colors.dart';
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
  if (value > 0) return AppColors.success;

  return AppColors.error;
}

String formatCurrency(num? value) {
  if (value == null) return "";
  final oCcy = NumberFormat("#,##0.00", "en_US");
  return '﹩ ${oCcy.format(value).replaceAll("-", "")}';
}

String getChartUrl(String? image) {
  if (image == null) return "";

  final parseUrl = image.split("/");
  final imageString = parseUrl.indexWhere((element) => element == "images");
  final imageNumber = parseUrl[imageString + 1];

  return "https://www.coingecko.com/coins/$imageNumber/sparkline";
}
