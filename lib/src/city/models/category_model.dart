// 🐦 Flutter imports:
import 'package:dvizh_mob/src/city/dto/category_dto.dart';
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class CityModel with ModelItem {
  CityModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;

  CityDTO toDTO() {
    return CityDTO(name: name, id: id, createdAt: createdAt);
  }
}
