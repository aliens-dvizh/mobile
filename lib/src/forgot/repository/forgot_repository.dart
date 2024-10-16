import 'package:depend/depend.dart';
import '../../../core/models/message_response/message_response_model.dart';
import 'forgot_data_source.dart';

import '../params/export.dart';

class ForgotRepository extends Dependency {
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
