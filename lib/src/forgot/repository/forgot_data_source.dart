import 'package:dio/dio.dart';
import 'package:dvizh_mob/core/services/dio/dio_service.dart';

import '../../../core/models/message_response/messge_response_dto.dart';
import '../params/export.dart';

class ForgotDataSource {
  final DioService _apiService;

  ForgotDataSource(this._apiService);

  Future<Response> sendMailToChangePassword(ForgotParams params) =>
      _apiService.I.post('/mail/to-change-password', data: params.toData());

  Future<Response> checkCode(VerifyEmailParams params) =>
      _apiService.I.post('/auth/check-code', data: params.toData());

  Future<Response> changePassword(ResetPasswordParams params) =>
      _apiService.I.post('/auth/change-password', data: params.toData());

  Future<MessageResponseDTO> getSendCodeToChangeEmail(
    CodeToChangeEmailParams params,
  ) =>
      _apiService.I.post('/mail/to-change-email', data: params.toData()).then(
            (value) => MessageResponseDTO.fromJson(value.data),
          );

  Future<Response> changeEmailVerifyCode(ChangeEmailVerifyCode params) =>
      _apiService.I.post('/auth/check-code', data: params.toData());
}
