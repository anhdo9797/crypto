import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:s_crypto/data/models/models.dart';
import 'package:s_crypto/data/repositories/coin_repository.dart';
import 'package:s_crypto/di/service_locator.dart';
import 'package:s_crypto/modules/base/base.dart';
import 'package:s_crypto/share/services/user_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

final userMock = UserModel(
  avatar:
      "https://images.pexels.com/photos/13835274/pexels-photo-13835274.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  balance: 1021020.32,
  lastName: "Lyback",
  firstName: "Luck",
);

class DashboardViewModel extends BaseViewModel {
  final CoinRepository coinRepository = getIt.get<CoinRepository>();

  @override
  bool isInitialized = true;
  bool isLoadingMarket = false;

  List<String> dropDown = ["USD", "Euro"];
  List<MarketFilterModel> filterMarket = [
    MarketFilterModel(key: "desc", value: "Price desc"),
    MarketFilterModel(key: "asc", value: "Price"),
    MarketFilterModel(key: "trend", value: "Trend"),
  ];

  List<CoinMarket> coins = [];
  List<CoinTrending> coinsTrending = [];

  String filterValue = "desc";

  @override
  FutureOr<void> init() async {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    //TODO: mock
    UserManager.changeUser(userMock);
    onRefreshCoin();
    getTrendingCoin();

    isInitialized = false;
    notifyListeners();
  }

  Future getTrendingCoin() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      String response =
          await rootBundle.loadString('assets/mock/mock_market_coin.json');

      List<dynamic> result = json.decode(response);

      coinsTrending = await coinRepository.getTrendingCoins();
    } catch (e) {
      throw e;
    }
  }

  /// Market handler
  int page = 1;
  Future getCoinsMarket() async {
    // try {
    // final res = await coinRepository.getCoinMarket(page: 1, order: filterValue);
    // if (res.isNotEmpty) {
    //   coins = [...coins, ...res];
    //   page++;
    // }
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

  onRefreshCoin() async {
    coins = [];
    page = 1;

    isLoadingMarket = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    await getCoinsMarket();

    isLoadingMarket = false;
    notifyListeners();
  }

  onFilter(MarketFilterModel? value) {
    if (value != null) {
      filterValue = value.key ?? "";
      onRefreshCoin();
    }
  }
}
