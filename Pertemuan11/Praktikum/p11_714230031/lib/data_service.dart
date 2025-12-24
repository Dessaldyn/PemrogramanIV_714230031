import 'user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String baseUrl = 'https://reqres.in/api/';

class DataService {
  Future<dynamic> getUsers() async {
    try {
      final res = await dio.get('/users');

      debugPrint('STATUS: ${res.statusCode}');
      debugPrint('DATA: ${res.data}');
      return res.data;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      final res = await dio.post(
        '/users',
        data: user.toMap(),
      );

      debugPrint('STATUS: ${res.statusCode}');
      debugPrint('DATA: ${res.data}');
      
      if (res.statusCode == 201) {
        return UserCreate.fromJson(res.data);
      }

      return null;
    } on DioException catch (e) {
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA: ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<UserCreate?> putUser(String idUser, String name, String job) async {
    try {
      final res = await dio.put(
        '/users/$idUser',
        data: {'name': name, 'job': job},
      );

      debugPrint('STATUS: ${res.statusCode}');
      debugPrint('DATA: ${res.data}');
      if (res.statusCode == 200) {
        return UserCreate.fromJson(res.data);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA: ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<dynamic> deleteUser(String idUser) async {
    try {
      final res = await dio.delete('/users/$idUser');

      debugPrint('STATUS: ${res.statusCode}');
      debugPrint('DATA: ${res.data}');
      if (res.statusCode == 204) {
        return 'Berhasil menghapus user';
      }
      return null;
    } on DioException catch (e) {
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA: ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<Iterable<User>?> getUserModel() async {
    try {
      final res = await dio.get('/users');

      if (res.statusCode == 200) {
        final users = (res.data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();
        return users;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA: ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }


final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://reqres.in/api/',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'x-api-key': 'reqres_bbca121c38f748198e21e44314b34e2b',
    },
  ),
);

}