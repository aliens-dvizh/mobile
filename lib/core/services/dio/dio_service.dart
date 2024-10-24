import 'dart:io';

import 'package:depend/depend.dart';
import 'package:dio/dio.dart';

part 'app_interceptor.dart';

class DioService extends Dependency {
  static late Dio _dio;

  DioService();

  DioService.initialize(String url) {
    _dio = Dio(BaseOptions(
      baseUrl: url,
      headers: {
        HttpHeaders.acceptHeader: Headers.jsonContentType,
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      },
    ));
  }

  Dio get I => _dio;

  void addInterceptor(Interceptor interceptor) {
    if (interceptor is AppInterceptor) interceptor.setDio = _dio;
    _dio.interceptors.add(interceptor);
  }

  void removerInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }
}
