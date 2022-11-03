import 'package:dio/dio.dart';
import 'package:flutter_boiler/data/api/api.dart';
import 'package:flutter_boiler/data/models/models.dart';

import '../../di/dio_exceptions.dart';

class CoinRepository {
  final CoinsApi coinsApi;

  CoinRepository(this.coinsApi);

  /// return token
  Future<List<CoinMarket>> getCoinMarket() async {
    try {
      final response = await coinsApi.getCoinMarket();
      List data = response.data;

      return data.map((e) => CoinMarket.fromJson(e)).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
