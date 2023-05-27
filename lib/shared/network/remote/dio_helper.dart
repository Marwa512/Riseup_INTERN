import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://gorest.co.in/public/v2/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
  }) async {
    return await dio.get(
      url,
    );
  }

  static Future<Response> postData({
    required String url,
    dynamic query,
    required dynamic data,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization':
          'Bearer b57f3777a03b5423f01213793c6dd1da44ab5f2d2d32803307d15737306cf716',
    };
    return dio.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    dynamic query,
    required dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization':
          'Bearer b57f3777a03b5423f01213793c6dd1da44ab5f2d2d32803307d15737306cf716',
    };
    return dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer b57f3777a03b5423f01213793c6dd1da44ab5f2d2d32803307d15737306cf716',
    };
    return await dio.delete(url);
  }
}
