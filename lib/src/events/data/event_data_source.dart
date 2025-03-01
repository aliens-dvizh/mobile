// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_dto.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventDataSource {
  EventDataSource(this._dioService, this._client);

  final DioService _dioService;
  final SupabaseClient _client;

  Future<ListDataDTO<EventDTO, EventModel>> getEvents(
    EventIndexParams params,
  ) => _client.from('events').select().then((data) => ListDataDTO.fromJsonList(data, EventDTO.fromJson));

  Future<EventDTO> getById(int id) => _client.from('events').select().eq('id', id).then((data) => EventDTO.fromJson(data.first));
}
