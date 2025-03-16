// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class LoginParamsWithEmail with Params {
  LoginParamsWithEmail({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  Map<String, String> toMap() => {
        'email': email,
        'password': password,
      };
}
