import '../../../core/models/model/dto.dart';
import '../../../core/models/model/model.dart';
import 'auth_model.dart';

class AuthDto extends DTO<ModelItem> {
  final String token;
  final String refreshToken;

  AuthDto(this.token, this.refreshToken);

  factory AuthDto.fromJson(Map<String, dynamic> json) => AuthDto(
        json['token'],
        json['refresh_token'],
      );

  @override
  AuthModel toModel() => AuthModel(token: token, refreshToken: refreshToken);
}
