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
  ) async {
    var builder = _client.from('events').select();

    final startAt = params.startAt;
    final endAt = params.endAt;

    if (startAt == null && endAt == null) {
      builder = builder.gt('holded_at', DateTime.now().toIso8601String());
    } else if (startAt != null && endAt == null) {
      builder = builder.gt('holded_at', startAt.toIso8601String());
    } else if (startAt != null && endAt != null) {
      builder = builder
          .gt('holded_at', startAt.toIso8601String())
          .lte('holded_at', endAt.toIso8601String());
    }

    if(params.categoryId != null) {
      builder = builder.eq('category_id', params.categoryId!);
    }

    final result = await builder.select('*, category:categories(*), event_image(*), place:places(*)');

    print(result);

    return  ListDataDTO.fromJsonList(result, EventDTO.fromJson);
  }

  Future<EventDTO> getById(int id) => _client
      .from('events')
      .select('*, category:categories(*),  place:places(*), event_image(*)')
      .eq('id', id)
      .then((data) => EventDTO.fromJson(data.first));
}
