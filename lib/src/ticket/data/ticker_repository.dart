import 'dart:async';

import 'package:dvizh_mob/src/ticket/data/ticker_data_source.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

class TicketRepository {
  TicketRepository({required TicketDataSource dataSource}) : _dataSource = dataSource, _controller = StreamController<TicketEvent>.broadcast();

  final TicketDataSource _dataSource;
  final StreamController<TicketEvent> _controller;

  Stream<TicketEvent> get stream => _controller.stream;

  Future<TicketModel> create({required int eventId}) => _dataSource.create(eventId: eventId);

  Future<List<TicketModel>> get() => _dataSource.get();

  Future<TicketModel> getById(int id) => _dataSource.getById(id);

  Future<void> cancel(int id) async {
    await _dataSource.cancel(id);
    _controller.add(CancelTicketEvent(ticketId: id));
  }



}