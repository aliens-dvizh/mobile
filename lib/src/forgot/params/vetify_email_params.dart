// 🌎 Project imports:
import 'package:dvizh_mob/core/models/params/params.dart';

class VerifyEmailParams with Params {
  VerifyEmailParams({
    required this.email,
    required this.code,
  });
  final String email;
  final int code;

  @override
  Map<String, Object> toMap() {
    final data = {
      'email': email,
      'code': code,
    };
    return data;
  }
}
