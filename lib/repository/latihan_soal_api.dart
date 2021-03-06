import 'package:dio/dio.dart';
import 'package:projek_edspert/helpers/user_email.dart';

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
      print("error");
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
      print("error");
    }
  }

  Future<Map<String, dynamic>?> getMataPelajaran(email, major) async {
    final result = await _getRequest(
      endpoint: ApiUrl.latihanMataPelajaran,
      param: {
        "major_name": major,
        "user_email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<Map<String, dynamic>?> getBanner([limit]) async {
    final result = await _getRequest(
      endpoint: ApiUrl.banner,
      param: {"limit": limit},
    );
    return result;
  }

  Future<Map<String, dynamic>?> getMateri(email, materi) async {
    final result = await _getRequest(
      endpoint: ApiUrl.latihanMateri,
      param: {
        "course_id": materi,
        "user_email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<Map<String, dynamic>?> getSubMateri(email, courseContentId) async {
    final result = await _getRequest(endpoint: ApiUrl.latihanSubMateri, param: {
      "course_content_id": courseContentId,
      "user_email": UserEmail.getUserEmail(),
    });
    return result;
  }

  Future<Map<String, dynamic>?> getPaketSoal(courseId, id) async {
    final result = await _getRequest(endpoint: ApiUrl.latihanPaketSoal, param: {
      "sub_course_content_id": courseId,
      "course_id": id,
      "user_email": UserEmail.getUserEmail(),
    });
    return result;
  }

  Future<Map<String, dynamic>?> getSkor(email) async {
    final result = await _getRequest(
        endpoint: ApiUrl.latihanScore,
        param: {"email": UserEmail.getUserEmail()});
    return result;
  }

  Future<Map<String, dynamic>?> postMulaiKerjakan(email, exerciseId) async {
    final result = await _postRequest(endpoint: ApiUrl.latihanKerjakan, body: {
      "exercise_id": exerciseId,
      "user_email": UserEmail.getUserEmail(),
    });
    return result;
  }

  Future<Map<String, dynamic>?> postInputJawaban(payload) async {
    final result = await _postRequest(
      endpoint: ApiUrl.latihanSubmit,
      body: payload,
    );
    return result;
  }

  Future<Map<String, dynamic>?> getResult(id) async {
    final result = await _getRequest(
      endpoint: ApiUrl.latihanScore,
      param: {"exercise_id": id, "user_email": UserEmail.getUserEmail()},
    );
    return result;
  }
}
