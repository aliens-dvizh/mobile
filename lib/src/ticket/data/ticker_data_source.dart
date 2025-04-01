import 'dart:async';


import 'package:dvizh_mob/src/ticket/data/exceptions/have_ticket_exception.dart';
import 'package:dvizh_mob/src/ticket/dto/ticket_dto.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketDataSource {
  TicketDataSource( {required SupabaseClient client}) : _client = client;

  final SupabaseClient _client;

  Future<TicketModel> create({required int eventId}) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();

    final have = await _client
        .from('tickets')
        .select()
        .eq('event_id', eventId)
        .eq('user_id', user.id);

    if (have.isNotEmpty) {
      final value = have.firstOrNull;
      throw HaveTicketException(ticketId: value?['id'] as int);
    }

    final result = await _client.from('tickets').insert({
      'user_id': user.id,
      'event_id': eventId,
    }).select(
        'id, user_id, event_id, event:events(*, event_image(*), place:places(*))');

    return result
        .map((value) => TicketDto.fromJson(value).toModel())
        .toList()
        .first;
  }

  Future<List<TicketModel>> get() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();
    try {
      final result = await _client
          .from('tickets')
          .select('*, event:events!inner(*, event_image(*), place:places(*))')
          .eq('user_id', user.id)
          .gt(
              'events.holded_at',
              DateTime.now()
                  .subtract(const Duration(days: 5))
                  .toIso8601String());

      print(result);
      return result
          .map((value) => TicketDto.fromJson(value).toModel())
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
          .from('tickets')
          .select('*, event:events!inner(*, event_image(*), place:places(*))')
          .eq('user_id', user.id)
          .eq('id', id);
      return result
          .map((value) => TicketDto.fromJson(value).toModel())
          .toList()
          .first;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> cancel(int id) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception();
    try {
      final result = await _client
          .from('tickets')
          .update({
            'status': TicketStatus.canceled.name,
          })
          .eq('id', id)
          .select('*, event:events!inner(*, event_image(*), place:places(*))');
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}

sealed class TicketEvent {}

final class CancelTicketEvent extends TicketEvent {
  CancelTicketEvent({required this.ticketId});

  final int ticketId;
}