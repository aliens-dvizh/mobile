// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class CityModel with ModelItem {
  CityModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
}
