// 🌎 Project imports:
import 'package:dvizh_mob/src/category/dto/category_dto.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/city/dto/category_dto.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class CityDataSource {
  CityDataSource(this._apiService);

  final DioService _apiService;

  Future<ListDataDTO<CityDTO, CityModel>> getCityList() =>
      _apiService.I.get<Object>('/event/category').then(
            (value) => ListDataDTO.fromJson(value.data as Map<String, Object?>,
                'list', CityDTO.fromJson),
          );
}
