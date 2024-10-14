part of 'dio_service.dart';

abstract class AppInterceptor extends Interceptor {
  late Dio _dio;

  set setDio(Dio dio) => _dio = dio;

  get dio => _dio;
}
