import 'package:dio/dio.dart';

class DioClient {
  DioClient({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
      ),
    ]);
  }

  late final Dio _dio;
  Dio get dio => _dio;
}
