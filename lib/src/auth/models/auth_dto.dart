// 🌎 Project imports:
import 'package:dvizh_mob/core/models/model/dto.dart';
import 'package:dvizh_mob/core/models/model/model.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';

class AuthDto with DTO<ModelItem> {
  AuthDto(this.token, this.refreshToken);

  factory AuthDto.fromJson(Map<String, dynamic> json) => AuthDto(
        json['token'] as String,
        json['refresh_token'] as String,
      );

  final String token;
  final String refreshToken;

  @override
  AuthModel toModel() => AuthModel(token: token, refreshToken: refreshToken);
}
