// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';
import 'package:dvizh_mob/src/events/params/event_index.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

final ListDataModel<EventModel> _data = ListDataModel(list: [
  EventModel(
    id: 1,
    name: 'Scryptonit',
    description: '',
    image:
        'https://www.soyuz.ru/public/uploads/files/2/7465493/20210516154216ee4d0ecfbd.jpg',
  ),
  EventModel(
    id: 2,
    name: 'Scryptonit',
    description: '',
    image:
        'https://www.soyuz.ru/public/uploads/files/2/7465493/20210516154216ee4d0ecfbd.jpg',
  ),
  EventModel(
    id: 3,
    name: 'Scryptonit',
    description: '',
    image:
        'https://www.soyuz.ru/public/uploads/files/2/7465493/20210516154216ee4d0ecfbd.jpg',
  ),
], count: 3);

class MockEventRepository extends IEventRepository {
  @override
  Future<EventModel> getById(int id) =>
      Future.value(_data.list.firstWhere((event) => event.id == id));

  @override
  Future<ListDataModel<EventModel>> getEvents(EventIndexParams params) =>
      Future.value(_data);
}
