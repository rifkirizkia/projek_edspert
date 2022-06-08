import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:projek_edspert/helpers/user_email.dart';
import '../constant/api_url.dart';
import '../models/network_response.dart';

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
  Future<NetworkResponse> _getRequest({required String endpoint, param}) async {
    try {
      final dio = apiNormal();
      final res = await dio.get(endpoint, queryParameters: param);
      return NetworkResponse.success(res.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> _postRequest({required String endpoint, body}) async {
    try {
      final dio = apiNormal();
      final res = await dio.post(endpoint, data: body);
      return NetworkResponse.success(res.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  getUserByEmail() async {
    print(ApiUrl.users);
    final result = await _getRequest(
        endpoint: ApiUrl.users, param: {"email": UserEmail.getUserEmail()});
    print(print);
    return result;
  }

  Future<NetworkResponse> postRegisterUser(body) async {
    final result =
        await _postRequest(endpoint: ApiUrl.userRegister, body: body);
    return result;
  }

  Future<NetworkResponse> postUpdateUser(body) async {
    final result =
        await _postRequest(endpoint: ApiUrl.userUpdateProfile, body: body);
    return result;
  }

  Future<NetworkResponse> getLatihanSoal(email) async {
    final result =
        await _getRequest(endpoint: ApiUrl.users, param: {"email": email});
    return result;
  }
  
}
