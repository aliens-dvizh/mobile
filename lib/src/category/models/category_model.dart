// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class CategoryModel with ModelItem {
  CategoryModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final IconData icon;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
}
