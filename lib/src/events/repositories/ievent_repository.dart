// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/core/models/repository/repository.dart';
import 'package:dvizh_mob/src/events/export.dart';

abstract class IEventRepository extends IRepository {
  Future<ListDataModel<EventModel>> getEvents(EventIndexParams params);
  Future<EventModel> getById(int id);
}
