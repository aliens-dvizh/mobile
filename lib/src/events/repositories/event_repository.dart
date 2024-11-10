// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/data/event_data_source.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';
import 'package:dvizh_mob/src/events/params/event_index.dart';

class EventRepository {
  EventRepository(this._eventDataSource);

  final EventDataSource _eventDataSource;

  Future<ListDataModel<EventModel>> getEvents(EventIndexParams params) =>
      _eventDataSource.getEvents(params).then((value) => value.toModel());

  Future<EventModel> getById(int id) =>
      _eventDataSource.getById(id).then((value) => value.toModel());
}
