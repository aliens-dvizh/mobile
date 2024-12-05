// 🌎 Project imports:
import 'package:dvizh_mob/src/category/dto/category_dto.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class CategoryDataSource {
  CategoryDataSource(this._apiService);

  final DioService _apiService;

  Future<ListDataDTO<CategoryDTO, CategoryModel>> getCategoryList() =>
      _apiService.I.get<Object>('/event/category').then(
            (value) => ListDataDTO.fromJson(value.data as Map<String, Object?>,
                'list', CategoryDTO.fromJson),
          );
}
