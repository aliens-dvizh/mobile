import 'package:dvizh_mob/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/core/services/dio_service.dart';
import 'package:dvizh_mob/src/events/dto/event_dto.dart';

import '../params/event_index.dart';

class EventDataSource {
  final DioService _dioService;

  EventDataSource(this._dioService);

  Future<ListDataDTO<EventDTO>> getEvents(EventIndexParams params) =>
      _dioService.I.get('/event/event/', data: params.toData()).then((value) =>
          ListDataDTO.fromJson(value.data, 'events', EventDTO.fromJson));
}
