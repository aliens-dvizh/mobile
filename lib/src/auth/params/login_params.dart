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
  toData() {
    return {
      'email': email,
      'password': password,
    };
  }
}
