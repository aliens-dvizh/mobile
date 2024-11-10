// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/dto.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

class UserDTO with DTO<UserModel> {
  UserDTO({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory UserDTO.fromJson(Map<String, Object?> map) => UserDTO(
        id: map['id'] as int,
        name: map['name'] as String,
        createdAt: DateTime.parse(map['created_at'] as String),
      );

  final int id;
  final String name;
  final DateTime createdAt;

  @override
  UserModel toModel() => UserModel(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}
