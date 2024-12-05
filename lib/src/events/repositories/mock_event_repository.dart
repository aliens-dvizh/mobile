// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';
import 'package:dvizh_mob/src/events/params/event_index.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

class MockEventRepository extends IEventRepository {
  @override
  Future<EventModel> getById(int id) =>
      Future.value(EventModel(id: id, name: 'sdfsdf', description: 'sdfdsf'));

  @override
  Future<ListDataModel<EventModel>> getEvents(EventIndexParams params) =>
      Future.value(
        ListDataModel(
          list: [
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 1,
                name: 'Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
            EventModel(
                id: 2,
                name: 'Alex Scryptonit',
                description: '',
                image:
                    'https://icdn.lenta.ru/images/2021/07/28/17/20210728170839751/square_1280_f0ee0cf3a1ec890d402829508d8a4b5f.jpg'),
          ],
          count: 20,
        ),
      );
}
