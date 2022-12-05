import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:s_crypto/modules/base/base.dart';
import 'package:s_crypto/share/utils/format.dart';

class AddWalletViewModel extends BaseViewModel {
  TextEditingController cardIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  FocusNode cvvFocus = FocusNode();

  String id = '';
  String name = "";
  String date = "";
  String cvv = "   ";
  String bankName = "";

  bool isFront = true;

  @override
  FutureOr<void> init() {
    // cardIdController.addListener(() {
    //   id = cardIdController.text;
    //   notifyListeners();
    // });
    // nameController.addListener(() {
    //   name = toLowerCaseNonAccentVietnamese(nameController.text);

    //   notifyListeners();
    // });
    // dateController.addListener(() {
    //   date = dateController.text;
    //   notifyListeners();
    // });
    // ccvController.addListener(() {
    //   ccv = ccvController.text;
    //   notifyListeners();
    // });

    cvvFocus.addListener(() {
      isFront = !cvvFocus.hasFocus;
      notifyListeners();
    });
  }

  /// on change text
  onChangeName(String? value) {
    name = toLowerCaseNonAccentVietnamese(value ?? "");
    notifyListeners();
  }

  onChangeCardId(String? value) {
    id = value ?? "";
    notifyListeners();
  }

  onChangeBankName(String? value) {
    bankName = value ?? "";
    notifyListeners();
  }

  onChangeCvv(String? value) {
    cvv = value ?? "";
    notifyListeners();
  }

  onChangeDate(String? value) {
    date = value ?? "";
    notifyListeners();
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
