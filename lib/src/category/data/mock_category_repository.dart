// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';

class MockCategoryRepository extends ICategoryRepository {
  @override
  Future<ListDataModel<CategoryModel>> getCategoryList() => Future.value(ListDataModel<CategoryModel>(list: [], ));
}
