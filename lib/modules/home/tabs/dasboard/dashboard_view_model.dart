import 'dart:async';

import 'package:flutter_boiler/data/models/user.dart';

import 'package:flutter_boiler/modules/base/base.dart';

class DashboardViewModel extends BaseViewModel {
  @override
  bool isInitialized = true;
  List<UserModel> users = [];

  @override
  FutureOr<void> init() async {}
}
