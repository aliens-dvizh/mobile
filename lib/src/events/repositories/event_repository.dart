import 'package:dvizh_mob/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/params/event_index.dart';

import '../data/event_data_source.dart';
import '../models/event_model.dart';

class EventRepository {
  final EventDataSource _eventDataSource;

  EventRepository(this._eventDataSource);

  Future<ListDataModel<EventModel>> getEvents(EventIndexParams params) =>
      _eventDataSource.getEvents(params).then((value) => value.toModel());
}
