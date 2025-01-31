import 'package:dvizh_mob/src/core/models/params/params.dart';

class UpdateUserParams with Params {
  UpdateUserParams({required this.name});

  final String name;

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }

}