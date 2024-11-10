// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/message_response/messge_response_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/forgot/params/export.dart';

class ForgotDataSource {
  ForgotDataSource(this._apiService);
  final DioService _apiService;

  Future<Response<Object?>> sendMailToChangePassword(ForgotParams params) =>
      _apiService.I.post('/mail/to-change-password', data: params.toMap());

  Future<Response<Object?>> checkCode(VerifyEmailParams params) =>
      _apiService.I.post('/auth/check-code', data: params.toMap());

  Future<Response<Object?>> changePassword(ResetPasswordParams params) =>
      _apiService.I.post('/auth/change-password', data: params.toMap());

  Future<MessageResponseDTO> getSendCodeToChangeEmail(
    CodeToChangeEmailParams params,
  ) =>
      _apiService.I
          .post<MessageResponseDTO>('/mail/to-change-email',
              data: params.toMap())
          .then(
            (value) =>
                MessageResponseDTO.fromJson(value.data as Map<String, Object?>),
          );

  Future<Response<Object?>> changeEmailVerifyCode(
          ChangeEmailVerifyCode params) =>
      _apiService.I.post('/auth/check-code', data: params.toMap());
}
