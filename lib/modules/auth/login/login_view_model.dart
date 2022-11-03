import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/data/repositories/repositories.dart';
import 'package:flutter_boiler/di/service_locator.dart';

import 'package:flutter_boiler/modules/base/base_view_model.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/services/user_manager.dart';
import 'package:flutter_boiler/share/utils/utils.dart';

class LoginViewModel extends BaseViewModel {
  final BuildContext buildContext;
  LoginViewModel(this.buildContext);

  final userRepository = getIt.get<UserRepository>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  FutureOr<void> init() {
    emailController.text = "eve.holt@reqres.in";
    passwordController.text = "Holt@eve123";
  }

  void onTapLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      try {
        final token = await userRepository.login(
          emailController.text,
          passwordController.text,
        );

        final user = await userRepository.getMe();
        UserManager.changeUser(user);

        if (token != "") AppPref.token = token;
        AppRouter.routes.goNamed(APP_PAGE.home.toName);
      } catch (e) {
        log("ERROR LOGIN: $e");
        AppFeedback.showSnackbar("$e");
      }

      isLoading = false;
    }
  }
}
