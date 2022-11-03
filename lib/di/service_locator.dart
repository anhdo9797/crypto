import 'package:dio/dio.dart';
import 'package:flutter_boiler/data/api/api.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/data/repositories/repositories.dart';
import 'package:flutter_boiler/share/services/user_manager.dart';
import 'package:get_it/get_it.dart';

import 'dio_client.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  ///
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(UserManager());

  /// api and provider
  getIt.registerSingleton(UserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UserRepository(getIt.get<UserApi>()));

  getIt.registerSingleton(CoinsApi(getIt<DioClient>()));
  getIt.registerSingleton(CoinRepository(getIt.get<CoinsApi>()));
}
