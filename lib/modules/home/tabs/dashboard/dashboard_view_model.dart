import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/services/user_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

final userMock = UserModel(
  avatar:
      "https://images.pexels.com/photos/13835274/pexels-photo-13835274.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  balance: 1021020.32,
  lastName: "Lyback",
  firstName: "Luck",
);

class DashboardViewModel extends BaseViewModel {
  @override
  bool isInitialized = true;
  List<UserModel> users = [];

  List<String> dropDown = ["USD", "Euro"];

  final CoinRepository coinRepository = getIt.get<CoinRepository>();

  List<CoinMarket> coins = [];

  @override
  FutureOr<void> init() async {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    await getCoins();
    //TODO: mock
    UserManager.changeUser(userMock);

    isInitialized = false;
    notifyListeners();
  }

  Future getCoins() async {
    // try {
    //   coins = await coinRepository.getCoinMarket();
    // } catch (e) {
    //   log("Get coins Error: $e");
    // }

    try {
      String response =
          await rootBundle.loadString('assets/mock/mock_market_coin.json');

      List<dynamic> result = json.decode(response);
      coins = result.map((n) => CoinMarket.fromJson(n)).toList();
    } catch (e) {
      throw e;
    }
  }
}
