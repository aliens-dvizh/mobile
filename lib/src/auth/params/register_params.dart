// 🌎 Project imports:
import '../../../core/models/params/params.dart';

class RegisterParams extends Params {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
      'birthday': DateTime.now().toString(),
      'phone': '+77074054407'
    };
  }
}
