// 🌎 Project imports:
import 'package:dvizh_mob/core/models/params/params.dart';

class ForgotParams with Params {
  ForgotParams({
    required this.email,
  });
  final String email;

  @override
  Map<String, String> toMap() => {
        'email': email,
      };
}
