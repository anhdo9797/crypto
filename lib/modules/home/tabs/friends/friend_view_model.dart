import 'dart:async';
import 'dart:developer';

import 'package:flutter_boiler/data/models/user.dart';
import 'package:flutter_boiler/data/repositories/repositories.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';

class FriendsViewModel extends BaseViewModel {
  final userRepository = getIt.get<UserRepository>();

  @override
  bool isInitialized = true;
  List<UserModel> users = [];

  @override
  FutureOr<void> init() async {
    try {
      users = await userRepository.getUsersRequested();
      isInitialized = false;

      notifyListeners();
    } catch (e) {
      log('FriendsViewModelInit ERROR: $e');
    }
  }
}
