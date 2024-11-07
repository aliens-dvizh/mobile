// 🌎 Project imports:
import 'package:dvizh_mob/core/models/params/params.dart';

class VerifyParams with Params {
  VerifyParams({
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  @override
  Map<String, String> toMap() => {
        'email': email,
        'code': code,
      };
}
