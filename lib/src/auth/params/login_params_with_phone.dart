import 'package:dvizh_mob/src/core/models/params/params.dart';

class LoginParamsWithPhone with Params {
  LoginParamsWithPhone({
    required this.password,
    required this.phone,
  });

  final String password;
  final String phone;

  @override
  Map<String, String> toMap() => {
    'phone': phone,
    'password': password,
  };
}
