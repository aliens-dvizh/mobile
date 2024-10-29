// 🌎 Project imports:
import 'package:dvizh_mob/core/services/dio/dio_service.dart';
import '../core/auth_interceptor.dart';
import '../models/auth_model.dart';
import 'auth_repository.dart';

class AuthInterceptorDataSource {
  final DioService _apiService;
  AuthInterceptor? _interceptor;

  AuthInterceptorDataSource(this._apiService);

  void set(AuthModel auth, AuthRepository repository) {
    remove();
    _interceptor = AuthInterceptor(auth, repository);
    _apiService.addInterceptor(_interceptor!);
  }

  void remove() {
    if (_interceptor == null) return;
    _apiService.removerInterceptor(_interceptor!);
    _interceptor = null;
  }
}
