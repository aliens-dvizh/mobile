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
    updatedAt: DateTime.parse('2023-01-05T12:00:00.000Z'),
  ),
  CityModel(
    id: 2,
    name: 'Астана',
    createdAt: DateTime.parse('2023-01-02T11:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-06T13:00:00.000Z'),
  ),
  CityModel(
    id: 3,
    name: 'Шымкент',
    createdAt: DateTime.parse('2023-01-03T12:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-07T14:00:00.000Z'),
  ),
  CityModel(
    id: 4,
    name: 'Актобе',
    createdAt: DateTime.parse('2023-01-04T13:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-08T15:00:00.000Z'),
  ),
  CityModel(
    id: 5,
    name: 'Караганда',
    createdAt: DateTime.parse('2023-01-05T14:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-09T16:00:00.000Z'),
  ),
  CityModel(
    id: 6,
    name: 'Тараз',
    createdAt: DateTime.parse('2023-01-06T15:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-10T17:00:00.000Z'),
  ),
  CityModel(
    id: 7,
    name: 'Павлодар',
    createdAt: DateTime.parse('2023-01-07T16:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-11T18:00:00.000Z'),
  ),
  CityModel(
    id: 8,
    name: 'Усть-Каменогорск',
    createdAt: DateTime.parse('2023-01-08T17:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-12T19:00:00.000Z'),
  ),
  CityModel(
    id: 9,
    name: 'Семей',
    createdAt: DateTime.parse('2023-01-09T18:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-13T20:00:00.000Z'),
  ),
  CityModel(
    id: 10,
    name: 'Костанай',
    createdAt: DateTime.parse('2023-01-10T19:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-14T21:00:00.000Z'),
  ),
  CityModel(
    id: 11,
    name: 'Кызылорда',
    createdAt: DateTime.parse('2023-01-11T20:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-15T22:00:00.000Z'),
  ),
  CityModel(
    id: 12,
    name: 'Уральск',
    createdAt: DateTime.parse('2023-01-12T21:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-16T23:00:00.000Z'),
  ),
  CityModel(
    id: 13,
    name: 'Атырау',
    createdAt: DateTime.parse('2023-01-13T22:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-17T00:00:00.000Z'),
  ),
  CityModel(
    id: 14,
    name: 'Петропавловск',
    createdAt: DateTime.parse('2023-01-14T23:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-18T01:00:00.000Z'),
  ),
  CityModel(
    id: 15,
    name: 'Актау',
    createdAt: DateTime.parse('2023-01-15T00:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-19T02:00:00.000Z'),
  ),
  CityModel(
    id: 16,
    name: 'Темиртау',
    createdAt: DateTime.parse('2023-01-16T01:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-20T03:00:00.000Z'),
  ),
  CityModel(
    id: 17,
    name: 'Туркестан',
    createdAt: DateTime.parse('2023-01-17T02:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-21T04:00:00.000Z'),
  ),
  CityModel(
    id: 18,
    name: 'Экибастуз',
    createdAt: DateTime.parse('2023-01-18T03:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-22T05:00:00.000Z'),
  ),
  CityModel(
    id: 19,
    name: 'Рудный',
    createdAt: DateTime.parse('2023-01-19T04:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-23T06:00:00.000Z'),
  ),
  CityModel(
    id: 20,
    name: 'Жезказган',
    createdAt: DateTime.parse('2023-01-20T05:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-24T07:00:00.000Z'),
  ),
  CityModel(
    id: 21,
    name: 'Балхаш',
    createdAt: DateTime.parse('2023-01-21T06:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-25T08:00:00.000Z'),
  ),
  CityModel(
    id: 22,
    name: 'Кентау',
    createdAt: DateTime.parse('2023-01-22T07:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-26T09:00:00.000Z'),
  ),
  CityModel(
    id: 23,
    name: 'Талгар',
    createdAt: DateTime.parse('2023-01-23T08:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-27T10:00:00.000Z'),
  ),
  CityModel(
    id: 24,
    name: 'Каскелен',
    createdAt: DateTime.parse('2023-01-24T09:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-28T11:00:00.000Z'),
  ),
  CityModel(
    id: 25,
    name: 'Капшагай',
    createdAt: DateTime.parse('2023-01-25T10:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-29T12:00:00.000Z'),
  ),
  CityModel(
    id: 26,
    name: 'Шучинск',
    createdAt: DateTime.parse('2023-01-26T11:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-30T13:00:00.000Z'),
  ),
  CityModel(
    id: 27,
    name: 'Текели',
    createdAt: DateTime.parse('2023-01-27T12:00:00.000Z'),
    updatedAt: DateTime.parse('2023-01-31T14:00:00.000Z'),
  ),
  CityModel(
    id: 28,
    name: 'Сарыагаш',
    createdAt: DateTime.parse('2023-01-28T13:00:00.000Z'),
    updatedAt: DateTime.parse('2023-02-01T15:00:00.000Z'),
  ),
  CityModel(
    id: 29,
    name: 'Зыряновск',
    createdAt: DateTime.parse('2023-01-29T14:00:00.000Z'),
    updatedAt: DateTime.parse('2023-02-02T16:00:00.000Z'),
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
