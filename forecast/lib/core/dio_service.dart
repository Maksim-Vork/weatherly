import 'package:dio/dio.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.weatherapi.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Успешно');
          handler.next(response);
        },
        onError: (error, handler) {
          print('❌ Ошибка связанная с ${error.message}');
          print('📦 Ответ от сервера: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _dio.get(endpoint, queryParameters: queryParams);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
