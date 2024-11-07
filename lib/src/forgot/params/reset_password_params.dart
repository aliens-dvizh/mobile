// 🌎 Project imports:
import 'package:dvizh_mob/core/models/params/params.dart';

class ResetPasswordParams with Params {
  ResetPasswordParams({
    required this.email,
    required this.code,
    required this.newPassword,
  });
  final String email;
  final int code;
  final String newPassword;

  @override
  Map<String, Object> toMap() => {
        'email': email,
        'code': code,
        'password': newPassword,
      };
}
