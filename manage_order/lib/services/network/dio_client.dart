import 'dart:async';

import 'package:dio/dio.dart';

class DioClient {
  static late Dio _dio;
  static FutureOr<Dio> setup({
    required String baseUrl,
  }) async {
    final options = BaseOptions(
        responseType: ResponseType.json,
        validateStatus: (status) {
          return true;
        },
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
        });
    // ignore: join_return_with_assignment
    _dio = Dio(options);

    /// Unified add authentication request header
    // _dio.interceptors.add(AuthInterceptor());

    /// Adapt data (according to your own data structure
    /// , you can choose to add it)
    // _dio.interceptors.add(TokenInterceptor(_dio));

    return _dio;
  }

  static Dio get dio => _dio;
}
