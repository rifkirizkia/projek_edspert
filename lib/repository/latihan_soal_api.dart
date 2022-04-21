import 'package:dio/dio.dart';

import '../constant/api_url.dart';

class LatihanSoalApi {
  Dio apiNormal() {
    BaseOptions dioOption = BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        responseType: ResponseType.json,
        headers: {"x-api-key": "18be70c0-4e4d-44ff-a475-50c51ece99a0"});
    Dio dio = Dio(dioOption);
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
        print("timeout");
      }
    } catch (e) {
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
    final result =
        await _getRequest(endpoint: ApiUrl.users, param: {"email": email});
    return result;
  }

  Future<Map<String, dynamic>?> postRegisterUser(body) async {
    final result =
        await _postRequest(endpoint: ApiUrl.mataPelajaran, body: body);
    return result;
  }

  Future<Map<String, dynamic>?> getMataPelajaran(email, major) async {
    final result = await _getRequest(
        endpoint: ApiUrl.mataPelajaran,
        param: {"major_name": major, "user_email": email});
    return result;
  }

  Future<Map<String, dynamic>?> getBanner([limit]) async {
    final result =
        await _getRequest(endpoint: ApiUrl.banner, param: {"limit": limit});
    return result;
  }
}
