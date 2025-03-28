// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/model/dto.dart';

class CategoryDTO with DTO<CategoryModel> {
  CategoryDTO({
    required this.name,
    required this.id,
    required this.createdAt,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) => CategoryDTO(
        name: json['name'] as String,
        id: json['id'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  final String name;
  final int id;
  final DateTime createdAt;

  static List<CategoryDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(CategoryDTO.fromJson).toList();

  @override
  CategoryModel toModel() => CategoryModel(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}
