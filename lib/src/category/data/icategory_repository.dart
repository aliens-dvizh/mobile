// 🌎 Project imports:
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/core/models/repository/repository.dart';

abstract class ICategoryRepository extends IRepository {
  Future<ListDataModel<CategoryModel>> getCategoryList();
}
