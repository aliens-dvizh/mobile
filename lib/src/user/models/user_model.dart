// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class UserModel with ModelItem {
  UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.phone,
  });

  final String id;
  final String name;
  final String phone;
  final DateTime createdAt;

  UserModel copyWith({String? name}) => UserModel(id: id, name: name ?? this.name, createdAt: createdAt, phone: phone);
}
