// 🌎 Project imports:
import 'package:dvizh_mob/src/category/data/category_data_source.dart';
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/city/data/category_data_source.dart';
import 'package:dvizh_mob/src/city/data/icategory_repository.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';

class CityRepository extends ICityRepository {
  CityRepository(this._categoryDataSource);

  final CityDataSource _categoryDataSource;

  @override
  Future<ListDataModel<CityModel>> getCityList() =>
      _categoryDataSource.getCityList().then((value) => value.toModel());
}
