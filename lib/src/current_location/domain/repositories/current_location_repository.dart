import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';

class CurrentLocationRepository implements ICurrentLocationRepository {
  @override
  Future<CityModel> getCityByIP() {
    // TODO: implement getCityByIP
    throw UnimplementedError();
  }

  @override
  Future<CityModel?> getCityFromStorage() {
    // TODO: implement getCityFromStorage
    throw UnimplementedError();
  }

}