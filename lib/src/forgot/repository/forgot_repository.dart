// 🌎 Project imports:
import '../../../core/models/message_response/message_response_model.dart';
import '../params/export.dart';
import 'forgot_data_source.dart';

class ForgotRepository {
  final ForgotDataSource _dataSource;

  ForgotRepository(this._dataSource);

  Future forgotPassword(ForgotParams params) =>
      _dataSource.sendMailToChangePassword(params);

  Future verifyCode(VerifyEmailParams params) => _dataSource.checkCode(params);

  Future resetPassword(ResetPasswordParams params) =>
      _dataSource.changePassword(params);

  Future<MessageResponseModel> getSendCodeToChangeEmail(
    CodeToChangeEmailParams params,
  ) =>
      _dataSource.getSendCodeToChangeEmail(params).then(
            (value) => value.toModel(),
          );

  Future changeEmailVerifyCode(ChangeEmailVerifyCode params) =>
      _dataSource.changeEmailVerifyCode(params);
}
