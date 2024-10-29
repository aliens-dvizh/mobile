// 🌎 Project imports:
import '../../../core/models/params/params.dart';

class ResetPasswordParams extends Params {
  final String email;
  final int code;
  final String newPassword;

  ResetPasswordParams({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  @override
  Map<String, Object> toMap() {
    return {
      'email': email,
      'code': code,
      'password': newPassword,
    };
  }
}
