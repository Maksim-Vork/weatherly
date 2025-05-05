import 'package:dio/dio.dart';
import 'dart:io';

import 'package:dio/io.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.weatherapi.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          if (Platform.isMacOS)
            'Origin': 'http://localhost', // Для CORS на macOS
        },
      ),
    );

    if (Platform.isMacOS) {
      (_dio.httpClientAdapter as IOHttpClientAdapter)
          // ignore: deprecated_member_use
          .onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    _dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: false,
        error: true,
      ),
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          print('❌ Ошибка: ${error.type}');
          print('🔗 URL: ${error.requestOptions.uri}');
          print('📦 Ответ: ${error.response?.data ?? 'Нет данных'}');

          if (error.type == DioExceptionType.connectionError) {
            print('⚠️ Проверьте интернет-соединение');
          }

          return handler.next(error);
        },
      ),
    ]);
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      // Детализированная обработка ошибок
      if (e.response != null) {
        throw Exception('Ошибка сервера: ${e.response?.statusCode}');
      } else {
        throw Exception('Сетевая ошибка: ${e.message}');
      }
    }
  }
}
