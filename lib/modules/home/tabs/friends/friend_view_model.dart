import 'dart:async';
import 'dart:developer';

import 'package:s_crypto/data/models/user.dart';
import 'package:s_crypto/data/repositories/repositories.dart';
import 'package:s_crypto/di/service_locator.dart';
import 'package:s_crypto/modules/base/base.dart';

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
