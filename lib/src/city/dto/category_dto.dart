// 🐦 Flutter imports:
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/dto.dart';

class CityDTO with DTO<CityModel> {
  CityDTO({
    required this.name,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CityDTO.fromJson(Map<String, dynamic> json) => CityDTO(
        name: json['name'] as String,
        id: json['id'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  final String name;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  static List<CityDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(CityDTO.fromJson).toList();

  @override
  CityModel toModel() => CityModel(
        id: id,
        name: name,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
