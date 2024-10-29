// 🌎 Project imports:
import '../../../core/models/params/params.dart';

class LoginParams extends Params {
  final String email;
  final String password;
  final String? phone;

  LoginParams({
    required this.email,
    required this.password,
    this.phone,
  });

  @override
  Map<String, String> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
