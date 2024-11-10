// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/events/export.dart';

class EventDataSource {
  EventDataSource(this._dioService);

  final DioService _dioService;

  Future<ListDataDTO<EventDTO, EventModel>> getEvents(
    EventIndexParams params,
  ) =>
      _dioService.I
          .get<Map<String, Object?>>('/event/event/', data: params.toMap())
          .then(
            (value) => ListDataDTO.fromJson(
              value.data as Map<String, Object?>,
              'events',
              EventDTO.fromJson,
            ),
          );

  Future<EventDTO> getById(int id) =>
      _dioService.I.get<Map<String, Object?>>('/event/event/$id').then(
            (value) =>
                EventDTO.fromJson(value.data?['event'] as Map<String, Object?>),
          );
}
