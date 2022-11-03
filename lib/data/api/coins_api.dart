import 'package:dio/dio.dart';
import 'package:flutter_boiler/data/api/constant.dart';
import 'package:flutter_boiler/di/dio_client.dart';

// https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true
class CoinsApi {
  final DioClient dioClient;

  const CoinsApi(this.dioClient);

  Future<Response> getCoinMarket({
    currency = "usd",
    order = "market_cap_desc",
    perPage = 100,
    page = 1,
    sparkline = false,
  }) async {
    try {
      final Response response =
          await dioClient.get(ApiConstant.coinMarket, queryParameters: {
        "vs_currency": currency,
        "order": order,
        "per_page": "$perPage",
        "page": "$page",
        "sparkline": "$sparkline"
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
