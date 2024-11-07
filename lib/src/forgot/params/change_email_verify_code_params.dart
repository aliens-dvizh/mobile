// 🌎 Project imports:
import 'package:dvizh_mob/core/models/params/params.dart';

class ChangeEmailVerifyCode with Params {
  ChangeEmailVerifyCode({
    required this.code,
  });
  final String code;

  @override
  Map<String, dynamic> toMap() => {
        'code': code,
      };
}
