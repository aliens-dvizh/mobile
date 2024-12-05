// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/models/export.dart';
import 'package:dvizh_mob/src/auth/params/export.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class AuthDataSource {
  AuthDataSource(this._apiService);
  final DioService _apiService;

  Future<AuthDto> login(LoginParams params) => _apiService.I
      .post<AuthDto>('/auth/login', data: params.toMap())
      .then((value) => AuthDto.fromJson(value.data as Map<String, Object?>));

  Future<AuthDto> verify(VerifyParams params) => _apiService.I
      .post<AuthDto>('/auth/verify-code', data: params.toMap())
      .then((value) => AuthDto.fromJson(value.data as Map<String, Object?>));

  Future<Response<Object?>> register(RegisterParams params) =>
      _apiService.I.post('/auth/register', data: params.toMap());

  Future<AuthDto> refresh(AuthModel auth) => _apiService.I.post<AuthDto>(
        '/auth/refresh',
        options: Options(
          headers: {'Authorization': 'Bearer ${auth.token}'},
        ),
        data: {'refresh_token': auth.refreshToken},
      ).then((value) => AuthDto.fromJson(value.data as Map<String, Object?>));

  Future<Response<Object?>> logout() => _apiService.I.post('/auth/logout');

  Future<Response<Object?>> changeEmail(ChangeEmailParams params) =>
      _apiService.I.post(
        '/auth/change-email',
        data: params.toMap(),
      );

  Future<Response<Object?>> deleteAccount(DeleteAccountParams params) =>
      _apiService.I.delete('/auth/delete', data: params.toMap());
}
