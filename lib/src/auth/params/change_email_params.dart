// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class ChangeEmailParams with Params {
  ChangeEmailParams({
    required this.newEmail,
    required this.code,
  });

  final String newEmail;
  final int code;

  @override
  Map<String, Object> toMap() => {'email': newEmail, 'code': code};
}
