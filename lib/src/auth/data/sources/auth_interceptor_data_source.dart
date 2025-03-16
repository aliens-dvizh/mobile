// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/core/auth_interceptor.dart';
import 'package:dvizh_mob/src/auth/data/repositories/auth_repository.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class AuthInterceptorDataSource {
  AuthInterceptorDataSource(this._apiService);

  final DioService _apiService;
  AuthInterceptor? _interceptor;

  void set(AuthModel auth, IAuthRepository repository) {
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
