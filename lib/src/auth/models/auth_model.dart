import 'package:dvizh_mob/core/models/model/model.dart';

class AuthModel extends ModelItem {
  final String token;
  final String refreshToken;

  AuthModel({
    required this.token,
    required this.refreshToken,
  });
}
