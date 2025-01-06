import 'dart:math';

import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';

class MockCurrentLocationRepository implements ICurrentLocationRepository {
  final _city = CityModel(
    id: 1,
    name: 'Алматы',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  @override
  Future<CityModel> getCityByIP()  {
    final result = Random().nextInt(2) == 0;

    if(result) throw Exception();
    return Future.value(_city);
  }

  @override
  Future<CityModel?> getCityFromStorage() {
    final result = Random().nextInt(2) == 0;

    if(result) return Future.value(null);
    return Future.value(_city);
  }
}
