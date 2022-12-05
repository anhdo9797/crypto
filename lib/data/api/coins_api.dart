import 'package:dio/dio.dart';
import 'package:s_crypto/data/api/constant.dart';
import 'package:s_crypto/di/dio_client.dart';

// https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true
class CoinsApi {
  final DioClient dioClient;

  const CoinsApi(this.dioClient);

  Future<Response> getCoinMarket(queryParameters) async {
    try {
      final Response response = await dioClient.get(ApiConstant.coinMarket,
          queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTrendingCoins() async {
    try {
      final Response response = await dioClient.get(ApiConstant.coinTrending);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMarketChart(String id, queryParameters) async {
    try {
      final Response response = await dioClient.get(ApiConstant.marketChart(id),
          queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getOhlc(String id, queryParameters) async {
    try {
      final Response response = await dioClient.get(ApiConstant.coinOhld(id),
          queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCoinDetail(String id, queryParameters) async {
    try {
      final Response response = await dioClient.get("${ApiConstant.coin}$id",
          queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
