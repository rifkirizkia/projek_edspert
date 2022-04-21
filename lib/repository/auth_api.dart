import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constant/api_url.dart';

class AuthApi {
  Dio apiNormal() {
    BaseOptions dioOption = BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        responseType: ResponseType.json,
        headers: {"x-api-key": "18be70c0-4e4d-44ff-a475-50c51ece99a0"});
    Dio dio = Dio(dioOption);
    //jika terjadi kesalahan saat pengambilan data user maka tambahkan dio.httpClientAdapter
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  //agar bisa di akses beberapa kali tambahkan endpoint
  _getRequest({required String endpoint, param}) async {
    try {
      final dio = apiNormal();
      final res = await dio.get(endpoint, queryParameters: param);
      return res.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        print(e);
        print("timeout");
      }
    } catch (e) {
      print(e);
      print("eror");
    }
  }

  _postRequest({required String endpoint, body}) async {
    try {
      final dio = apiNormal();
      final res = await dio.post(endpoint, data: body);
      return res.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        print("timeout");
      }
    } catch (e) {
      print("eror");
    }
  }

  getUserByEmail(email) async {
    print(ApiUrl.users);
    final result =
        await _getRequest(endpoint: ApiUrl.users, param: {"email": email});
    print(print);
    return result;
  }

  Future<Map<String, dynamic>?> postRegisterUser(body) async {
    final result = await _postRequest(endpoint: ApiUrl.users, body: body);
    return result;
  }

  Future<Map<String, dynamic>?> getLatihanSoal(email) async {
    final result =
        await _getRequest(endpoint: ApiUrl.users, param: {"email": email});
    return result;
  }
}
