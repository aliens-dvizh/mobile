import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketDataSource {
  TicketDataSource({required SupabaseClient client}) : _client = client;

  final SupabaseClient _client;

  Future<TicketModel> create({required int eventId}) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();

    final have = await _client
        .from('event_user')
        .select()
        .eq('event_id', eventId)
        .eq('user_id', user.id);

    if (have.isNotEmpty) {
      final value = have.firstOrNull;
      throw HaveTicketException(
        ticketId: value?['id'] as int
      );
    }

    final result = await _client.from('event_user').insert({
      'user_id': user.id,
      'event_id': eventId,
    }).select(
        'id, user_id, event_id, events(*, event_image(*), place:places(*))');

    return result
        .map((value) => TicketModel(
              id: value['id'] as int,
              userId: value['user_id'] as String,
              eventId: value['event_id'] as int,
              event: EventDTO.fromJson(value['events'] as Map<String, Object?>)
                  .toModel(),
            ))
        .toList()
        .first;
  }

  Future<List<TicketModel>> get() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();
    try {
      final result = await _client
          .from('event_user')
          .select(
              'id, user_id, event_id, events!inner(*, event_image(*), place:places(*))')
          .eq('user_id', user.id)
          .gt('events.holded_at',
              DateTime.now().subtract(Duration(days: 5)).toIso8601String());
      return result
          .map((value) => TicketModel(
                id: value['id'] as int,
                userId: value['user_id'] as String,
                eventId: value['event_id'] as int,
                event: EventDTO.fromJsonOrNull(
                        value['events'] as Map<String, Object?>?)
                    ?.toModel(),
              ))
          .toList();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<TicketModel> getById(int id) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();
    try {
      final result = await _client
          .from('event_user')
          .select(
              'id, user_id, event_id, events!inner(*, event_image(*), place:places(*))')
          .eq('user_id', user.id)
          .eq('id', id);
      return result
          .map((value) => TicketModel(
                id: value['id'] as int,
                userId: value['user_id'] as String,
                eventId: value['event_id'] as int,
                event: EventDTO.fromJsonOrNull(
                        value['events'] as Map<String, Object?>?)
                    ?.toModel(),
              ))
          .toList()
          .first;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}

class HaveTicketException implements Exception {
  HaveTicketException({required this.ticketId});

  final int ticketId;
}
