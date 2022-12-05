import 'package:dio/dio.dart';
import 'package:s_crypto/data/api/api.dart';
import 'package:s_crypto/data/repositories/coin_repository.dart';
import 'package:s_crypto/data/repositories/repositories.dart';
import 'package:s_crypto/share/services/user_manager.dart';
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

  // getIt.registerSingletonAsync<AblyService>(() => AblyService.init());
}
