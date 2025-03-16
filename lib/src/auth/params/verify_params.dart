// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class VerifyParams with Params {
  VerifyParams({
    required this.phone,
    required this.code,
  });

  final String phone;
  final String code;

  @override
  Map<String, String> toMap() => {
        'phone': phone,
        'code': code,
      };
}
