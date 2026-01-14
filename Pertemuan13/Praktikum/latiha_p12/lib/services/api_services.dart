import 'package:dio/dio.dart';
import 'package:latiha_p12/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:latiha_p12/model/login_model.dart'; 

class ApiServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://contactsapi-production.up.railway.app/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  
Future<List<ContactsModel>?> getAllContact() async {
    try {
      final response = await dio.get('/contacts');
      if (response.statusCode == 200) {
        final list = (response.data['data'] as List)
            .map((e) => ContactsModel.fromJson(e))
            .toList();
        return list;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    }
  }
  
Future<ContactResponse?> postContact(ContactInput ct) async {
    try {
      final response = await dio.post('/insert', data: ct.toJson());
      if (response.statusCode == 201) {
        return ContactResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    }
  }

Future<ContactsModel?> getSingleContact(String id) async {
    try {
      final response = await dio.get('/contacts/$id');
      if (response.statusCode == 200) {
        return ContactsModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    }
  }

  Future<ContactResponse?> putContact(String id, ContactInput ct) async {
    try {
      final response = await dio.put('/update/$id', data: ct.toJson());
      if (response.statusCode == 200) {
        return ContactResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    }
  }

  Future<ContactResponse?> deleteContact(String id) async {
    try {
      final response = await dio.delete('/delete/$id');
      if (response.statusCode == 200) {
        return ContactResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    }
  }

  Future<LoginResponse?> login(LoginInput login) async { 
    try { 
      final response = await dio.post( 
        '/login', 
        data: login.toJson(), 
      ); 
      if (response.statusCode == 200) { 
        return LoginResponse.fromJson(response.data); 
      } 
      return null; 
    } on DioException catch (e) { 
      if (e.response != null && e.response!.statusCode != 200) { 
        debugPrint('Client error - the request cannot be fulfilled'); 
        return LoginResponse.fromJson(e.response!.data); 
      } 
      rethrow; 
    } catch (e) { 
      rethrow; 
    } 
  } 

}