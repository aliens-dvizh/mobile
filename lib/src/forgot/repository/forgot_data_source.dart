// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/services/dio/dio_service.dart';
import '../../../core/models/message_response/messge_response_dto.dart';
import '../params/export.dart';

class ForgotDataSource {
  final DioService _apiService;

  ForgotDataSource(this._apiService);

  Future<Response> sendMailToChangePassword(ForgotParams params) =>
      _apiService.I.post('/mail/to-change-password', data: params.toMap());

  Future<Response> checkCode(VerifyEmailParams params) =>
      _apiService.I.post('/auth/check-code', data: params.toMap());

  Future<Response> changePassword(ResetPasswordParams params) =>
      _apiService.I.post('/auth/change-password', data: params.toMap());

  Future<MessageResponseDTO> getSendCodeToChangeEmail(
    CodeToChangeEmailParams params,
  ) =>
      _apiService.I.post('/mail/to-change-email', data: params.toMap()).then(
            (value) => MessageResponseDTO.fromJson(value.data),
          );

  Future<Response> changeEmailVerifyCode(ChangeEmailVerifyCode params) =>
      _apiService.I.post('/auth/check-code', data: params.toMap());
}
