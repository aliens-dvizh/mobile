// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class RegisterParams with Params {
  RegisterParams({
    required this.name,
    required this.phone,
    required this.password,
  });

  final String name;
  final String phone;
  final String password;

  @override
  Map<String, String> toMap() => {
        'name': name,
        'email': phone,
        'password': password,
        'password_confirmation': password,
        'birthday': DateTime.now().toString(),
        'phone': '+77074054407'
      };
}
