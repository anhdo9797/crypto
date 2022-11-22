import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/utils/format.dart';

class AddWalletViewModel extends BaseViewModel {
  TextEditingController cardIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  FocusNode cvvFocus = FocusNode();

  String id = '';
  String name = "";
  String date = "";
  String ccv = "   ";

  bool isFront = true;

  @override
  FutureOr<void> init() {
    cardIdController.addListener(() {
      id = cardIdController.text;
      notifyListeners();
    });
    nameController.addListener(() {
      name = toLowerCaseNonAccentVietnamese(nameController.text);

      notifyListeners();
    });
    dateController.addListener(() {
      date = dateController.text;
      notifyListeners();
    });
    ccvController.addListener(() {
      ccv = ccvController.text;
      notifyListeners();
    });

    cvvFocus.addListener(() {
      isFront = !cvvFocus.hasFocus;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    cardIdController.dispose();
    dateController.dispose();
    nameController.dispose();
    cvvFocus.dispose();
    ccvController.dispose();
  }
}
