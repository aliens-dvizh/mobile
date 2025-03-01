// 🐦 Flutter imports:
import 'package:dvizh_mob/src/city/data/icategory_repository.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';

final List<CityModel> kazakhstanCities = [
  CityModel(
    id: 1,
    name: 'Алматы',
    createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
  ),
  CityModel(
    id: 2,
    name: 'Астана',
    createdAt: DateTime.parse('2023-01-02T11:00:00.000Z'),
  ),
];

class MockCityRepository extends ICityRepository {
  @override
  Future<ListDataModel<CityModel>> getCityList() => Future.value(
        ListDataModel(
          list: kazakhstanCities,
          count: 20,
        ),
      );
}
