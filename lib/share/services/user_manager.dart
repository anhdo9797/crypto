import 'dart:async';

import 'package:flutter_boiler/data/models/user.dart';
import 'package:rxdart/subjects.dart';

class UserManager {
  static StreamController<UserModel> user = BehaviorSubject<UserModel>();

  void dispose() {
    user.close();
  }

  static changeUser(UserModel userParam) => user.sink.add(userParam);
}
