import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_boiler/data/api/constant.dart';

import '../../di/dio_client.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<Response> login(String email, String password) async {
    try {
      final Response response = await dioClient.post(
        ApiConstant.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addUserApi(String name, String job) async {
    try {
      final Response response = await dioClient.post(
        ApiConstant.users,
        data: {
          'name': name,
          'job': job,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUsersApi() async {
    try {
      final Response response = await dioClient.get(ApiConstant.users);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserApi(int id, String name, String job) async {
    try {
      final Response response = await dioClient.put(
        '${ApiConstant.users}/$id',
        data: {
          'name': name,
          'job': job,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserApi(int id) async {
    try {
      await dioClient.delete('${ApiConstant.users}/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMe() async {
    try {
      final Response response = await dioClient.get("${ApiConstant.users}/7");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
