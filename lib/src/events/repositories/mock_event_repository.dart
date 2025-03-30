// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';
import 'package:dvizh_mob/src/events/params/event_index.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

final ListDataModel<EventModel> _data = ListDataModel(list: [], count: 3);

class MockEventRepository extends IEventRepository {
  @override
  Future<EventModel> getById(int id) =>
      Future.value(_data.list.firstWhere((event) => event.id == id));

  @override
  Future<ListDataModel<EventModel>> getEvents(EventIndexParams params) =>
      Future.value(_data);
}
