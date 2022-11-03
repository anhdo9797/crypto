import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';
import 'package:flutter_boiler/share/services/user_manager.dart';

import '../data/repositories/user_repository.dart';
import '../di/service_locator.dart';

class AuthProvider with ChangeNotifier {
  final userRepository = getIt.get<UserRepository>();

  UserModel? _user;
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  bool _initialized = false;

  get user => _user;
  get authStatus => _authStatus;
  get initialized => _initialized;

  Future<AuthStatus> getMe() async {
    try {
      if (AppPref.token != '') {
        final user = await userRepository.getMe();
        UserManager.changeUser(user);
        _authStatus = AuthStatus.loggedIn;
      } else {
        _authStatus = AuthStatus.notLoggedIn;
      }
    } catch (e) {
      log("AuthProvider getMe: $e");
      _authStatus = AuthStatus.notLoggedIn;
    }

    _initialized = true;
    notifyListeners();

    return _authStatus;
  }

  Future login() async {
    _authStatus = AuthStatus.loggedIn;
    AppPref.token = "JWT";
    notifyListeners();
  }

  Future logOut() async {
    AppPref.removeToken();
    _authStatus = AuthStatus.notLoggedIn;
    notifyListeners();
    AppRouter.routes.goNamed(APP_PAGE.auth.toName);
  }
}
