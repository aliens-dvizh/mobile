// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class LoginParams with Params {
  LoginParams({
    required this.email,
    required this.password,
    this.phone,
  });

  final String email;
  final String password;
  final String? phone;

  @override
  Map<String, String> toMap() => {
        'email': email,
        'password': password,
      };
}
