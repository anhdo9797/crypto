import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';

class RegisterViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  FutureOr<void> init() {}
}
