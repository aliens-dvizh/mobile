import 'package:dvizh_mob/src/events/export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteRepository {
  FavoriteRepository({required SupabaseClient client}) : _client = client;

  final SupabaseClient _client;

  Future<EventModel> add(int eventId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();

    final have = await _client
        .from('favorite_event')
        .select()
        .eq('user_id', user.id)
        .eq('event_id', eventId);

    late final List<Map<String, Object?>> result;

    if (have.isNotEmpty && have.firstOrNull?['deleted_at'] != null) {
      result = await _client
          .from('favorite_event')
          .update({
            'deleted_at': null,
          })
          .eq('user_id', user.id)
          .eq('event_id', eventId)
          .select('*, event:events(*, event_image(*), category:categories(*))');
      print('Have');

      print(result);
    } else {
      result = await _client.from('favorite_event').insert({
        'event_id': eventId,
        'user_id': user.id,
      }).select('*, event:events(*, event_image(*), category:categories(*))');
      print('Not have');

      print(result);
    }

    return EventDTO.fromJson(result.first['event'] as Map<String, Object?>)
        .toModel();
  }

  Future<void> remove(int eventId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();

    await _client
        .from('favorite_event')
        .update({
          'deleted_at': DateTime.now().toIso8601String(),
        })
        .eq('user_id', user.id)
        .eq('event_id', eventId);
  }

  Future<List<EventModel>> get() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();

    final result = await _client
        .from('favorite_event')
        .select('*, event:events(*, event_image(*), category:categories(*))')
        .eq('user_id', user.id)
        .isFilter('deleted_at', null);

    return result
        .map((value) =>
            EventDTO.fromJson(value['event'] as Map<String, Object?>).toModel())
        .toList();
  }
}
