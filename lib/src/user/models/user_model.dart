// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class UserModel with ModelItem {
  UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;

  UserModel copyWith({String? name}) => UserModel(id: id, name: name ?? this.name, createdAt: createdAt);
}
