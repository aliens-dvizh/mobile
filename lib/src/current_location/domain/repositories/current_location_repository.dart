import 'dart:convert';

import 'package:dvizh_mob/src/city/dto/category_dto.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrentLocationRepository implements ICurrentLocationRepository {
  CurrentLocationRepository({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  @override
  Future<CityModel> getCityByIP() {
    // TODO: implement getCityByIP
    throw UnimplementedError();
  }

  @override
  Future<CityModel?> getCityFromStorage() async =>
      _secureStorage.read(key: 'current_city').then(
        (value) {
          if (value == null) return null;
          return CityDTO.fromJson(jsonDecode(value) as Map<String, Object?>).toModel();
        },
      );

  @override
  Future<void> setCity(CityModel city) async {
    await _secureStorage.write(
      key: 'current_city',
      value: jsonEncode(city.toDTO().toJson()),
    );
  }
}
