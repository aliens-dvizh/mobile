import 'package:dvizh_mob/src/city/models/category_model.dart';

interface class ICurrentLocationRepository {
  Future<CityModel> getCityByIP() {
    throw Exception();
  }

  Future<CityModel?> getCityFromStorage() {
    throw Exception();
  }
}