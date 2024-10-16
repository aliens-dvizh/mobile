import 'package:dio/dio.dart';
import 'package:dvizh_mob/core/services/dio/dio_service.dart';

import '../models/export.dart';
import '../params/export.dart';

class AuthDataSource {
  final DioService _apiService;

  AuthDataSource(this._apiService);

  Future<AuthDto> login(LoginParams params) => _apiService.I
      .post('/auth/login', data: params.toData())
      .then((value) => AuthDto.fromJson(value.data));

  Future<AuthDto> verify(VerifyParams params) => _apiService.I
      .post('/auth/verify-code', data: params.toData())
      .then((value) => AuthDto.fromJson(value.data));

  Future register(RegisterParams params) =>
      _apiService.I.post('/auth/register', data: params.toData());

  Future<AuthDto> refresh(AuthModel auth) => _apiService.I.post(
        '/auth/refresh',
        options: Options(
          headers: {'Authorization': 'Bearer ${auth.token}'},
        ),
        data: {'refresh_token': auth.refreshToken},
      ).then((value) => AuthDto.fromJson(value.data));

  Future logout() => _apiService.I.post('/auth/logout');

  Future<Response> changeEmail(ChangeEmailParams params) => _apiService.I.post(
        '/auth/change-email',
        data: params.toData(),
      );

  Future<Response> deleteAccount(DeleteAccountParams params) =>
      _apiService.I.delete('/auth/delete', data: params.toData());
}
