import 'package:dio/dio.dart';
import 'package:s_crypto/data/api/api.dart';
import 'package:s_crypto/data/models/models.dart';

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

  Future<MarketChartResponse> getMarketChart(id,
      {currency = "usd", days = 1, interval = "daily"}) async {
    final query = {
      "vs_currency": currency,
      "days": "$days",
      "interval": interval,
    };
    try {
      final response = await coinsApi.getMarketChart(id, query);
      final data = MarketChartResponse.fromJson(response.data);

      return data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // bitcoin/ohlc?vs_currency=usd&days=1
  Future<List> getOhlc(id, {currency = "usd", days = 7}) async {
    final query = {
      "vs_currency": currency,
      "days": "$days",
    };
    try {
      final response = await coinsApi.getOhlc(id, query);

      return response.data as List;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false
  Future<CoinDetail> getCoinDetail(
    id, {
    localization = "false",
    tickers = "false",
    market_data = "true",
    community_data = 'false',
    developer_data = "false",
    sparkline = "false",
  }) async {
    final query = {
      "localization": "false",
      "tickers": "false",
      "market_data": "true",
      "community_data": 'false',
      "developer_data": "false",
      "sparkline": "false",
    };
    try {
      final response = await coinsApi.getCoinDetail(id, query);

      return CoinDetail.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
