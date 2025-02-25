// 🌎 Project imports:
import 'package:dvizh_mob/src/category/data/category_data_source.dart';
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';

class CategoryRepository extends ICategoryRepository {
  CategoryRepository(this._categoryDataSource);

  final CategoryDataSource _categoryDataSource;

  @override
  Future<ListDataModel<CategoryModel>> getCategoryList() =>
      _categoryDataSource.getCategoryList().then((value) => value.toModel());
}
