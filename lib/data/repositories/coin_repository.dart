import 'package:dio/dio.dart';
import 'package:flutter_boiler/data/api/api.dart';
import 'package:flutter_boiler/data/models/models.dart';

import '../../di/dio_exceptions.dart';

class CoinRepository {
  final CoinsApi coinsApi;

  CoinRepository(this.coinsApi);

  Future<List<CoinMarket>> getCoinMarket({
    currency = "usd",
    order = "market_cap_desc",
    perPage = 10,
    page = 1,
    sparkline = false,
  }) async {
    try {
      final queryParameters = {
        "vs_currency": currency,
        "order": order,
        "per_page": "$perPage",
        "page": "$page",
        "sparkline": "$sparkline"
      };

      final response = await coinsApi.getCoinMarket(queryParameters);
      List data = response.data;

      return data.map((e) => CoinMarket.fromJson(e)).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<CoinTrending>> getTrendingCoins() async {
    try {
      final response = await coinsApi.getTrendingCoins();

      final data = CoinTrendingResponse.fromJson(response.data);
      List<CoinTrending> result =
          data.coins!.map<CoinTrending>((e) => e.item!).toList();
      return result;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
