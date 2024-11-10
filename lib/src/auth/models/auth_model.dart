// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class AuthModel with ModelItem {
  AuthModel({
    required this.token,
    required this.refreshToken,
  });

  final String token;
  final String refreshToken;
}
