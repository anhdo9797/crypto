import 'package:dio/dio.dart';
import 'package:flutter_boiler/data/local/pref.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('DIO REQUEST[${options.method}] => PATH: ${options.path}');
    if (AppPref.token != "") {}
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.headers.add("Content-Type", "application/json; charset=UTF-8");
    if (AppPref.token != "") {
      response.headers.add("'Authorization'", 'Bearer ${AppPref.token}');
    }
    print(
      'DIO RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    print('-------------BODY-------------------');
    print("${response.data}");

    print("-----------------------------");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'DIO ERROR[${err.response}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
