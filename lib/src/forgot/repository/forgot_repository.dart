// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/models/message_response/message_response_model.dart';
import 'package:dvizh_mob/src/forgot/params/export.dart';
import 'package:dvizh_mob/src/forgot/repository/forgot_data_source.dart';

class ForgotRepository {
  ForgotRepository(this._dataSource);
  final ForgotDataSource _dataSource;

  Future<Response<Object?>> forgotPassword(ForgotParams params) =>
      _dataSource.sendMailToChangePassword(params);

  Future<Response<Object?>> verifyCode(VerifyEmailParams params) =>
      _dataSource.checkCode(params);

  Future<Response<Object?>> resetPassword(ResetPasswordParams params) =>
      _dataSource.changePassword(params);

  Future<MessageResponseModel> getSendCodeToChangeEmail(
    CodeToChangeEmailParams params,
  ) =>
      _dataSource.getSendCodeToChangeEmail(params).then(
            (value) => value.toModel(),
          );

  Future<Response<Object?>> changeEmailVerifyCode(
          ChangeEmailVerifyCode params) =>
      _dataSource.changeEmailVerifyCode(params);
}
