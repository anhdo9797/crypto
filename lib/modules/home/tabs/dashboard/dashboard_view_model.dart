import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:webview_flutter/webview_flutter.dart';

Map<String, dynamic> mock = {
  "id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "image":
      "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
  "current_price": 20330,
  "market_cap": 390287211474,
  "market_cap_rank": 1,
  "fully_diluted_valuation": 426944748579,
  "total_volume": 44460374080,
  "high_24h": 20705,
  "low_24h": 20065,
  "price_change_24h": -141.04866974380275,
  "price_change_percentage_24h": -0.68903,
  "market_cap_change_24h": -2624000908.9853516,
  "market_cap_change_percentage_24h": -0.66784,
  "circulating_supply": 19196937,
  "total_supply": 21000000,
  "max_supply": 21000000,
  "ath": 69045,
  "ath_change_percentage": -70.55491,
  "ath_date": "2021-11-10T14:24:11.849Z",
  "atl": 67.81,
  "atl_change_percentage": 29881.70681,
  "atl_date": "2013-07-06T00:00:00.000Z",
  "last_updated": "2022-11-03T06:45:23.349Z",
};

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
