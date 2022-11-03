import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_boiler/modules/base/base.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  FutureOr<void> init() {}

  sendEmail() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;

      //re quest api
      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;
    }
  }
}
