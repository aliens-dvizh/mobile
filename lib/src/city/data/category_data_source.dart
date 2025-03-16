// 🌎 Project imports:
import 'package:dvizh_mob/src/category/dto/category_dto.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/city/dto/category_dto.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CityDataSource {
  CityDataSource(this._apiService, this._client);

  final DioService _apiService;
  final SupabaseClient _client;

  Future<ListDataDTO<CityDTO, CityModel>> getCityList() => _client
        .from('cities')
        .select()
        .then((data) => ListDataDTO.fromJsonList(data, CityDTO.fromJson));
}
