// 🌎 Project imports:
import 'package:dvizh_mob/src/category/dto/category_dto.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryDataSource {
  CategoryDataSource(this._apiService, this._client);

  final DioService _apiService;
  final SupabaseClient _client;

  Future<ListDataDTO<CategoryDTO, CategoryModel>> getCategoryList() {
    return  _client
        .from('categories')
        .select()
        .then((data) => ListDataDTO.fromJsonList(data, CategoryDTO.fromJson));
  }
}
